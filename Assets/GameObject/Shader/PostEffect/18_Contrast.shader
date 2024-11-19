Shader "Unlit/18_Contrast"
{
   Properties
   {
     _MainTex("MainTex",2D)=""{}
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
         sampler2D _MainTex;//•K‚¸_MainTex‚Æ‚·‚é
         float4 _MainTex_ST;
         float _Contrast;
         float _Brightness;
         v2f vert(appdata v)
         {
            v2f o;
            o.vertex=UnityObjectToClipPos(v.vertex);
            o.uv=v.uv;
            return o;
         }
         fixed4 frag(v2f i):SV_Target
         {
         _Contrast=0.01;
         _Brightness=0.00;
         fixed4 color = tex2D(_MainTex,i.uv*_MainTex_ST.xy+_MainTex_ST.zw);
         return pow(color + fixed4(_Brightness,_Brightness,_Brightness,1),_Contrast);
         }
         ENDCG
      }
   }
}
