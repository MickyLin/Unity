using UnityEngine;
using System.Collections;

public class RotateSelf : MonoBehaviour {

	public float speed = 180;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		transform.Rotate(Vector3.up*speed *Time.deltaTime);
	}

	public void OnValueChange(float value){
		speed = value;
	}
}
