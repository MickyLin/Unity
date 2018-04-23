using UnityEngine;
using System.Collections;

public class SpawnPointHero : MonoBehaviour {

    public GameObject magicianPrefab;
    public GameObject swordmanPrefab;
    //public GameObject[] characterPrefabs;//陣列存所有腳色的prefab
    private int selectedIndex;// 腳色的編號

    void Awake()
    {
        selectedIndex = PlayerPrefs.GetInt("SelectedCharacterIndex", selectedIndex);
        string name = PlayerPrefs.GetString("name");//儲存輸入的名字
        //characterPrefabs[selectedIndex] = (GameObject)Instantiate(characterPrefabs[selectedIndex], transform.position, transform.rotation);

        GameObject go = null;
        if (selectedIndex == 0)
        {
            go = (GameObject)Instantiate(magicianPrefab);
        }
        else if (selectedIndex == 1)     
        {
            go = (GameObject)Instantiate(swordmanPrefab);
        }
         
        go.GetComponent<PlayerStatus>().name = name;
    }
}
