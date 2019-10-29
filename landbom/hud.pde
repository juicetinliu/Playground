void hud(){
  //---- HUD
  camera(); 
  noLights();
   
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(MODEL);
   
  stroke(255,0,0,100);
  strokeWeight(6);
  noFill();
  ellipse(width/2,height/2,50,50);
  
  stroke(0);
  strokeWeight(5);
  rect(50,50,50,height-200);
  noStroke();
  fill(255,0,0);
  rect(51,51+map(bomspeed,0,5,height-200,0),48,map(bomspeed,0,5,0,height-200));
  
  noStroke();
  for (int z = 0; z < cols-1; z++) {
    for (int x = 0; x < rows; x++) {
      if(terrain[x][z] < -250){
        fill(255);
      }else if(terrain[x][z] < -200){
        fill(100);
      }else if(terrain[x][z] > 18){
        fill(#434AFF);
      }else if(terrain[x][z] > 5){
        fill(#5A4B13);
      }else if(terrain[x][z] > 0){
        fill(#4D6701);
      }else{
        fill(#13A01B);
      }
      rect(map(z,0,cols-2,width-250,width-50),map(x,0,rows-1,250,50),200/(cols),200/(rows));
    }
  }
  stroke(0);
  strokeWeight(5);
  noFill();
  rect(width-250,50,200,200);
  if(currentplayer == 1){
    player2.hudmap(#00FF00,width-250,50,200,200,5);
    player1.hudmap(#FFFFFF,width-250,50,200,200,6);
    player1.hudmap(#FF0000,width-250,50,200,200,5);
    player1.hudmaplife();
  }else if(currentplayer == 2){
    player1.hudmap(#FF0000,width-250,50,200,200,5);
    player2.hudmap(#FFFFFF,width-250,50,200,200,6);
    player2.hudmap(#00FF00,width-250,50,200,200,5);
    player2.hudmaplife();
  }

  // prepare to return to 3D 
  hint(ENABLE_DEPTH_TEST);
}
