using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class SkillItem : MonoBehaviour
{
    public float coldTime = 2;
    public KeyCode keycode;
    private float timer = 0;
    private Image filledImage;
    private bool isStartTimer = false;
	// Use this for initialization
	void Start ()
	{
	    filledImage = transform.Find("FilledImage").GetComponent<Image>();
	    Toggle toggle;
	    ToggleGroup group;
	}
	
	// Update is called once per frame
	void Update () {
	    if (Input.GetKeyDown(keycode))
	    {
	        isStartTimer = true;
	    }
	    if (isStartTimer)
	    {
	        timer += Time.deltaTime;
	        filledImage.fillAmount = (coldTime - timer)/coldTime;
	        if (timer >= coldTime)
	        {
	            filledImage.fillAmount = 0;
	            timer = 0;
	            isStartTimer = false;
	        }
	    }
	}

    public void OnClick()
    {
        isStartTimer = true;
    }
}
