using UnityEngine;
using System.Collections;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour {

	public void OnStartGame(int sceneToLoad){
		//int sceneToLoad = 1;
		SceneManager.LoadScene(sceneToLoad);
	}
}
