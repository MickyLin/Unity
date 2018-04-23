using UnityEngine;
using System.Collections;

public class HUDTextParent : MonoBehaviour {

	public static HUDTextParent _instance;

	void Awake()
	{
		_instance = this;
	}
}
