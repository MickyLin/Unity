using UnityEngine;
using System.Collections;
using System.Collections.Generic;


public enum PlayerState
{
	ControlWalk,
	NormalAttack,
	SkillAttack,
	Death

}

public enum AttackState
{
	Moving,
	Idle,
	Attack 

}




public class PlayerAttack : MonoBehaviour 
{
	public static PlayerAttack _instance;

	public PlayerState state = PlayerState.ControlWalk;
	public AttackState attack_state = AttackState.Idle; 

	public string aniname_normalattack;//普攻
	public float time_normalattack;//普攻時間
	private float timer=0;//計時器,時間到就換下一個動作
	public float min_distance = 5;//默認的最小攻擊距離(戰士攻擊距離較短)
	private Transform target_normalattack;//記錄目標
    private Transform target_skillattack;//紀錄技能攻擊目標

	private PlayerMove move;//取得playerMove腳本

	public string aniname_idle;
	public string aniname_now;
	public float rate_normalattack = 1;//普攻之速率

	public GameObject effect;
	private bool showEffect = false;
	private PlayerStatus ps;

	public float miss_rate = 0.25f;//敵人打4次,有一1次會Miss
	public GameObject hudtextPrefab;//實體化之預置物
	private GameObject hudtextFollow;//跟隨
	private GameObject hudtextGo;//用來顯示
	private HUDText hudtext;//取得腳本
	public GameObject body;
	private Color normal;
	public string aniname_death;//死亡動畫名稱

    public GameObject[] efxArray;//特效陣列
    private Dictionary<string, GameObject> efxDict = new Dictionary<string, GameObject>();

    public bool isLockingTarget = false;//是否正在選擇目標
    private SkillInfo info = null;
	public AudioClip miss_sound;//miss的音效
	public AudioClip onmultitargetskill_sound;//多重攻擊的音效
	public AudioClip onetargetskill_sound;//單體攻擊的音效
	public AudioClip heal_sound;//補血的音效
	public AudioClip buff_sound;//buff的音效


	void Awake()
	{
		_instance = this;
		move = this.GetComponent<PlayerMove>();
		ps = this.GetComponent<PlayerStatus>();
		normal = body.renderer.material.color;
        hudtextFollow = transform.Find("HUDText").gameObject;//跟隨

        foreach (GameObject go in efxArray)
        {
            efxDict.Add(go.name, go);//根據名字找到相對應的特效prefab
        }
	}


	void Start()
	{
        hudtextGo = NGUITools.AddChild(HUDTextParent._instance.gameObject, hudtextPrefab);
        hudtext = hudtextGo.GetComponent<HUDText>();//獲取到prefab上面的HUDText腳本
        UIFollowTarget followTarget = hudtextGo.GetComponent<UIFollowTarget>();
        followTarget.target = hudtextFollow.transform;
        followTarget.gameCamera = Camera.main;
	}

	void Update()
	{
		if(isLockingTarget==false&&Input.GetMouseButtonDown(0)&& state!= PlayerState.Death)
		{
			Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
			RaycastHit hitInfo;
			bool isCollider = Physics.Raycast(ray,out hitInfo);
			if(isCollider && hitInfo.collider.tag == Tags.enemy)
			{
				//當點擊了一個敵人的時後
				target_normalattack = hitInfo.collider.transform;//取得攻擊的敵人(從hitinfo去取)
				state = PlayerState.NormalAttack;//進入普攻模式
				timer=0; showEffect = false;
			}
			else
			{
				state = PlayerState.ControlWalk;
				target_normalattack = null;
			}
		}

		if(state == PlayerState.NormalAttack)//普攻
		{
			if(target_normalattack == null)
			{
				state = PlayerState.ControlWalk;
			}
			else
			{
				float distance = Vector3.Distance(transform.position,target_normalattack.position);//先取得主角和敵人之間距離
				if(distance < min_distance)//進行攻擊
				{
					transform.LookAt(target_normalattack.position);//面向敵人位置
					attack_state = AttackState.Attack;

					timer += Time.deltaTime;//根據計時器判斷當前狀態
					animation.CrossFade(aniname_now);//動畫播放
					if(timer >= time_normalattack)
					{
						aniname_now = aniname_idle;

						if(showEffect == false)
						{
							showEffect = true;//播放特效
							GameObject.Instantiate(effect,target_normalattack.position,Quaternion.identity);
							target_normalattack.GetComponent<WolfBaby>().TakeDamage(GetAttack());
						}
					}
					if(timer >= (1f/rate_normalattack))
					{
						timer = 0;showEffect = false;

						aniname_now = aniname_normalattack;
					}
					
				}
				else//走向敵人
				{
					attack_state = AttackState.Moving;
					move.SimpleMove (target_normalattack.position);//回playerAnimation
				}
			}
		}
        else if (state == PlayerState.Death)
        {//如果死亡就播放死亡动画
            animation.CrossFade(aniname_death);
        }

        if (isLockingTarget && Input.GetMouseButtonDown(0))
        {
           
            OnLockTarget();
         
        }
	}
	public int GetAttack()
	{
		return(int)(ps.attack) ;
        print("痛");
	}

