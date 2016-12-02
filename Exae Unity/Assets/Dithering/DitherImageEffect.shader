Shader "Effects/DitherImageEffect"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_NoiseTex("Noise", 2D) = "white" {}
		_DitherDistance("Dither Distance", float) = 0.1
		_DitherAmount("Dither Amount", Range(0,1)) = 0
		_DitherColorThreshold("Dither Colour Threshold", Range(0,1)) = 0
		_NoiseMultiply("Noise Texture UV multiply", float) = 10
		_RandomizeNoise("_Randomize Noise", float) = 0
	}
		SubShader
		{
			// No culling or depth
			Cull Off ZWrite Off ZTest Always

			Pass
			{
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"

				struct appdata
				{
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					float4 vertex : SV_POSITION;
				};

				v2f vert(appdata v)
				{
					v2f o;
					o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
					o.uv = v.uv;
					return o;
				}

				sampler2D _MainTex;
				sampler2D _NoiseTex;
				float _DitherDistance;
				float _DitherAmount;
				float _DitherColorThreshold;
				float _RandomizeNoise;
				float _NoiseMultiply;

				fixed4 frag(v2f i) : SV_Target
				{
					fixed4 testRotationDistance = tex2D(_NoiseTex, float2(_RandomizeNoise, _RandomizeNoise) * _NoiseMultiply);

					fixed4 n = tex2D(_NoiseTex, (i.uv+(testRotationDistance.xy-0.5)) * _NoiseMultiply);

					fixed2 offset = (n.rg-0.5) * step(n.b, _DitherAmount);
					
					fixed4 col = tex2D(_MainTex, i.uv + (offset*_DitherDistance));
					fixed4 origCol = tex2D(_MainTex, i.uv);

					fixed3 diff = origCol.rgb - col.rgb;
					float dist = length(diff);

					col = lerp(origCol, col, step (dist, _DitherColorThreshold));
					return col;

					//if (dist > _DitherColorThreshold)
					//	return origCol;

					//// just invert the colors
					////col = n;
					//return col;
				}
				ENDCG
			}
		}
}
