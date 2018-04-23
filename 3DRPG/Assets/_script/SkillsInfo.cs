using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class SkillsInfo : MonoBehaviour 
{





	public static SkillsInfo _instance;//單例
	public TextAsset skillInfoText;

	private Dictionary<int,SkillInfo> skillInfoDict = new Dictionary<int,SkillInfo>(); //使用泛型重new一個新的字典方法





	void Awake()
	{
		_instance = this;//賦值
		InitSkillInfoDict ();

	}


	public SkillInfo GetSkillInfoByID(int id)//根據id查找一個技能資訊
	{
		SkillInfo info = null;
		skillInfoDict.TryGetValue (id,out info);//得到id 把資訊存到哪邊
		return info;
	}



	void InitSkillInfoDict()//初始化技能資訊字典
	{
		string text = skillInfoText.text;
		string[] skillInfoArray = text.Split ('\n');//根據換行去分割
		foreach(string skillInfoStr in  skillInfoArray)
		{
			//string[] proarray
			string[] pa = skillInfoStr.Split(',');//根據逗號分割
			SkillInfo info = new SkillInfo();//new一個skillInfo對象
			info.id=int.Parse(pa[0]);//字串陣列轉整數
			info.name=pa[1];
			info.icon_name=pa[2];
			info.des=pa[3];
			string str_applytype=pa[4];
			switch(str_applytype)//抽籤 誰被抽到 誰就離開這個條件判斷
			{
				case"Passive":
					info.applyType =ApplyType.Passive;
					break;
				case"Buff":
						info.applyType=ApplyType.Buff;
					break;
				case"SingleTarget":
						info.applyType=ApplyType.SingleTarget;
					break;
				case"MultiTarget":
						info.applyType=ApplyType.MultiTarget;
					break;
			}
			string str_applypro=pa[5];
			switch(str_applypro)
			{
				case"Attack":
					info.applyPro=ApplyProperty.Attack;
					break;
				case"Def":
					info.applyPro=ApplyProperty.Def;
					break;
				case"Speed":
					info.applyPro=ApplyProperty.Speed;
					break;
				case"AttackSpeed":
					info.applyPro=ApplyProperty.AttackSpeed;
					break;
				case"HP":
					info.applyPro=ApplyProperty.HP;
					break;
				case"MP":
					info.applyPro=ApplyProperty.MP;
					break;

			}
			info.applyValue=int.Parse(pa[6]);//作用植
			info.applyTime=int.Parse(pa[7]);//
			info.mp=int.Parse(pa[8]);
			info.coldTime=int.Parse(pa[9]);

			string str_applicableRole=pa[10];
			switch(str_applicableRole)
			{
				case"Swordman":
					info.applicableRole=ApplicableRole.Swordman;
					break;
				case"Magician":
					info.applicableRole=ApplicableRole.Magician;
					break;
			}
			info.level=int.Parse(pa[11]);

			string str_releaseType=pa[12];
			switch(str_releaseType)
			{
				case"Self":
					info.releaseType=ReleaseType.Self;
					break;
				case"Enemy":
					info.releaseType=ReleaseType.Enemy;
					break;
				case"Position":
					info.releaseType=ReleaseType.Position;
					break;
			}
			info.distance = float.Parse (pa[13]);
			info.efx_name = pa[14];
			info.aniname = pa[15];
			info.anitime = float.Parse (pa[16]);
			skillInfoDict.Add(info.id,info);//把info添加到字典裡
		}
	}
}


public class SkillInfo
{
	public int id;
	public string name;
	public string icon_name;
	//public string description;
	public string des;
	public ApplyType applyType;
	//public ApplyProperty applyProperty;
	public ApplyProperty applyPro;
	public int applyValue;//作用值
	public int applyTime;//作用時間
	public int mp;
	public int coldTime;
	public ApplicableRole applicableRole;//適用角色
	public int level;//適用等級
	public ReleaseType releaseType;//釋放類型
	public float distance;//釋放距離
	public string efx_name;//特效名稱
	public string aniname;//動畫名稱
	public float anitime=0;//動畫時間
 
         
}



public enum ApplicableRole//適用角色
{
	Swordman,
	Magician
}

public enum ApplyType//作用類型
{
	Passive,
	Buff,
	SingleTarget,
	MultiTarget
	
}
public enum ApplyProperty//作用屬性
{
	Attack,
	Def,
	Speed,
	AttackSpeed,
	HP,
	MP
}
public enum ReleaseType//釋放類型
{
	Self,
	Enemy,
	Position
}

