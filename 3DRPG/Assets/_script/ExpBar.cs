using UnityEngine;
using System.Collections;

public class ExpBar : MonoBehaviour {



	public static ExpBar _instance;
	private UISlider progressBar;
    


	void Awake()
	{
		_instance = this;
         progressBar = this.GetComponent<UISlider>();
	}

    void Start()
    { 
        
    }

	public void SetValue(float value)
	{
        progressBar.value = value;
       
	}

  
}
