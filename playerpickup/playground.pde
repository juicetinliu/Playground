void playground(PVector playerpos, int gridsize){
  
  
  int offsetxplus = int(playerpos.x);
  int offsetyplus = int(playerpos.y);
  
  //if(leftkey){
  //  offsetxplus = 1;
  //}
  //if(rightkey){
  //  offsetxplus = -1;
  //}
  //if(downkey){
  //  offsetyplus = -1;
  //}
  //if(upkey){
  //  offsetyplus = 1;
  //}
  
  stroke(128);
  strokeWeight(1);
  //width/2-450,height/2-300,900,550
  pxoffset = (pxoffset + offsetxplus)%50;
  pyoffset = (pyoffset + offsetyplus)%50;
  int gxstart = (width/2-450-pxoffset)/gridsize + 1;
  int gxend = (width/2+450-pxoffset)/gridsize + 1;
  int gystart = (height/2-300-pyoffset)/gridsize + 1;
  int gyend = (height/2+250-pyoffset)/gridsize + 1;
  for(int gx = gxstart; gx < gxend; gx++){
    line(gx*50+pxoffset, height/2-300, gx*50+pxoffset, height/2+250);
  }
  for(int gy = gystart; gy < gyend; gy++){
    line(width/2-450, gy*50+pyoffset, width/2+450, gy*50+pyoffset);
  }
}
