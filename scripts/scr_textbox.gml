#define scr_textbox
scr_textbox_const();
scr_textbox_state();

#define scr_textbox_const
MSG_W = 244*2;
MSG_H = 64*2;
MSG_X = (view_wview[0]/2) - (MSG_W/2);
MSG_NORMAL_Y = ((view_hview[0] - MSG_H) - 4);
MSG_UPPER_Y= 24*2;

MSG_NLINES = 8*2;
MSG_LINE_SPACING = 16*2;

MSG_CONTENT_X = 14*2;
MSG_CONTENT_Y = 10*2;

MSG_FACE_W = 48*2;
MSG_FACE_BLINKRATE = 200;

/*draw_set_font(fnt_text);
MSG_MAXLINELEN_FACE =  floor((MSG_W-2*MSG_CONTENT_X-MSG_FACE_W)/string_width("W"));
MSG_MAXLINELEN_NO_FACE = floor((MSG_W-2*MSG_CONTENT_X)/string_width("W"));*/

MSG_MAXLINELEN_FACE = 26;
MSG_MAXLINELEN_NO_FACE = 35;

enum TEXTBOX_TYPE {
    BOTTOM = 0,
    TOP = 1
}



#define scr_textbox_state
msgCurrentType = TEXTBOX_TYPE.BOTTOM;

msgVisible = false;

msgFaceIndex = -1;
msgEyesIndex = -1;
msgMouthIndex = -1;

msgFaceXOffset = -1;
msgMouthSeq = 0;

msgTextScroll = false;
msgTextYOffset = 0;
msgTextTimer = 0;

msgTextLineAtOnce = false;

msgCanSpeedUp = true;

msgCursorVisible = false;
msgCursorTimer = 0;

msgBlinkTimer = 0;
msgBlink = false;

msgWaitingText = ds_list_create();
msgDisplayedText = ds_list_create();

msgContentSurface = surface_create(MSG_W-2*MSG_CONTENT_X, MSG_H-2*MSG_CONTENT_Y);
msgFaceSurface = surface_create(MSG_FACE_W, MSG_FACE_W);

scr_textbox_setFace(0,0,0);
ds_list_add(msgDisplayedText, "");

#define scr_textbox_drawTextbox
///scr_textbox_drawTextbox()

if(ds_list_size(msgWaitingText) == 0) {
    msgVisible = false;    
    exit;
}
else{
    msgVisible = true;
}

//Manage text
if(keyboard_check( obj_controller.btnJump) )
{
    if(msgCanSpeedUp){
        msgTextTimer = 9999;
    }
}
else
{
    msgCanSpeedUp = true;
}

if(keyboard_check_pressed(obj_controller.btnJump)){
    if(ds_list_size(msgWaitingText) > 0){
        if(string_length( ds_list_find_value(msgWaitingText,0)) == 0){
            ds_list_delete(msgWaitingText,0);
            scr_textbox_addNextLine();
        }
    }
}

if(msgTextScroll)
{
    msgTextYOffset -= MSG_LINE_SPACING/4;
    if (msgTextYOffset <= -MSG_LINE_SPACING){
        msgTextYOffset =0;
        msgTextTimer =0;
        msgTextScroll = false;

        if(ds_list_size(msgDisplayedText)> 3)
            ds_list_delete(msgDisplayedText,0);
        
    }
}

if(!msgTextScroll){
    //Transfer characters
    msgTextTimer+=1;
    if(msgTextTimer >= 4){
        msgTextTimer = 0;
        scr_textbox_addNextChar();
    }
}

var yPos;
var xPos = 8*2;

switch(msgCurrentType){
    case TEXTBOX_TYPE.BOTTOM: yPos = MSG_NORMAL_Y; break;
    case TEXTBOX_TYPE.TOP: yPos = MSG_UPPER_Y; break;
}

scr_textbox_drawFrame(MSG_X,yPos,MSG_W,MSG_H);

if(!surface_exists(msgContentSurface)){
    msgContentSurface = surface_create(MSG_W-2*MSG_CONTENT_X, MSG_H-2*MSG_CONTENT_Y);
}

surface_set_target(msgContentSurface);
draw_clear_alpha(c_white, 0);

//Draw face
if(msgFaceIndex>=0){
    scr_textbox_drawFace();
    xPos = MSG_FACE_W + 8*2;
}

//Draw text cursor
if(msgCursorVisible){
    //Visible when timer < 7
    msgCursorTimer += 1;
    
    msgCursorTimer = msgCursorTimer mod 20;
}

//Draw text
var constructedText = ds_list_find_value(msgDisplayedText, 0);
var dTextSize = ds_list_size(msgDisplayedText);

for(i=1; i< dTextSize; i++ ){
    constructedText += "##" + ds_list_find_value(msgDisplayedText, i);
}

draw_set_font(fnt_text);

draw_text_colour(xPos, msgTextYOffset, constructedText,c_white,c_white,c_white,c_white,1);

