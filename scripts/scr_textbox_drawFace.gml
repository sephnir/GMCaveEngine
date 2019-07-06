//Draw face
if (live_call()) return live_result;

if(!surface_exists(msgFaceSurface)) msgFaceSurface = surface_create(MSG_FACE_W, MSG_FACE_W);

surface_set_target(msgFaceSurface);
draw_clear_alpha(c_black,0);

draw_sprite(spr_portrait_base, msgFaceIndex,0,0);

//Eyes + blink animation
if(msgEyesIndex>=0){
    var eyesInd = msgEyesIndex*3;
    var eyesAnim = 0;
    
    if(!msgBlink){
        msgBlinkTimer += 1;
        
        if(msgBlinkTimer>MSG_FACE_BLINKRATE) {
            msgBlinkTimer=0;
            msgBlink = true;
        }
    }
    else if(msgBlink){
        msgBlinkTimer += 1;
        
        if(msgBlinkTimer<4) eyesAnim = 1;
        else if(msgBlinkTimer<8) eyesAnim = 2;
        else if(msgBlinkTimer<12) eyesAnim = 1;
        else {
            msgBlinkTimer=0; 
            msgBlink = false;
        };
        
    }
    
    draw_sprite(spr_portrait_eyes, eyesInd+eyesAnim, 0,0);
}

//Mouth+Talk animation
if(msgMouthIndex>=0){
    var mouthInd = msgMouthIndex*4;
    var mouthAnim = floor(msgMouthSeq/2)+1;
    if(mouthAnim==4) mouthAnim=2;

    draw_sprite(spr_portrait_mouth, mouthInd+mouthAnim, 0,0);
}

//Slide-in animation
if(msgFaceXOffset<0 && msgVisible){
    msgFaceXOffset += sprite_get_width(spr_portrait_base)/6;
    msgFaceXOffset = min(0, msgFaceXOffset);
}

surface_reset_target();

draw_surface(msgFaceSurface,msgFaceXOffset,0)



