using UnityEngine;
using System.Collections;

public class HeadStatusUI : MonoBehaviour {
	
	
	public static HeadStatusUI _instance;
		
    private UILabel name;
	private UISlider hpBar;//血條
	private UISlider mpBar;//法量條
	private UILabel hpLabel;//hp的數值
	private UILabel mpLabel;//mp的數值
   

	private PlayerStatus ps;
	// Use this for initialization
	
	
	void Awake()
	{
		_instance = this;
		name = transform.Find ("Name").GetComponent<UILabel> ();
        hpLabel = transform.Find("HP/Label").GetComponent<UILabel>();
		mpLabel=transform.Find ("MP/Thumb/Label").GetComponent<UILabel> ();
		hpBar=transform.Find("HP").GetComponent<UISlider> ();
		mpBar=transform.Find("MP").GetComponent<UISlider> ();
     
	}



	void Start () 
	{
        ps = GameObject.FindGameObjectWithTag(Tags.player).GetComponent<PlayerStatus>();
        UpdateShow();
      
		
	}
	

	public void UpdateShow()
	{
		name.text = "LV." + ps.level + " "+ps.name;
		hpBar.value = ps.hp_remain / ps.hp;//剩餘的血量/總血量
		mpBar.value = ps.mp_remain / ps.mp;//剩餘的法量/總法量
		hpLabel.text = ps.hp_remain + "/" + ps.hp;
		mpLabel.text = ps.mp_remain + "/" + ps.mp;
	
		
	}
}
