using UnityEngine;
using System.Collections;

public class FunctionBar : MonoBehaviour 
{
	public void OnStatusBtnClick()
	{

	}

	public void OnEquipBtnClick()
	{


	}

	public void OnBagBtnClcik()
	{

	}

	public void OnSKillBtnClick()
	{
		SkillUI._instance.gameObject.SetActive (!SkillUI._instance.gameObject.activeSelf);

	}

	public void OnSysBtnClick()
	{

	}

}
