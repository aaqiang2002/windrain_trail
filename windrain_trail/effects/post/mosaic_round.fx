vector _vecViewport; // viewport description ( vp.X, vp.Y, vp.Width, vp.Height )

sampler tex;

vector vecMosaic = {16,16,0,0}; //x,y: mosaic size in pixel; z,w: reserved

float4 mosaic( in float2 texCoord : TEXCOORD0 ) : COLOR
{
   float2  intXY = float2(texCoord.x * _vecViewport.z , texCoord.y * _vecViewport.w);
   //���������Ĳ��������Ͻǣ���������
   float2  XYMosaic   = float2(int(intXY.x/vecMosaic.x) * vecMosaic.x,   int(intXY.y/vecMosaic.y) * vecMosaic.y ) + 0.5 * vecMosaic;
   //��������㵽���������ĵľ���
   float2  delXY = XYMosaic - intXY;
   float   delL  = length(delXY);
   float2  UVMosaic   = float2(XYMosaic.x/_vecViewport.z , XYMosaic.y/_vecViewport.w);
   float4  _finalColor;
   //�ж��ǲ��Ǵ���������Բ�С�
   if(delL< 0.5 * vecMosaic.x)
       _finalColor = tex2D( tex, UVMosaic );
   else
       _finalColor = tex2D( tex, texCoord );
   return _finalColor;
 }



technique T0
{

  pass P0
  {
  PixelShader  = compile ps_2_0 mosaic(); 
  }
  
}

