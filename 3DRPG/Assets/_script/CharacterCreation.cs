using UnityEngine;
using System.Collections;

public class CharacterCreation : MonoBehaviour {


	public GameObject[] characterPrefabs;//陣列存所有腳色的prefab
	 GameObject[] characterGameObjects;//陣列prefab創立出來的gameobject
	 int selectedIndex =0;// 腳色的編號
	 int length;//腳色可供選擇的個數
	public UIInput nameInput;
	// Use this for initialization
	void Start () 
	{
		length = characterPrefabs.Length;//初始化個數
		characterGameObjects = new GameObject[length];//new一個新的GameObject[]
		for(int i=0;i<length;i++)//for循環查詢(遍歷)每一個被創立出來的角色
		{
			characterGameObjects[i]=GameObject.Instantiate(characterPrefabs[i],transform.position,transform.rotation)as GameObject;
		}

		UpdateCharacterShow ();
	}

	void UpdateCharacterShow()//更新所有角色的顯示(自定義方法)
	{
		characterGameObjects [selectedIndex].SetActive (true);//選到的編號顯示
		for(int i=0;i<length;i++)//用for循環查詢每一個被創立出來的角色
		{
			if(i!=selectedIndex)//沒有選到的編號隱藏
			{
				characterGameObjects [i].SetActive (false);
			}
		}
	}

	public void OnNextButtonClick()//點擊下一個按鈕
	{
		selectedIndex++;
		selectedIndex = selectedIndex % length;//2個相除是0餘數0,取餘數
		//selectedIndex%=length;
		//a=a+b;  a+=b;
		UpdateCharacterShow ();
	}
	public void OnPrevButtonClick()//點擊上一個按鈕
	{
		selectedIndex--;
		if (selectedIndex == -1) 
		{
			selectedIndex=length-1;	//用數量去減1重新賦值
		}
		UpdateCharacterShow ();
	}
	public void OnOkButtonClick()
	{
		PlayerPrefs.SetInt ("SelectedCharacterIndex",selectedIndex);//儲存選擇的角色
		PlayerPrefs.SetString ("name",nameInput.value);//儲存輸入的名字
		Application.LoadLevel (2);//加載下一個場景
        PlayerPrefs.Save();
	}


}