if(msgCursorVisible && msgCursorTimer<7 )
    draw_rectangle( xPos+string_width(string(ds_list_find_value(msgDisplayedText, dTextSize-1))), string_height("W")*(dTextSize-1)*2,
      xPos+string_width(string(ds_list_find_value(msgDisplayedText, dTextSize-1)))+8, string_height("W")*(dTextSize-1)*2 +20,false)

surface_reset_target();

draw_surface(msgContentSurface, view_xview[0]+MSG_X+MSG_CONTENT_X, view_yview[0]+yPos+MSG_CONTENT_Y);

#define scr_textbox_drawFace
//Draw face
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

//Mouth+Talk animation(TODO)
if(msgMouthIndex>=0){
    var mouthInd = msgMouthIndex*4;
    var mouthAnim = msgMouthSeq+1;
    if(mouthAnim==4) mouthAnim=2;
    
    draw_sprite(spr_portrait_mouth, mouthInd+mouthAnim, 0,0);
}

//Slide-in animation
if(msgFaceXOffset<0){
    msgFaceXOffset += sprite_get_width(spr_portrait_base)/6;
    msgFaceXOffset = min(0, 0);
}

surface_reset_target();

draw_surface(msgFaceSurface,msgFaceXOffset,0)



#define scr_textbox_addNextChar

if(ds_list_size(msgWaitingText) == 0) exit;

var lastEntry = ds_list_size(msgDisplayedText)-1;
    
var limit = MSG_MAXLINELEN_NO_FACE;
if(msgFaceIndex>=0) limit = MSG_MAXLINELEN_FACE;

if(msgTextLineAtOnce) {
    var tempSize = limit-1;
    if( string_length( ds_list_find_value(msgWaitingText,0)) <tempSize ) tempSize = string_length( ds_list_find_value(msgWaitingText,0));
    
    if(tempSize == 0) exit;
    
    ds_list_replace(msgDisplayedText, lastEntry, string_copy( ds_list_find_value(msgWaitingText,0) , 1, tempSize ) );
    ds_list_replace( msgWaitingText, 0 ,string_delete( ds_list_find_value(msgWaitingText,0),1,tempSize ));
        
    msgMouthSeq=-1;
        
    if(string_length(ds_list_find_value(msgDisplayedText,lastEntry)) >= limit-1){
        scr_textbox_addNextLine();
        exit;
    }
}

if( string_length(ds_list_find_value(msgWaitingText,0))>0 ){
    ds_list_replace( msgDisplayedText, lastEntry, ds_list_find_value(msgDisplayedText,lastEntry) + string_char_at( ds_list_find_value(msgWaitingText,0) , 0 ) );
    ds_list_replace( msgWaitingText, 0 ,string_delete( ds_list_find_value(msgWaitingText,0),1,1 ) );
    
    msgMouthSeq = msgMouthSeq+1 mod 4;
    msgCursorVisible = false;
    
    if(string_length(ds_list_find_value(msgDisplayedText,lastEntry)) >= limit-1){
        scr_textbox_addNextLine();
        exit;
    }
    
}
else{
    msgMouthSeq=-1;
    msgCursorVisible = true;
}

#define scr_textbox_addNextLine
ds_list_add(msgDisplayedText, "");

//Clears the oldest line if there are more than 3
if( ds_list_size(msgDisplayedText) > 3 && !msgTextLineAtOnce ) msgTextScroll = true;

if(ds_list_size(msgDisplayedText)> 3 && msgTextLineAtOnce )
    ds_list_delete(msgDisplayedText,0);

#define scr_textbox_drawFrame
///scr_textbox_drawFrame(x,y,w,h);

var TXT_UNIT = 16;
var POSX = argument0;
var POSY = argument1;
var WIDTH = argument2;
var HEIGHT = argument3;

var curPosY = POSY;

draw_set_alpha(0.7);
//Top part
draw_sprite_part(spr_text_sheet,0,0,0,WIDTH,TXT_UNIT,view_xview[0]+POSX,view_yview[0]+curPosY);
curPosY += TXT_UNIT;

//Middle part
repeat((HEIGHT-TXT_UNIT*2)/TXT_UNIT)
{
    draw_sprite_part(spr_text_sheet,0,0,TXT_UNIT,WIDTH,TXT_UNIT,view_xview[0]+POSX,view_yview[0]+curPosY);
    curPosY += TXT_UNIT;
}

//Bottom part
draw_sprite_part(spr_text_sheet,0,0,TXT_UNIT*2,WIDTH,TXT_UNIT,view_xview[0]+POSX,view_yview[0]+curPosY);

draw_set_alpha(1);


#define scr_textbox_destructor
if(ds_exists(msgWaitingText,ds_type_list))
    ds_list_destroy(msgWaitingText);
    
if(ds_exists(msgDisplayedText,ds_type_list))
    ds_list_destroy(msgDisplayedText);

#define scr_textbox_setText
///scr_set_text(text)
var msgText = argument0;

ds_list_add(msgWaitingText, msgText);

#define scr_textbox_setFace
///scr_textbox_setFace(faceInd, eyesInd, mouthInd)

msgFaceIndex = argument0;
msgEyesIndex = argument1;
msgMouthIndex = argument2;

msgFaceXOffset = -MSG_FACE_W;