using UnityEngine;
using System.Collections;

public class PlayMove : MonoBehaviour {
	float speed=0.2f;

	void Start () {
	
	}
	

	void Update () {
		transform .Translate (Vector3 .left *speed *Time .deltaTime );
		if (transform .position .x <-2.96f){
			transform .position =new Vector3 (3.1f,transform .position .y ,transform .position .z );
		}
	}
}
