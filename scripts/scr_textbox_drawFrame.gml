///scr_textbox_drawFrame(x,y,w,h);

if (live_call()) return live_result;

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

