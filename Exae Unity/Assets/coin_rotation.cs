using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class coin_rotation : MonoBehaviour {

	public Light lt;
	public float duration = 6.0F;

	// Use this for initialization
	void Start () {
		lt = GetComponent<Light>();
	}
	
	// Update is called once per frame
	void Update () {
		transform.Rotate (0, 0, 3, Space.Self);

		float phi = Time.time / duration * 2 * Mathf.PI;
		float amplitude = Mathf.Cos(phi) * 0.5F + 0.5F;
		lt.intensity = amplitude;
	}
}

