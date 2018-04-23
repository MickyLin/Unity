using UnityEngine;
using System.Collections;

public class SpawnpointPlayer : MonoBehaviour {
	public GameObject[] characterPrefabs;//陣列存所有腳色的prefab
	private int selectedIndex ;// 腳色的編號

	void Awake()
	{
		selectedIndex = PlayerPrefs.GetInt("SelectedCharacterIndex",selectedIndex);
		//characterPrefabs [selectedIndex] = (GameObject)Instantiate (characterPrefabs [selectedIndex], transform.position, transform.rotation);
	}
}
