using UnityEngine;
using System.Collections;

public class Rotate : MonoBehaviour {


    private Vector3 PreviousPosition;//紀錄上一偵手指的位置
    private Vector3 offset;//紀錄偏移的位置


    
	
	
	void Update () {

        offset = Input.mousePosition - PreviousPosition;//紀錄手指偏移位置
        PreviousPosition = Input.mousePosition;//紀錄上一偵手指的位置
        transform.Rotate(Vector3.Cross(offset*0.01f,Vector3.up).normalized, offset.magnitude*0.5f,Space.Self);
        //通過手指在螢幕上的偏移植來控制物件的旋轉
        //offset.magnitude*一個小數代表手指旋轉的幅度
    }
}
