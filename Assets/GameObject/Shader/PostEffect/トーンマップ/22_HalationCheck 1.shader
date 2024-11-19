Shader "Unlit/22_HalationCheck 1"
{
   Properties
   {
     _MainTex("Texture",2D)="white"{}
   }

   SubShader 
   {
      Pass
      {
         CGPROGRAM
         #pragma vertex vert
         #pragma fragment frag
         #include "UnityCG.cginc"

         struct appdata
         {
            float4 vertex:POSITION;
            float2 uv:TEXCOORD0;
         };
         struct v2f
         {
            float4 vertex:SV_POSITION;
            float2 uv :TEXCOORD0;
         };

         sampler2D _MainTex;
         float4 _MainTex_ST;

         v2f vert(appdata v)
         {
            v2f o;
            o.vertex=UnityObjectToClipPos(v.vertex);
            o.uv=v.uv;
            return o;
         }

         float GetLuminance(float col)
         {
             float3 luminanceCoefficient=float3(0.299,0.587,0.114);
             return dot(col,luminanceCoefficient);
         }

         fixed4 frag(v2f i):SV_Target
         {
            fixed4 col =tex2D(_MainTex,i.uv);
            float luminance =GetLuminance(col.rgb);
            fixed4 pink =fixed4(1,0,1,1);
            return (luminance>1)?pink:col;
         }
         ENDCG
      }
   }
}
