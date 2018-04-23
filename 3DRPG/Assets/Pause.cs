using UnityEngine;
using System.Collections;

public class Pause : MonoBehaviour
{

    public string mainMenuSceneName;
    public Font pauseMenuFont;
    private bool pauseEnabled = false;

    void Start()
    {
        pauseEnabled = false;
        Time.timeScale = 1;
        AudioListener.volume = 1;
        Screen.showCursor = true;
    }

    void Update()
    {

       
        if (Input.GetKeyDown("escape"))
        {

            //已經暫停就不能在暫停了
            if (pauseEnabled == true)
            {
                //沒有暫停
                pauseEnabled = false;
                Time.timeScale = 1;//讓時間正常
                AudioListener.volume = 1;
                Screen.showCursor = true;//滑鼠指標正常
            }

                //沒暫停就可以執行暫停
            else if (pauseEnabled == false)
            {
                pauseEnabled = true;
                AudioListener.volume = 0;
                Time.timeScale = 0;//讓時間靜止
                Screen.showCursor = true;
            }
        }
    }

    private bool showGraphicsDropDown = false;

    void OnGUI()
    {

        GUI.skin.box.font = pauseMenuFont;
        GUI.skin.button.font = pauseMenuFont;
        if (pauseEnabled == true)
        {

            //渲染背景
            GUI.Box(new Rect(Screen.width / 2 - 100, Screen.height / 2 - 100, 250, 150), "Pause Menu");

            //主選單按鈕
            if (GUI.Button(new Rect(Screen.width / 2 - 100, Screen.height / 2 - 50, 250, 50), "Main Menu"))
            {

				Application.LoadLevel("1_character");
                Time.timeScale = 1;
            }
            //結束遊戲
            if (GUI.Button(new Rect(Screen.width / 2 - 100, Screen.height / 2 +0, 250, 50), "Quit Game"))
            {
				PlayerPrefs.Save();
				Application.Quit();
            }
            
        }
    }
}
