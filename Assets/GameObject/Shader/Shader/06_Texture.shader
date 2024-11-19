Shader "Unlit/06_Texture"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _Color("Main Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : TEXCOORD1;      // �@���p�ɕʂ̃e�N�X�`�����W���W�X�^
                float3 worldPosition : TEXCOORD2; // ���[���h���W�p�ɂ���ɕʂ̃��W�X�^
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed4 _Color;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worldPosition = mul(unity_ObjectToWorld, v.vertex).xyz; // ���[���h���W���v�Z
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // �e�N�X�`��
                float2 tiling = _MainTex_ST.xy;
                float2 offset = _MainTex_ST.zw;
                _Color = tex2D(_MainTex, i.uv * tiling + offset)*_Color;

                // ����
                fixed4 ambient = _Color * 0.3 * _LightColor0;

                // �����x�N�g��
                float3 eyeDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPosition);

                // ���C�g�x�N�g��
                float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);

                // �@���x�N�g���̐��K��
                float3 normal = normalize(i.normal);

                // ���ʔ��ˌ��̌v�Z
                float3 reflectDir = reflect(-lightDir, normal);
                fixed4 specular = pow(saturate(dot(reflectDir, eyeDir)), 20) * _LightColor0;

                // �g�U���ˌ��̌v�Z
                float intensity = saturate(dot(normal, lightDir));
                fixed4 diffuse = _Color * intensity * _LightColor0;

                // Phong�V�F�[�f�B���O���ʂ̌v�Z
                fixed4 phong = ambient+ diffuse + specular;

                return phong;
            }
            ENDCG
        }
    }
}
