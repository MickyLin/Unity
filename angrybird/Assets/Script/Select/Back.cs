using UnityEngine;
using System.Collections;

public class Back : UIHandler  {


	UIEventListener lis;

	void Start () {
		lis =AddComponentByName <UIEventListener >("Back");
		lis .onClick =OnBack;

		lis =AddComponentByName <UIEventListener >("Level1");
		lis .onClick =OnLevel1;

	}
	
	// Update is called once per frame
	void Update () {
		
	}
	void OnBack (GameObject obj) {
		Application .LoadLevel("Play");
	}
	void OnLevel1 (GameObject obj) {
		Application .LoadLevel("Level1");
	}

}
