using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class UI_manager : MonoBehaviour {


    public GameObject Inside_Panel;//放Inside_Panel
    public GameObject Building;//放建築物
    public GameObject Info_Panel;//放關於info panel
    public GameObject Plan1;
    public GameObject Plan2;
    public GameObject Plan3;

    public GameObject Example_Panel;//面板
    public Text Example_Content_Text;//建物名字
    public Image Example_Content_Image;
    public Sprite[] SpriteChange;//圖片
    public string[] NameChange;//建築物名字
    public int Example_Count = 0;



    //外部效果
    public void Outside_Button()
    {
        Building.SetActive(!Building.activeSelf);
        Inside_Panel.SetActive(false);
        Plan1.SetActive(false);
        Plan3.SetActive(false);
        Plan2.SetActive(false);
        Example_Panel.SetActive(false);
        Info_Panel.SetActive(false);
    }

    //內部構造
    public void Inside_Button()
    {
        Inside_Panel.SetActive(!Inside_Panel.activeSelf);
        Building.SetActive(false);
        Example_Panel.SetActive(false);
        Info_Panel.SetActive(false);
    }

    public void Plan1_Button()//房間一
    {
       
        Inside_Panel.SetActive(false);//把內部構造面板關掉
        Building.SetActive(false);
        Plan1.SetActive(true);
        Plan3.SetActive(false);
        Plan2.SetActive(false);
        Info_Panel.SetActive(false);
    }

    public void Plan2_Button()//房間二
    {
        Inside_Panel.SetActive(false);//把內部構造面板關掉
        Plan2.SetActive(true);
        Plan1.SetActive(false);
        Plan3.SetActive(false);
        Info_Panel.SetActive(false);
    }

    public void Plan3_Button()//房間三
    {
        Inside_Panel.SetActive(false);//把內部構造面板關掉
        Plan3.SetActive(true);
        Plan2.SetActive(false);
        Plan1.SetActive(false);
        Info_Panel.SetActive(false);
    }

    public void Example_Button()//應用案例
    {
        Example_Panel.SetActive(!Example_Panel.activeSelf);
        Building.SetActive(false);
        Inside_Panel.SetActive(false);
        Plan2.SetActive(false);
        Plan1.SetActive(false);
        Plan3.SetActive(false);
        Info_Panel.SetActive(false);
    }
    public void Example_Close_Button()
    {
        Example_Panel.SetActive(false);
    }

    public void Right_Button()//下一張
    {
        if(Example_Count ==2)//特殊情況
        {
            Example_Count = 0;//讓編號跳到0
            Example_Content_Image.sprite = SpriteChange[Example_Count];
            Example_Content_Text.text = NameChange[Example_Count];
        }
        else
        {
            Example_Count++;
            Example_Content_Image.sprite = SpriteChange[Example_Count];
            Example_Content_Text.text = NameChange[Example_Count];
        }
    
    }

    public void Left_Button()//上一張
    {
        if (Example_Count == 0)//特殊情況
        {
            Example_Count =2;//讓編號跳到2
            Example_Content_Image.sprite = SpriteChange[Example_Count];
            Example_Content_Text.text = NameChange[Example_Count];
        }
        else
        {
            Example_Count--;
            Example_Content_Image.sprite = SpriteChange[Example_Count];
            Example_Content_Text.text = NameChange[Example_Count];
        }
    }

    public void Info_Button()//關於AR
    {
        Info_Panel.SetActive(!Info_Panel.activeSelf);
        Building.SetActive(false);
        Plan1.SetActive(false);
        Plan3.SetActive(false);
        Plan2.SetActive(false);
        Inside_Panel.SetActive(false);
        Example_Panel.SetActive(false);

    }

    public void Info_Closed_Button()
    {
        Info_Panel.SetActive(false);
    }

}





