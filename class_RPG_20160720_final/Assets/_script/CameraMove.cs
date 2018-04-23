using UnityEngine;
using System.Collections;

public class CameraMove : MonoBehaviour 
{

	public float speed = 10;//camera之速度
	public float endZ = -20;//camera的結束之變數條件


	
	// Update is called once per frame
	void Update () 
	{
		if(transform.position.z<endZ)//條件
		{
			transform.Translate(Vector3.forward*speed*Time.deltaTime);
		}
	
	}
}
