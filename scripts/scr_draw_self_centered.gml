
var displaceX = x;

if(curdir == 1){
    displaceX = x;
}else{
    displaceX = x + sprite_get_width(sprite_index)
}


draw_sprite_ext(sprite_index, image_index, displaceX, y, curdir, 1,0,c_white, 1);
