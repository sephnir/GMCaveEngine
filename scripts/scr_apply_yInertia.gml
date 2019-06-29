///scr_apply_yInertia(inertia)

var inertia = argument0;

if (inertia > 0)
{
  if (blockd) exit;

  while (inertia > (1 * CSF))
  {
      y += 1;
      inertia -= (1 * CSF);
      
      scr_check_block();
      if (blockd) exit;
  }
}
else if (inertia < 0)
{
  if (blocku) exit;

  while (inertia < -(1 * CSF))
  {
    y -= 1;
    inertia += (1 * CSF);

    scr_check_block();
    if (blocku) exit;
  }
}

if(inertia != 0){
    y+= inertia/CSF;
}
