using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class UI_manager : MonoBehaviour {


    public GameObject Inside_Panel;//放Inside_Panel
    public GameObject Building;//放建築物
    public GameObject Plan1;
    public GameObject Plan2;
    public GameObject Plan3;

    public GameObject Example_Panel;
    public Text Example_Content_Text;
    public Image Example_Content_Image;
    public Sprite[] SpriteChange;
    public string[] NameChange;



    //外部效果
    public void Outside_Button()
    {
        Building.SetActive(!Building.activeSelf);
        Inside_Panel.SetActive(false);
        Plan1.SetActive(false);
        Plan3.SetActive(false);
        Plan2.SetActive(false);
    }

    //內部構造
    public void Inside_Button()
    {
        Inside_Panel.SetActive(!Inside_Panel.activeSelf);
        Building.SetActive(false);
    }

    public void Plan1_Button()//房間一
    {
        Inside_Panel.SetActive(false);//把內部構造面板關掉
        Building.SetActive(false);
        Plan1.SetActive(true);
        Plan3.SetActive(false);
        Plan2.SetActive(false);
    }

    public void Plan2_Button()//房間二
    {
        Inside_Panel.SetActive(false);//把內部構造面板關掉
        Plan2.SetActive(true);
        Plan1.SetActive(false);
        Plan3.SetActive(false);
    }

    public void Plan3_Button()//房間三
    {
        Inside_Panel.SetActive(false);//把內部構造面板關掉
        Plan3.SetActive(true);
        Plan2.SetActive(false);
        Plan1.SetActive(false);
    }

}





