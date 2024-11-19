using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HDR_PE_Attacher : MonoBehaviour
{
    public Material tonemappingMaterial;//�e�g�[���}�b�v�V�F�[�_�[
    public Material halationCheckMaterial;//�n���[�V�����m�F�p�V�F�[�_�[
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        //HDR�Ή��̈ꎞ�e�N�X�`��
        RenderTexture tmp = RenderTexture.GetTemporary(source.width, source.height, 0, RenderTextureFormat.ARGBHalf);
        //�g�[���}�b�v�̓K��
        Graphics.Blit(source, tmp, tonemappingMaterial);
        //�n���[�V�����m�F�p�V�F�[�_�K�p
        Graphics.Blit(tmp, destination, halationCheckMaterial);
        RenderTexture.ReleaseTemporary(tmp);
    }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
