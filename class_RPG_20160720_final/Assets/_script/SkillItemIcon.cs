using UnityEngine;
using System.Collections;

public class SkillItemIcon : UIDragDropItem 
{

	private int skillId;//先得到id
	protected override void OnDragDropStart()
	{
		base.OnDragDropStart ();
		skillId = transform.parent.GetComponent<SkillItem> ().id;
		transform.parent = transform.root;
		this.GetComponent<UISprite> ().depth = 80;
	}

	protected override void OnDragDropRelease(GameObject surface)
	{
		base.OnDragDropRelease (surface);
		if(surface!=null&&surface.tag==Tags.shortcut)
		{
			surface.GetComponent<ShortCutGrid>().SetSkill(skillId);
		}
	}
}
