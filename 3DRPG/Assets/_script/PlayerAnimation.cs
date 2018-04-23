using UnityEngine;
using System.Collections;

public class PlayerAnimation : MonoBehaviour {

	private PlayerMove move;
	private PlayerAttack attack;//取得playerAttack腳本
	// Use this for initialization
	void Start () 
	{
		move = this.GetComponent<PlayerMove> ();
		attack = this.GetComponent<PlayerAttack> ();
	}
	
	// Update is called once per frame
	void LateUpdate () 
	{
		if(attack.state == PlayerState.ControlWalk)
		{
			if (move.state == ControlWalkState.Moving) 
			{
				animation.CrossFade ("Run");
				//PlayAnim ("Run");
			} 
			else if (move.state == ControlWalkState.Idle) 
			{
				animation.CrossFade ("Idle");
				//PlayAnim ("Idle");
			}
		}
		else if(attack.state == PlayerState.NormalAttack)
		
			{
				if(attack.attack_state == AttackState.Moving)
			    {
					animation.CrossFade ("Run");
			    }
			}

	}

	//void PlayAnim(string animName)//字定義方法,把動態名稱傳過來
	//{
		//animation.CrossFade (animName);
	//}
}
