///scr_set_anim(sprite, sequenceArray, speed)

__sanim_sprite = argument0;
__sanim_seqArray = argument1;
__sanim_animSpd = argument2;

__sanim_length = array_length_1d(__sanim_seqArray);

if(__sanim_curSprite!=__sanim_sprite || __sanim_curSeqArr!=__sanim_seqArray){
    __sanim_current = 0;
}

__sanim_curSprite = __sanim_sprite;
__sanim_curSeqArr = __sanim_seqArray;

sprite_index = __sanim_sprite;
image_speed = 0;