    //玩家受到攻擊
	public void TakeDamage(int attack)
	{
		if(state == PlayerState.Death) return;//死亡就不做任何動作

		float def = ps.def;
		float temp = attack*((200-def)/200);//當def大於200 可把所有傷害抵銷
        print("有");
        if(temp < 1)temp=1;
		
		float value = Random.Range (0f,1f);
        if (value < miss_rate)//Miss效果
		{
			AudioSource.PlayClipAtPoint(miss_sound,transform.position);
			hudtext.Add("MISS", Color.gray, 1);
            print("玩家顯示MISS");
        }
        else// 打中的效果
         {
                hudtext.Add("-" + temp,Color.red,1);//減多少血
			    ps.hp_remain -=  (int)temp;
			    StartCoroutine(ShowBodyRed());
			    if(ps.hp_remain <= 0)
			    {
				    state = PlayerState.Death;
			    }
          }
		HeadStatusUI._instance.UpdateShow ();

	}

	IEnumerator ShowBodyRed()
	{
		body.renderer.material.color = Color.red;
		yield return new WaitForSeconds(0.2f);
		body.renderer.material.color = normal;
	}

    //銷毀血條
    void OnDestroy() 
    {
        GameObject.Destroy(hudtextGo);
    }

   //使用技能把技能訊息傳過來
    public void UseSkill(SkillInfo info)
    { 
        if(ps.heroType ==HeroType.Magician)
        {
            if(info.applicableRole == ApplicableRole.Swordman)
            {
                return;
             }
        }
        if(ps.heroType ==HeroType.Swordman)
        {
            if (info.applicableRole == ApplicableRole.Magician)
            {
                return;
            }
        }
        switch (info.applyType)
        {
            case ApplyType.Passive:// 增益
                StartCoroutine(OnPassiveSkillUse(info));
                break;
            case ApplyType.Buff://增強
                StartCoroutine(OnBuffSkillUse(info));
                break;
            case ApplyType.SingleTarget:// 單一目標
                OnSingleTargetSkillUse(info);           
                break;
            case ApplyType.MultiTarget:
                OnMultiTargetSkillUse(info);
                break;
        }
    }

    //處理增益技能
    IEnumerator OnPassiveSkillUse(SkillInfo info)
    {
        state = PlayerState.SkillAttack;//技能攻擊狀態賦值
        animation.CrossFade(info.aniname);//播放動畫
        yield return new WaitForSeconds(info.anitime);
        state = PlayerState.ControlWalk;
        int hp = 0, mp = 0;
        if (info.applyPro == ApplyProperty.HP)
        {
            hp = info.applyValue;
        }
        else if(info.applyPro == ApplyProperty.MP)
        {
            mp = info.applyValue;
        }
        ps.GetDrug(hp, mp);
		//產生實體特效
		GameObject prefab = null;//臨時變數
		AudioSource.PlayClipAtPoint(heal_sound,transform.position);
		efxDict.TryGetValue(info.efx_name, out prefab);//把得到的值放到prefab裡面
        GameObject.Instantiate(prefab, transform.position, Quaternion.identity);
    }
  
