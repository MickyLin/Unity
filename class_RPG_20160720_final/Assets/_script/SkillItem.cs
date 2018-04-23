using UnityEngine;
using System.Collections;

public class SkillItem : MonoBehaviour {


	//public static SkillItem _instance;
	public int id;
	private SkillInfo info;

	private UISprite iconname_sprite;
	private UILabel name_label;
	private UILabel applytype_label;
	private UILabel des_label;
	private UILabel mp_label;
	private GameObject skill_icon_mask;//icon的遮罩
	
	void Awake()
	{
		//_instance = this;
	}
	
	// Use this for initialization
	void Start () {
		
		
	}
	
	// Update is called once per frame //   f(x,y)=3x+6y+9
	//x=7;
	//this.x=8;
	//y=8;
	//求f(x,y)=78
	
	void Update () {
		
	}
	
	
	
	void IniProperty()//技能屬性
	{
		iconname_sprite = transform.Find ("skill_icon").GetComponent<UISprite>();
		name_label=transform.Find("property/name_bg/name").GetComponent<UILabel>();
		applytype_label=transform.Find("property/applytype_bg/applytype").GetComponent<UILabel>();
		des_label=transform.Find("property/des_bg/des").GetComponent<UILabel>();
		mp_label=transform.Find("property/mp_bg/bg").GetComponent<UILabel>();
		skill_icon_mask=transform.Find("skill_icon_mask").gameObject;
		skill_icon_mask.SetActive (false);//默認是不顯示的
	}
	
	public void UpdateShow(int level)
	{
		if (info.level <= level) 
			{
				skill_icon_mask.SetActive (false);
				iconname_sprite.GetComponent<SkillItemIcon> ().enabled = true;//可拖動的skillitem
			} 
			else 
			{
				skill_icon_mask.SetActive (true);
				iconname_sprite.GetComponent<SkillItemIcon> ().enabled = false;//不可拖動的skillitem	
			}
	}



	public void SetID(int id)
	{
		IniProperty ();//先初始化
		this.id = id;
		info = SkillsInfo._instance.GetSkillInfoByID (id);//透過SKillsInfo查找到GetSkillInfoByID
		iconname_sprite.spriteName = info.icon_name;//透過icon名稱找到icon
		name_label.text = info.name;
		switch (info.applyType) 
		{
			case ApplyType.Passive:
					applytype_label.text="增益";
					break;
			case ApplyType.Buff:
					applytype_label.text="增強";
					break;
			case ApplyType.SingleTarget:
					applytype_label.text="單個目標";
					break;
			case ApplyType.MultiTarget:
					applytype_label.text="多個目標";
					break;
		}
		des_label.text = info.des;
		mp_label.text=info.mp+"MP";
	}


}
