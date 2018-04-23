using UnityEngine;
using System.Collections;


public enum WolfState 
{
	Idle,
	Walk,
	Attack,
	Death
}



public class WolfBaby : MonoBehaviour {

	public WolfState state = WolfState.Idle;
	public string aniname_idle;
	public string aniname_walk;
	//public string aniname_attack;
	public string aniname_death;
	public string aniname_now;
	public float time;//動作持續時間
	public float timer;//計時器,時間到就換下一個動作
	public AudioClip miss_sound;//miss的音效

	private CharacterController cc;//小狼控制器
	public float speed=1;

	public int hp =100;//血量
	public float miss_rate = 0.2f;//玩家打5次,有一1次會Miss

	private Color normal;
	public GameObject body;
	//private GameObject body;

	private GameObject hudtextFollow;
	private GameObject hudtextGo;
	public GameObject hudtextPrefab;

	private HUDText hudtext;
	private UIFollowTarget followTarget;

	public string aniname_normalattack;
	public float time_normalattack;//播放時間
	public string aniname_crazyattack;
	public float time_crazyattack;//播放時間
	public float crazyattack_rate;//瘋狂攻擊處發機率

	public string aniname_attack_now;

	public float attack_rate = 2;//攻擊速率
	public float attack_timer;

	public Transform target;
	public float minDistance = 2;
	public float maxDistance = 5;
	public int attack =10;

	public WolfSpawn spawn;
	public int exp = 20;//經驗值
	private PlayerStatus ps;





	// Use this for initialization

	void Awake()
	{
		aniname_now = aniname_idle;
		cc=this.GetComponent<CharacterController>();
		//body = transform.Find ("Wolf_Baby").gameObject;
		normal = body.renderer.material.color;
		hudtextFollow = transform.Find ("HUDText").gameObject;//跟隨
      
	}


	void Start () {
		hudtextGo = NGUITools.AddChild (HUDTextParent._instance.gameObject, hudtextPrefab);
		hudtext = hudtextGo.GetComponent<HUDText> ();//獲取到prefab上面的HUDText腳本
		followTarget = hudtextGo.GetComponent<UIFollowTarget> ();
		followTarget.target = hudtextFollow.transform;
		followTarget.gameCamera = Camera.main;

        ps = GameObject.FindGameObjectWithTag(Tags.player).GetComponent<PlayerStatus>();

	}
	
	// Update is called once per frame
	void Update () 
	{
		if(state == WolfState.Death)//死亡
		{
			animation.CrossFade(aniname_death);//播放死亡動畫
		}
		else if(state == WolfState.Attack)//自動攻擊
		{
			AutoAttack();
		}
		else//巡邏
		{
			animation.CrossFade(aniname_now);//播放當前的動畫
			if(aniname_now == aniname_walk)
			{
				cc.SimpleMove(transform.forward * speed);
			}
			timer=timer+Time.deltaTime;
			if(timer>=time)//計時結束,切換動畫
			{
				timer = 0;
				RandomState();
			}
			
		}

	}

	void RandomState()
	{
		int value = Random.Range (0,2);
		if(value == 0)
		{
			aniname_now = aniname_idle;
		}
		else
		{
			if(aniname_now != aniname_walk)
			{
				transform.Rotate(transform.up*Random.Range(0,360));
			}

			aniname_now = aniname_walk;
		}
	}
    //受到攻擊
	public void TakeDamage(int attack)
	{
		if (state == WolfState.Death)return;
		state = WolfState.Attack;				
		target = GameObject.FindGameObjectWithTag (Tags.player).transform;//攻擊玩家


		float value = Random.Range (0f,1f);
		if(value < miss_rate)//Miss效果
		{
			AudioSource.PlayClipAtPoint(miss_sound,transform.position);
			hudtext.Add("Miss",Color.gray,1);
		}
		else// 打中的效果
		{
			hudtext.Add("-"+attack,Color.red,1);
			this.hp = this.hp-attack;
			StartCoroutine(ShowBodyRed());
			if(hp<0)
			{
				state = WolfState.Death;
				Destroy (this.gameObject, 2);
			}
		}
	}


	IEnumerator ShowBodyRed()//小郎受到傷害變色
	{
		body.renderer.material.color=Color.red;
		yield return new WaitForSeconds(0.2f);
		body.renderer.material.color=normal;
	}



	void AutoAttack()//小狼自動攻擊
	{
		if(target!=null)//目標存在,以及判斷距離
		{
            PlayerState playerState = target.GetComponent<PlayerAttack>().state;
            if (playerState == PlayerState.Death)
            {
                target = null;
                state = WolfState.Idle; return;
            }
            float distance = Vector3.Distance(target.position,transform.position);
			if(distance > maxDistance)
			{
				target = null;//沒有目標
				state = WolfState.Idle;
			}
			else if(distance < minDistance)//自動攻擊
			{
				attack_timer+=Time.deltaTime;
               transform.LookAt(target);//面向玩家角色
				animation.CrossFade(aniname_attack_now);//播放攻擊動畫

				if(aniname_attack_now == aniname_normalattack)//正常攻擊
				{
					if(attack_timer > time_normalattack)//記時器>正常攻擊時間
					 {
						//動畫結束,產生傷害
						target.GetComponent<PlayerAttack>().TakeDamage(attack);
						print ("玩家受到傷害");
						aniname_attack_now=aniname_idle;
					 }
                }
				else if(aniname_attack_now == aniname_crazyattack)
					{
						if(attack_timer > time_crazyattack)
						{
							//動畫結束,產生傷害
							target.GetComponent<PlayerAttack>().TakeDamage(attack);
							print ("玩家受到傷害");
							aniname_attack_now = aniname_idle;
						}
					}
				
				//攻擊玩家
				if(attack_timer > 1f/attack_rate)
				{
					RandomAttack();
					attack_timer = 0;
				}

			}
			else//朝著腳色移動
			{
				transform.LookAt(target);//面向玩家角色
				cc.SimpleMove(transform.forward*speed);//移動
				animation.CrossFade(aniname_walk);
			}

		}

		else
		{
			state = WolfState.Idle;
		}
      }

	void RandomAttack()//隨機攻擊
	{
		float value = Random.Range (0f,1f);
		if(value < crazyattack_rate)
		{
			aniname_attack_now = aniname_crazyattack;
		}
		else
		{
			aniname_attack_now = aniname_normalattack;
		}

	}


    void OnDestroy()//銷毀文字&小狼
    {
        spawn.MinusNumber();//
        ps.GetExp(exp);//獲得經驗
        GameObject.Destroy(hudtextGo);
    }

	void OnMouseEnter()//當滑鼠進入collider
	{
        if (PlayerAttack._instance.isLockingTarget == false)
        {
            CursorManager._instance.SetAttack();
        }
	}
	void OnMouseExit()//當滑鼠離開collider
	{
        if (PlayerAttack._instance.isLockingTarget == false)
        {
            CursorManager._instance.SetNormal();
        }
	}
}
