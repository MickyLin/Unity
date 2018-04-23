using UnityEngine;
using System.Collections;

public class UIPlay : UIHandler  {

	UIEventListener lis;

	public UISprite playBtn;
	public UISprite QuitWin;
	void Start () {
		lis =AddComponentByName <UIEventListener >("SmallPlayBtn");
		lis .onClick =OnPlayBtn;

		lis =AddComponentByName <UIEventListener >("HomeBtn");
		lis .onClick =OnHomeBtn;
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	void OnPlayBtn (GameObject obj) {
		Application .LoadLevel("SelectLevel");
	}
	void OnHomeBtn (GameObject obj) {
		playBtn.active=false ;
		QuitWin .active=true ;

		lis =AddComponentByName <UIEventListener >("Not");
		lis .onClick =OnNotBtn;

		lis =AddComponentByName <UIEventListener >("Yes");
		lis .onClick =OnYesBtn;
	}
	void OnNotBtn(GameObject obj){
		playBtn.active=true  ;
		QuitWin .active=false  ;
	}
	void OnYesBtn(GameObject obj){
		Application .Quit ();
	}
}
