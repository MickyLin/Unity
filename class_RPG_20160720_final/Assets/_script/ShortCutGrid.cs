using UnityEngine;
using System.Collections;


public enum ShortCutType
{
	Skill,
	Drug,
	None
}



public class ShortCutGrid : MonoBehaviour {
	private UISprite icon;
	private ShortCutType type = ShortCutType.None;
	private int id; 
	private SkillInfo skillInfo;//保存skillinfo

	public KeyCode keycode;

    private PlayerAttack pa;
    private PlayerStatus ps;

	// Use this for initialization

	void Awake()
	{
		icon = transform.Find ("skillicon").GetComponent<UISprite> ();
		icon.gameObject.SetActive (false);

	}

	void Start () 
	{
        ps = GameObject.FindGameObjectWithTag(Tags.player).GetComponent<PlayerStatus>();
        pa = GameObject.FindGameObjectWithTag(Tags.player).GetComponent<PlayerAttack>();
	}
	
	// Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(keycode))
        {
            if (type == ShortCutType.Skill)
            {
                bool success = ps.TakeMP(skillInfo.mp);//得到該技能需要的mp,從skillInfo取到
                if (success == false)
                {

                }
                else
                {
                    pa.UseSkill(skillInfo);
                }
            }
        }
    }
	

	public void SetSkill(int id)//管理技能
	{
		this.id = id;
		this.skillInfo = SkillsInfo._instance.GetSkillInfoByID (id);
		icon.gameObject.SetActive (true);
		icon.spriteName = skillInfo.icon_name;
		type = ShortCutType.Skill;


	}
}
