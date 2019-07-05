if (live_call()) return live_result;

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


