using UnityEngine;
using System.Collections;

public class VedioControl : MonoBehaviour {

    public MediaPlayerCtrl scrMedia;// 
    public bool m_bFinish = false;
    
    void Start () {
        scrMedia.OnEnd += OnEnd;
    }
	
    public void Vedio01()//播放影片1
    {
        scrMedia.Load("Lineage2_01.mp4");
        m_bFinish = false;
        StartCoroutine(PlayVedio());
    }

    public void Vedio02()//播放影片2
    {
        scrMedia.Load("Lineage2_02.mp4");
        m_bFinish = false;
        StartCoroutine(PlayVedio());
    }

    public void Unload()//卸載影片
    {
        scrMedia.UnLoad();
    }

    IEnumerator PlayVedio()//暫停一段時間之後繼續把沒做完的function做完
    {
        yield return new WaitForSeconds(0.3f);
        scrMedia.Play();
        m_bFinish = false;
    }


    void OnEnd()
    {
        m_bFinish = true;
    }

}
