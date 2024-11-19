Shader "Unlit/21_HDR"
{
   Properties
   {
     _Color("Color",Color)=(0,0,0,1)
     _Intensity("Intensity",Float)=1
     _MainTex("Texture",2D)="black"{}
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
         fixed4 _Color;
         float _Intensity;
         sampler2D _MainTex;
         float3 _MainTex_ST;
         v2f vert(appdata v)
         {
            v2f o;
            o.vertex=UnityObjectToClipPos(v.vertex);
            o.uv=v.uv;
            return o;
         }
         fixed4 frag(v2f i):SV_Target
         {
            fixed4 tex=tex2D(_MainTex ,i.uv);
            half4 result=(tex+_Color)*_Intensity;
            result.a=1;
            return result;
         }
         ENDCG
      }
   }
}
