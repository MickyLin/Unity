using UnityEngine;
using System.Collections;

public class PressAnyKey : MonoBehaviour {

	private bool isAnykeyDown = false;
	GameObject buttonContainer;
	// Use this for initialization
	void Start () {

		buttonContainer = this.transform.parent.Find ("btn_container").gameObject;
	}
	
	// Update is called once per frame
	void Update () {
		if (isAnykeyDown == false) 
		{
			if(Input.anyKey)
			{
			   print("我真的暗下了");
				ShowButton();
			}
		}
	}

	void ShowButton()//自定義
	{
		buttonContainer.SetActive(true);
		this.gameObject.SetActive(false);
		isAnykeyDown = true;



	}
}
