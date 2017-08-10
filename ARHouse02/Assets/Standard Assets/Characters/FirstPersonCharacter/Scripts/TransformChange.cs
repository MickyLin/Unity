using UnityEngine;
using System.Collections;

public class TransformChange : MonoBehaviour {

    public Transform EndPosition;//第一人稱控制器的攝影機位置
    public float Costime = 0.2f; //攝影機移動的時間
    public GameObject FPSCtrl; //存第一人稱控制器
    public GameObject UICtrl; //存虛擬搖桿
    

   
	void Start () {

        StartCoroutine (CameraMove());
        StartCoroutine (Show());
    }
	
	IEnumerator CameraMove()
    {
        yield return new WaitForSeconds(0.5f);
        iTween.MoveTo(gameObject, EndPosition.position, Costime);//從攝影機起始位置經過costime後移動到EndPosition.position的位置
        iTween.RotateTo(gameObject, EndPosition.rotation.eulerAngles, Costime);//從攝影機起始位置經過costime後移動到EndPosition.position的角度
    }

    IEnumerator Show()
    {
        yield return new WaitForSeconds(3.5f);
        FPSCtrl.SetActive(true);//第一人稱控制器
        UICtrl.SetActive(true);//虛擬搖桿
    }

}
