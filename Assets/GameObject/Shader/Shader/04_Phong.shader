Shader "Unlit/04_Phong"
{
    Properties
    {
        _Color ("Main Color", Color) = (1,1,1,1)
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
            fixed4 _Color;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;
                float3 worldPosition : TEXCOORD0; // ���[���h���W�p
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worldPosition = mul(unity_ObjectToWorld, v.vertex).xyz; // ���[���h���W���v�Z
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // ����
                fixed4 ambient = _Color * 0.3 * _LightColor0;

                // �����x�N�g��
                float3 eyeDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPosition);

                // ���C�g�x�N�g��
                float3 lightDir = normalize(_WorldSpaceLightPos0);

                // �@���x�N�g���̐��K��
                i.normal = normalize(i.normal);

                // ���ʔ��ˌ��̌v�Z
                float3 reflectDir = reflect(-lightDir, i.normal);
                fixed4 specular = pow(saturate(dot(reflectDir, eyeDir)), 20) * _LightColor0;

                // �g�U���ˌ��̌v�Z
                float intensity = saturate(dot(i.normal, lightDir));
                fixed4 diffuse = _Color * intensity * _LightColor0;

                // Phong�V�F�[�f�B���O���ʂ̌v�Z
                fixed4 phong = ambient + diffuse + specular;
                return phong;
            }
            ENDCG
        }
    }
}
