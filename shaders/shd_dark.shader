//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec4 size;//resolution x, resolution y, block x, block y
uniform vec3 dis;//between one and zero

void main()
{
    //float val = 1.0/size.w;
    float tex;
    for(float i=0.0;i<1.0;i+=1.0/64.0)
    {
        tex += texture2D(gm_BaseTexture,v_vTexcoord+vec2(size.z*cos(i*(atan(1.0)*8.0))*dis.x,size.w*sin(i*(atan(1.0)*8.0))*dis.x)/size.xy).a;
        tex += texture2D(gm_BaseTexture,v_vTexcoord+vec2(size.z*cos(i*(atan(1.0)*8.0))*dis.y,size.w*sin(i*(atan(1.0)*8.0))*dis.y)/size.xy).a;
        tex += texture2D(gm_BaseTexture,v_vTexcoord+vec2(size.z*cos(i*(atan(1.0)*8.0))*dis.z,size.w*sin(i*(atan(1.0)*8.0))*dis.z)/size.xy).a;
        //tex += texture2D(gm_BaseTexture,v_vTexcoord+vec2(size.z*cos(i*(atan(1.0)*8.0))*0.9,size.w*sin(i*(atan(1.0)*8.0))*0.75)/size.xy).a;
        tex += texture2D(gm_BaseTexture,v_vTexcoord+vec2(size.z*cos(i*(atan(1.0)*8.0)),size.w*sin(i*(atan(1.0)*8.0)))/size.xy).a;
    }
    tex = pow(tex/256.0,5.0); //tex = clamp(pow(abs(tex/256.0),abs(1.0+dis)),0.0,1.0);
    tex = min(1.0, tex);
    
    //gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord ) * vec4(vec3(1.0-tex),1.0) ;
    vec4 temp =  v_vColour * texture2D( gm_BaseTexture, v_vTexcoord ) ;
    
    gl_FragColor.r = (1.0-2.0*(1.0-tex))*pow(temp.r,2.0)+2.0*(1.0-tex)*temp.r ;
    gl_FragColor.g = (1.0-2.0*(1.0-tex))*pow(temp.g,2.0)+2.0*(1.0-tex)*temp.g ;
    gl_FragColor.b = (1.0-2.0*(1.0-tex))*pow(temp.b,2.0)+2.0*(1.0-tex)*temp.b ;
    gl_FragColor.a = temp.a;
}
