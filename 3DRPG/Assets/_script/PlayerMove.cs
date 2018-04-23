using UnityEngine;
using System.Collections;

public enum ControlWalkState//列舉走路

{
	Moving,
	Idle
}



public class PlayerMove : MonoBehaviour {

	public ControlWalkState state = ControlWalkState.Idle;
	public float speed;
	private PlayerDir dir;
	private CharacterController controller;
	public bool isMoving =false;
	private PlayerAttack attack;


	void Start () 
	{
		dir = this.GetComponent<PlayerDir> ();

		controller = this.GetComponent<CharacterController> ();

		attack = this.GetComponent<PlayerAttack> ();
	}
	
	// Update is called once per frame
	void Update () 
	{
		if(attack.state == PlayerState.ControlWalk)
		{

			float distance = Vector3.Distance (dir.targetPosition,transform.position);//目標距離與主角之間的距離
			if (distance > 0.5f) 
			{
					isMoving=true;	
					state = ControlWalkState.Moving;
					controller.SimpleMove (transform.forward * speed);		
			} 
			else {
					isMoving=false;	
					state = ControlWalkState.Idle;
				 }
		}
	}


	public void SimpleMove(Vector3 targetPos)//指定一個目標位置
	{
		transform.LookAt (targetPos);
		controller.SimpleMove (transform.forward * speed);
	}
}
