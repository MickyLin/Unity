using UnityEngine;
using System.Collections;

public class InputKey : MonoBehaviour {


	public GameObject SkillUI;
	private SkillItem item;


	// Use this for initialization
	void Start () {

	
	}
	
	// Update is called once per frame
	void Update () {



		if(Input.GetKeyDown(KeyCode.K))
		{
			//bool enable=!SkillUI.activeSelf;

			SkillUI.SetActive (!SkillUI.activeSelf);
			//item.UpdateShow ();
		}

	
	}
}
