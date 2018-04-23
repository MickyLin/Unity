using UnityEngine;
using System.Collections;

public class UIHandler : MonoBehaviour {
	public GameObject GetGameObjectByName( string name){
		Transform [] trs=GetComponentsInChildren <Transform  >();
		foreach  (Transform tr in trs ){
			if (tr .name ==name ){
				return tr.gameObject  ;
			}
		}
		return null ;
	}

	public T GetComponentByName <T>(string name) where T :MonoBehaviour{
		GameObject obj=GetGameObjectByName (name );
		if (obj !=null ){
			return obj .GetComponent <T>();
		}
		return null ;
	}
	public T AddComponentByName <T>(string name) where T :MonoBehaviour{
		GameObject obj=GetGameObjectByName (name );
		if (obj ==null ){
			return null ;
		}
		return obj .AddComponent <T>();

	}

}