    //處理增強技能
    IEnumerator OnBuffSkillUse(SkillInfo info)
    {
        state = PlayerState.SkillAttack;//技能攻擊狀態賦值
        animation.CrossFade(info.aniname);//播放動畫
        yield return new WaitForSeconds(info.anitime);
        state = PlayerState.ControlWalk;

        //產生實體特效
        GameObject prefab = null;
        efxDict.TryGetValue(info.efx_name, out prefab);
        GameObject.Instantiate(prefab, transform.position, Quaternion.identity);
		AudioSource.PlayClipAtPoint(buff_sound,transform.position);

        switch (info.applyPro)
        {
            case ApplyProperty.Attack:
                ps.attack *= (info.applyValue / 100f);
                break;
            case ApplyProperty.AttackSpeed:
                rate_normalattack *= (info.applyValue / 100f);
                break;
            case ApplyProperty.Def:
                ps.def *= (info.applyValue / 100f);
                break;
            case ApplyProperty.Speed:
                move.speed *= (info.applyValue / 100f);
                break;
        }
        yield return new WaitForSeconds(info.applyTime);//作用時間

        switch (info.applyPro)//移除效果
        {
            case ApplyProperty.Attack:
                ps.attack /= (info.applyValue / 100f);
                break;
            case ApplyProperty.AttackSpeed:
                rate_normalattack /= (info.applyValue / 100f);
                break;
            case ApplyProperty.Def:
                ps.def /= (info.applyValue / 100f);
                break;
            case ApplyProperty.Speed:
                move.speed /= (info.applyValue / 100f);
                break;
        }
    }
    
    //處理單個目標攻擊
    void OnSingleTargetSkillUse(SkillInfo info)
    {
        state = PlayerState.SkillAttack;
        CursorManager._instance.SetLockTarget();
        isLockingTarget = true;
        this.info = info;
    }
    void OnLockTarget()
    {
        isLockingTarget = false;
        switch (info.applyType)
        {
            case ApplyType.SingleTarget:
                StartCoroutine(OnLockSingleTarget());
                break;
            case ApplyType.MultiTarget://點擊地面,不需鎖定目標
                StartCoroutine(OnLockMultiTarget());
                break;
        }
    }

    IEnumerator OnLockSingleTarget()
    {
        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        RaycastHit hitInfo;
        bool isCollider = Physics.Raycast(ray, out hitInfo);
        
      
        if (isCollider && hitInfo.collider.tag == Tags.enemy)
        {
            target_skillattack = hitInfo.collider.transform;//取得攻擊的敵人(從hitinfo去取)
            state = PlayerState.SkillAttack;//進入技能攻擊模式
			AudioSource.PlayClipAtPoint(onetargetskill_sound,transform.position);

			float distance = Vector3.Distance(transform.position, target_skillattack.position);//先取得主角和敵人之間距離
            if (distance < min_distance)//進行攻擊
            {
                transform.LookAt(target_skillattack.position);//面向敵人
                animation.CrossFade(info.aniname);
                yield return new WaitForSeconds(info.anitime);
                state = PlayerState.ControlWalk;
                //產生實體特效
                GameObject prefab = null;
                efxDict.TryGetValue(info.efx_name, out prefab);

                GameObject.Instantiate(prefab, hitInfo.collider.transform.position, Quaternion.identity);
                hitInfo.collider.GetComponent<WolfBaby>().TakeDamage((int)(GetAttack() * (info.applyValue / 100f)));
            }
        }
        // 解決bug,沒有點擊任何東西
        else
        {
            state = PlayerState.NormalAttack;
            target_skillattack = null;
        }
        CursorManager._instance.SetNormal();
    }

    //處理多個目標
    void OnMultiTargetSkillUse(SkillInfo info)
    {
        state = PlayerState.SkillAttack;
        CursorManager._instance.SetLockTarget();
        isLockingTarget = true;
        this.info = info;
    }

    IEnumerator OnLockMultiTarget()
    {
        CursorManager._instance.SetNormal();//滑鼠指標設置為normal
        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        RaycastHit hitInfo;
        bool isCollider = Physics.Raycast(ray, out hitInfo,1000,9);//射線距離,第九layer
        if (isCollider && hitInfo.collider.tag == Tags.enemy)
        {
               state = PlayerState.SkillAttack;//進入技能攻擊模式
			AudioSource.PlayClipAtPoint(onmultitargetskill_sound,transform.position);
              if (isCollider)
                {
                    transform.LookAt(hitInfo.point);
                    animation.CrossFade(info.aniname);
                    yield return new WaitForSeconds(info.anitime);
                    state = PlayerState.ControlWalk;
                    //產生實體特效
				    //
                    GameObject prefab = null;
                    efxDict.TryGetValue(info.efx_name, out prefab);
                    GameObject go = GameObject.Instantiate(prefab, hitInfo.point + Vector3.up * 0.5f, Quaternion.identity) as GameObject;
                   go.GetComponent<MagicSphere>().attack = GetAttack() * (info.applyValue / 100f);
                }
            // 解決bug,沒有點擊任何東西
            else
            {
                state = PlayerState.NormalAttack;
            }
        }
    }
}
