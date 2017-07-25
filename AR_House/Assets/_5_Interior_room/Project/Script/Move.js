var target : Transform;
var distance = 10.0;

var xSpeed = 250.0;
var ySpeed = 120.0;

var yMinLimit = 20;
var yMaxLimit = 80;

var x = 0.0;
var y = 0.0;

private var oldPosition1 : Vector2;
private var oldPosition2 : Vector2;



function Start () {
    var angles = transform.eulerAngles;
    x = angles.y;
    y = angles.x;

	// Make the rigid body not change rotation
   	if (GetComponent.<Rigidbody>())
		GetComponent.<Rigidbody>().freezeRotation = true;
}
function Update () 
{
	
	if(Input.touchCount == 2)
	{
		
		if(Input.GetTouch(0).phase==TouchPhase.Moved)
		{
		    
			x += Input.GetAxis("Mouse X") * xSpeed * 0.02;
        	y -= Input.GetAxis("Mouse Y") * ySpeed * 0.02;
			
		}
	}
//	if(Input.GetMouseButton(1)){
//		x += Input.GetAxis("Mouse X") * xSpeed * 0.02;
//       	y -= Input.GetAxis("Mouse Y") * ySpeed * 0.02;
//	}
	
	
	if(Input.touchCount ==2 )
    {
    	
    	if(Input.GetTouch(0).phase==TouchPhase.Moved||Input.GetTouch(1).phase==TouchPhase.Moved)
    	{
    		
 	   			var tempPosition1 = Input.GetTouch(0).position;
				var tempPosition2 = Input.GetTouch(1).position;
            	if(isEnlarge(oldPosition1,oldPosition2,tempPosition1,tempPosition2))
            	{
               		if(distance > 3)
               		{
               			distance -= 0.5;	
               		} 
           		}else
				{
                	if(distance < 18.5)
                	{
                		distance += 0.5;
                	}
            	}
        	oldPosition1=tempPosition1;
			oldPosition2=tempPosition2;
    	}
    }
}

function isEnlarge(oP1 : Vector2,oP2 : Vector2,nP1 : Vector2,nP2 : Vector2) : boolean
{
    var leng1 =Mathf.Sqrt((oP1.x-oP2.x)*(oP1.x-oP2.x)+(oP1.y-oP2.y)*(oP1.y-oP2.y));
    var leng2 =Mathf.Sqrt((nP1.x-nP2.x)*(nP1.x-nP2.x)+(nP1.y-nP2.y)*(nP1.y-nP2.y));
    if(leng1<leng2)
    {
         return true; 
    }else
    {
        return false; 
    }
}


function LateUpdate () {
    if (target) {		
    	
 		y = ClampAngle(y, yMinLimit, yMaxLimit);
        var rotation = Quaternion.Euler(y, x, 0);
        var position = rotation * Vector3(0.0, 0.0, -distance) + target.position;
        
        transform.rotation = rotation;
        transform.position = position;
    }
}


static function ClampAngle (angle : float, min : float, max : float) {
	if (angle < -360)
		angle += 360;
	if (angle > 360)
		angle -= 360;
	return Mathf.Clamp (angle, min, max);
}
