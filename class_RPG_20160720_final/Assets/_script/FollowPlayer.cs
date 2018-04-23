using UnityEngine;
using System.Collections;

public class FollowPlayer : MonoBehaviour 
{
	
	private bool isRotating = false;//不旋轉
	private Transform player; //取到player的位置
	private Vector3 offsetPosition;//Camera的位置- player之位置(camera與player之間距離)
	public float speed = 0.3f;
	public float distance=0;
	public float scrollSpeed=5.0f;
	public float rotateSpeed=3.0f;
	
	// Use this for initialization
	void Start () 
	{
		//player = GameObject.FindGameObjectWithTag(Tags.player).transform; //透過標簽查找player
		player = GameObject.FindGameObjectWithTag("Player").transform; //透過標簽查找player
		transform.LookAt (player.position);//朝向Player的位置
		offsetPosition = transform.position - player.position;//camera與player之間距離
	}
	
	// Update is called once per frame
	void Update () 
	{
		
		transform.position = offsetPosition + player.position;//camera距離更新
		//transform.position=Vector3.Lerp(transform.position,  offsetPosition + player.position,  Time.deltaTime *speed);
		//transform.position=Vector3.Lerp(transform.position,  offsetPosition + player.position,  speed);
		//print ("fffffff");
		RotateView ();
		ScrollView ();


	}
	void ScrollView()//滾輪縮放視野
	{
		
		distance = offsetPosition.magnitude;//滾動距離
		distance = distance - Input.GetAxis ("Mouse ScrollWheel") * scrollSpeed;
		//distance-=Input.GetAxis ("Mouse ScrollWheel") * scrollSpeed;
		distance = Mathf.Clamp (distance,2,10);//限制距離範圍
		offsetPosition = offsetPosition.normalized * distance;
	}
	void RotateView()//旋轉視野
	{
		if(Input.GetMouseButtonDown(1))
		{
			isRotating = true;
		}
		if (Input.GetMouseButtonUp (1)) 
		{
			isRotating = false;
		}
		if (isRotating) 
		{   //
			this.transform.RotateAround(player.position,player.up,rotateSpeed*Input.GetAxis("Mouse X"));//繞著Y軸轉
			Vector3 originalPos=transform.position;//原來位置保存一下
			Quaternion originalRotation =transform.rotation;//原來旋轉保存一下
			this.transform.RotateAround(player.position,this.transform.right,-rotateSpeed*Input.GetAxis("Mouse Y"));//繞著x軸轉
			float x = this.transform.eulerAngles.x;//限制旋轉範圍,宣告臨時變數
			if(x <10||x > 80)
			{
				transform.position = originalPos;
				transform.rotation = originalRotation;
				print("xxxxxxx");
			}

		}
		offsetPosition = this.transform.position - player.position;

	}

}
