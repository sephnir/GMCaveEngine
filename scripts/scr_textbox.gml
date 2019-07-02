#define scr_textbox
scr_textbox_const();

#define scr_textbox_const
MSG_W = 244*2;
MSG_H = 64*2;
MSG_X = (view_wview[0]/2) - (MSG_W/2);
MSG_NORMAL_Y = ((view_hview[0] - MSG_H) - 4);
MSG_UPPER_Y= 24*2;

MSG_NLINES = 8*2;
MSG_LINE_SPACING = 16*2;

MSG_MAXLINELEN_FACE = 26;
MSG_MAXLINELEN_NO_FACE = 35;

MSG_CONTENT_X = MSG_X;
MSG_CONTENT_Y = 10*2;

MSG_FACE_W = 48*2;

#define scr_textbox_drawFrame
///scr_textbox_drawFrame(x,y,w,h);

var UNIT = 16;
var POSX = argument0;
var POSY = argument1;
var WIDTH = argument2;
var HEIGHT = argument3;

var curPosY = POSY;

draw_set_alpha(0.7);
//Top part
draw_sprite_part(spr_text_sheet,0,0,0,WIDTH,UNIT,view_xview[0]+POSX,view_yview[0]+curPosY);
curPosY += UNIT;

//Middle part
repeat((HEIGHT-UNIT*2)/UNIT)
{
    draw_sprite_part(spr_text_sheet,0,0,UNIT,WIDTH,UNIT,view_xview[0]+POSX,view_yview[0]+curPosY);
    curPosY += UNIT;
}

//Bottom part
draw_sprite_part(spr_text_sheet,0,0,UNIT*2,WIDTH,UNIT,view_xview[0]+POSX,view_yview[0]+curPosY);

draw_set_alpha(1);


#define scr_textbox_draw
///scr_textbox_draw()

//DLG_Y = 

//var textTop = 
