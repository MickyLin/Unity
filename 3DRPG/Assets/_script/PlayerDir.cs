using UnityEngine;
using System.Collections;

public class PlayerDir : MonoBehaviour {

	public GameObject effect_click_prefab;
	private bool isMoving =false;//表示滑鼠是否暗下
	public Vector3 targetPosition = Vector3.zero;
	private PlayerMove playerMove;
	private PlayerAttack attack;


	// Use this for initialization
	void Start () {
		targetPosition = this.transform.position;
		playerMove=this.GetComponent<PlayerMove>();
		attack = this.GetComponent<PlayerAttack>();
	}
	
	// Update is called once per frame
	void Update () 
	{
		if(attack.state == PlayerState.Death)return;
		if(attack.isLockingTarget==false&&Input.GetMouseButtonDown(0)&&UICamera.hoveredObject==null)
		{
			Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
			RaycastHit hitInfo;//Box box ;
			bool isCollider =Physics.Raycast(ray,out hitInfo);
			if(isCollider && hitInfo.collider.tag==Tags.ground)
			{
                isMoving = true;
                ShowClickEffect(hitInfo.point);
			
               // LookAtTarget(hitInfo.point);
			}


		}
		if (Input.GetMouseButtonUp (0)) 
		{
			isMoving =false;		
		}

		if(isMoving)//得到移動的目標位置;讓主角朝向目標的位置
		{
			Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
			RaycastHit hitInfo;
			bool isCollider =Physics.Raycast(ray,out hitInfo);
			if(isCollider && hitInfo.collider.tag==Tags.ground)
			{
				LookAtTarget(hitInfo.point);

			}
		}else
		{
			if(playerMove.isMoving)
			{
				LookAtTarget(targetPosition);
			}
		}


	}
	void ShowClickEffect(Vector3 hitPoint)//自定義
	{
		hitPoint = new Vector3 (hitPoint.x,hitPoint.y+0.5f,hitPoint.z);
		GameObject.Instantiate (effect_click_prefab, hitPoint, Quaternion.identity);
	}
	void LookAtTarget(Vector3 hitPoint)//朝向目標
	{
		targetPosition = hitPoint;
		targetPosition = new Vector3 (targetPosition.x,targetPosition.y,targetPosition.z);
		this.transform.LookAt (targetPosition);//呼叫API look at方法,實現朝向的改變
	}
}
