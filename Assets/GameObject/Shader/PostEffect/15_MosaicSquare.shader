Shader "Unlit/15_MosaicSquare"
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
        sampler2D _MainTex;//必ず_MainTexとする
        float4 _MainTex_ST;

        v2f vert(appdata v)
        {
           v2f o;
           o.vertex=UnityObjectToClipPos(v.vertex);
           o.uv=v.uv;
           return o;
        }
        fixed4 frag(v2f i):SV_Target
        {
             float density = 0.05;

           // _ScreenParams.xyを使ってピクセル単位でグリッド状にUV座標を調整
          fixed4 col=tex2D(_MainTex,floor(i.uv*_ScreenParams.xy/density)*density/_ScreenParams.xy);

          return col;
        }
        ENDCG
     }
   }
}
