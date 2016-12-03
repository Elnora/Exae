using UnityEngine;
public class Parent : MonoBehaviour
{
	public Transform parent;
	private void OnTriggerEnter(Collider collision)
	{
		collision.transform.SetParent(parent);
	}
	private void OnTriggerExit(Collider collision)
	{
		collision.transform.SetParent(null);
	}
}