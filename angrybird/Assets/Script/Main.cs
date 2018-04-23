using UnityEngine;
using System.Collections;

public class Main : MonoBehaviour {

	float startTime;
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		startTime +=Time .deltaTime ;
		if (startTime >3){
			Application .LoadLevel ("Play");
		}
	}
}
