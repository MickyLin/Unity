using UnityEngine;
using System.Collections;

public class WolfSpawn : MonoBehaviour {

	public int maxnum = 5;
	private int currentnum = 0;
	public float time = 3;
	private float timer = 0;
	public GameObject prefab;

	void Update()
	{
		if(currentnum < maxnum)
		{
			timer = timer + Time.deltaTime;
			if(timer > time)
			{
				Vector3 pos = transform.position;
				pos.x = pos.x + Random.Range(-5,5);
				pos.z = pos.z + Random.Range(-5,5);
				GameObject go = GameObject.Instantiate(prefab,pos,Quaternion.identity)as GameObject;
				go.GetComponent<WolfBaby>().spawn = this;
				timer = 0;
				currentnum++;
			}
		}
	}

	public void MinusNumber()//通知銷毀一個
	{
		this.currentnum--;
	}
}
