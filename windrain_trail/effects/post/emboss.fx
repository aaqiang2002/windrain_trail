vector _vecViewport; // viewport description ( vp.X, vp.Y, vp.Width, vp.Height )

sampler tex;


float4 emboss( in float2 texCoord : TEXCOORD0 ) : COLOR
{
	float2  upLeftUV = float2(texCoord.x - 1.0/_vecViewport.z , texCoord.y - 1.0/_vecViewport.w);
	float4  bkColor = float4(0.5 , 0.5 , 0.5 , 1.0);
	float4  curColor    =  tex2D( tex, texCoord );
	float4  upLeftColor =  tex2D( tex, upLeftUV );
	//����õ���ɫ�Ĳ�
	float4  delColor = curColor - upLeftColor;
	//��Ҫ�������ɫ�Ĳ�����
	float  h = 0.3 * delColor.x + 0.59 * delColor.y + 0.11* delColor.z;
	float4  _outColor =  float4(h,h,h,0.0)+ bkColor;
	return  _outColor;	
 }



technique T0
{

  pass P0
  {
  PixelShader  = compile ps_2_0 emboss(); 
  }
  
}

