#define scr_dialog
//NULL

#define scr_dialog_const1
DLG_X = (((view_wview[0]/2) / 2) - 110*2);
DLG_Y = (((view_hview[0]/2) / 2) - 90*2);
DLG_W 	=240*2;
DLG_H = 180*2;

DLG_REPEAT_WAIT = 30;
DLG_REPEAT_RATE = 4;

#define scr_dialog_state1

dlgOnclear = NULL;
dlgOndismiss = NULL;
	
dlgFx = DLG_X;
dlgFy = DLG_Y;
dlgFw = DLG_W;
dlgFh = DLG_H;
dlgFTextX = (dlgFx + 48*2);
	
dlgFCurSel = 0;
dlgFNumShown = 0;
dlgFRepeatTimer = 0;