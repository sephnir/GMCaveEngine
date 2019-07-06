///scr_textbox_drawTextbox()

if (live_call()) return live_result;

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
            scr_textbox_checkAction();
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

if(constructedText != undefined)
    draw_text_colour(xPos, msgTextYOffset, constructedText,c_white,c_white,c_white,c_white,1);

if(msgCursorVisible && msgCursorTimer<7 )
    draw_rectangle( xPos+string_width(string(ds_list_find_value(msgDisplayedText, dTextSize-1))), string_height("W")*(dTextSize-1)*2,
      xPos+string_width(string(ds_list_find_value(msgDisplayedText, dTextSize-1)))+8, string_height("W")*(dTextSize-1)*2 +20,false);

surface_reset_target();

draw_surface(msgContentSurface, view_xview[0]+MSG_X+MSG_CONTENT_X, view_yview[0]+yPos+MSG_CONTENT_Y);

