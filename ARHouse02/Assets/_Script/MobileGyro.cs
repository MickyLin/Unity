using UnityEngine;
using System.Collections;
//攝像機  陀螺儀轉動
public class MobileGyro : MonoBehaviour
{
    Gyroscope gyro;
    Quaternion quatMult;
    Quaternion quatMap;
    GameObject player;
    GameObject camParent;
    void Awake()
    {
        player = GameObject.Find("Player");
        // find the current parent of the camera's transform
        Transform currentParent = transform.parent;
        // instantiate a new transform
        camParent = new GameObject("camParent");
        // match the transform to the camera position
        camParent.transform.position = transform.position;
        // make the new transform the parent of the camera transform
        transform.parent = camParent.transform;
        // make the original parent the grandparent of the camera transform
        //camParent.transform.parent = currentParent;
        // instantiate a new transform
        GameObject camGrandparent = new GameObject("camGrandParent");
        // match the transform to the camera position
        camGrandparent.transform.position = transform.position;
        // make the new transform the parent of the camera transform
        camParent.transform.parent = camGrandparent.transform;
        // make the original parent the grandparent of the camera transform
        camGrandparent.transform.parent = currentParent;

        Input.gyro.enabled = true;
        gyro = Input.gyro;

        gyro.enabled = true;
        camParent.transform.eulerAngles = new Vector3(90, 0, 0);
        quatMult = new Quaternion(0, 0, 1, 0);

    }

    void Update()
    {

        quatMap = new Quaternion(gyro.attitude.x, gyro.attitude.y, gyro.attitude.z, gyro.attitude.w);
        Quaternion qt = quatMap * quatMult;

        transform.localRotation = qt;

    }

}