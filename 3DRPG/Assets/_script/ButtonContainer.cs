using UnityEngine;
using System.Collections;

public class ButtonContainer : MonoBehaviour {
	//1.開始場景
	//2.角色選擇界面
	//3.玩家開始打怪的介面,遊戲運行的場景
	public void OnNewGame()
	{
		PlayerPrefs.SetInt ("DataFromSave", 0);
		//Application.LoadLevel ("character_1");
		Application.LoadLevel (1);
        PlayerPrefs.Save();
	}

	public void OnLoadGame()
	{
		PlayerPrefs.GetInt ("DataFromSave", 0);
        Application.LoadLevel(2);
	}

}
