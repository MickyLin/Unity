using UnityEngine;
using System.Collections;

public class SkillUI : MonoBehaviour {

	public static SkillUI _instance;

	public int[] magicianSkillIDList;//法師技能列表
	public int[] swordmanSkillIDList;//戰士技能列表
	private PlayerStatus ps;//取得PlayerStatus之引用
	public UIGrid grid;
	public GameObject skillItemPrefab;//持有prefab之引用

	void Awake()
	{
		_instance = this;
        ps = GameObject.FindGameObjectWithTag(Tags.player).GetComponent<PlayerStatus>();
		int[] idList = null;//臨時變數
		switch(ps.heroType)
		{
		case HeroType.Magician:
			idList=magicianSkillIDList;
			break;
		case HeroType.Swordman:
			idList=swordmanSkillIDList;
			break;
		}
		
		foreach(int id in idList )
		{
			GameObject itemGo = NGUITools.AddChild(grid.gameObject,skillItemPrefab);//把skillItemPrefab加入grid裡面
			grid.AddChild(itemGo.transform);//把skillitem交給grid管理
			itemGo.GetComponent<SkillItem>().SetID(id);//呼叫SetID方法來更新skillitem之顯示
		}
		UpdateShow ();

		
	}
	
	void Start () 
	{
      
		this.gameObject.SetActive (false);

	}
	
	// Update is called once per frame
	void Update () 
	{
	
	}

	public void ClosedBtn()
	{
		this.gameObject.SetActive (false);

	}

	void UpdateShow()//當skillitem出現時,要更新技能的顯示
	{
		SkillItem[] items = this.GetComponentsInChildren<SkillItem> ();//從子元件中得到skillitem
		foreach(SkillItem item in items)
		{
			item.UpdateShow(ps.level);
		}
	}
}
