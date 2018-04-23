using UnityEngine;
using System.Collections;

public class BirdJump : MonoBehaviour {
	float jumpTime;

	void Start () {
		InvokeRepeating ("Move",2,1.2f);
	}
	
	// Update is called once per frame
	void Update () {
		jumpTime +=Time .deltaTime ;
		if (jumpTime >0.9f){
			transform .eulerAngles =new Vector3 (0,0,Random .Range (-60,60));
			jumpTime=0;
		}
	}
	void Move(){
		transform .rigidbody .velocity =new Vector3 (0,5,0);
	}
}
