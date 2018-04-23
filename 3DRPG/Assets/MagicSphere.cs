using UnityEngine;
using System.Collections;
using System.Collections.Generic;


public class MagicSphere : MonoBehaviour 
{

    public float attack = 0;

    private List<WolfBaby> wolfList = new List<WolfBaby>();//傷害過的用集合存取,不再進行傷害

    public void OnTriggerEnter(Collider col)
    {
        if (col.tag == Tags.enemy)
        {
            WolfBaby baby = col.GetComponent<WolfBaby>();//臨時變數
            int index = wolfList.IndexOf(baby);
            if (index == -1)//不存在的情況
            {
                baby.TakeDamage((int)attack);
                wolfList.Add(baby);//放到wolfList集和裡
            }
        }
    }
}
