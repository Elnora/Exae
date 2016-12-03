using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimationOntrigger : MonoBehaviour 
{
	public Animation A;
	private void OnTriggerEnter(Collider collision)
	{
		A.Play ();
	}
	private void OnTriggerExit(Collider collision)
	{
	}
}