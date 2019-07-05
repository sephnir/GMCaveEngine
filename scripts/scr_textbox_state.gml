if (live_call()) return live_result;

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
