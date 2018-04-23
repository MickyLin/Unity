using UnityEngine;
using System.Collections;

public enum HeroType
{
	Swordman,
	Magician
}


 
public class PlayerStatus : MonoBehaviour 
{
    public static PlayerStatus _instance;
    public HeroType heroType;
	public string name="默認名稱";
	public int level=1;//100+level*30-->升級的規則(達到下一等級所需要的經驗值)
	public int hp=100;
	public float hp_remain=100;//100/100//剩餘的血量
	public int mp=100;
	public float mp_remain = 100;//剩餘的法量
	public float exp = 0;
	
    public float attack = 20;//攻擊力
	public float def = 20;//防禦力
    public float speed = 20;//速度


    void Awake()
    {
		PlayerPrefs.Save();
		_instance = this;
    }
    
    // Use this for initialization
	void Start () 
	{
		GetExp (0);
	}
	
	// Update is called once per frame
	void Update () {
	
	}

    //獲得治療
    public void GetDrug(int hp, int mp)
    {
        hp_remain += hp;
        mp_remain += mp;
        if (hp_remain > this.hp)
        {
            hp_remain = this.hp;
        }
        if (mp_remain > this.mp)
        {
            mp_remain = this.mp;
        }
        HeadStatusUI._instance.UpdateShow();//更新血條
    }

    //玩家獲得經驗
    public void GetExp(int exp)
	{
		this.exp += exp;
		int total_exp = 100 + level * 30;
		while(this.exp >= total_exp)
		{
			this.level++;
			this.exp = this.exp-total_exp;
			total_exp = 100 + level * 30;//當不升級就跳出循環
		}
		ExpBar._instance.SetValue (this.exp/total_exp);
        HeadStatusUI._instance.UpdateShow();
	}

    //玩家獲得MP
    public bool TakeMP(int count)
    {
        if (mp_remain >= count)
        {
            mp_remain -= count;
            HeadStatusUI._instance.UpdateShow();
            return true;
        }
        else 
        {
            return false;
        }
    }
}
