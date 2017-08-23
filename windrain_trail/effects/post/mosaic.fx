vector _vecViewport; // viewport description ( vp.X, vp.Y, vp.Width, vp.Height )

sampler tex;

vector vecMosaic = {16,16,0,0}; //x,y: mosaic size in pixel; z,w: reserved

float4 mosaic( in float2 texCoord : TEXCOORD0 ) : COLOR
{
   //�õ���ǰ�����������ͼ���С����ֵ��
   float2  intXY = float2(texCoord.x * _vecViewport.z , texCoord.y * _vecViewport.w);
   //���������˿��С����ȡ����
   float2  XYMosaic   = float2(int(intXY.x/vecMosaic.x) * vecMosaic.x,
                               int(intXY.y/vecMosaic.y) * vecMosaic.y );
   //����������ת���������������
   float2  UVMosaic   = float2(XYMosaic.x/_vecViewport.z , XYMosaic.y/_vecViewport.w);
   return tex2D( tex, UVMosaic );
}



technique T0
{

  pass P0
  {
  PixelShader  = compile ps_2_0 mosaic(); 
  }
  
}

