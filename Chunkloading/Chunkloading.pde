boolean isLeft, isRight, isUp, isDown; 
float playerx, playery, playerz;
float mainchunkx, mainchunkz;
float chunksize = 50;

void setup() {
  fullScreen(P3D);
  playerx = 0;
  playery = 0;
  playerz = 0;
}


void draw() {
  moveCamera();
  background(255);
  drawback();
  mainchunkx = playerx - (playerx % chunksize);
  mainchunkz = playerz - (playerz % chunksize);
  //rect(mainchunkx, mainchunkz, chunksize, chunksize);
  fill(255);
  stroke(0);
  ellipse(playerx, playerz, 5,5);
  for(int x = -1; x < 2; x++){
    float sidechunkx = mainchunkx + x*chunksize;
    for(int z = -1; z < 2; z++){
      float sidechunkz = mainchunkz + z*chunksize;
      rect(sidechunkx, sidechunkz, chunksize, chunksize);
    }
  }

}

void drawback(){
  for(int i = 0; i < width-1; i += chunksize){
    for(int j = 0; j < height; j += chunksize){
      float r = (float(i)/width)*255;
      float b = (float(j)/height)*255;
      fill(r,255,b,128);
      noStroke();
      rect(i,j,chunksize,chunksize);
    }
  }
}
void moveCamera(){
  if(isLeft){
    playerx = playerx - 3;
  }
  if(isRight){
    playerx = playerx + 3;
  }
  if(isDown){
    playerz = playerz + 3;
  }
  if(isUp){
    playerz = playerz - 3;
  }
}

void keyPressed() {
  setMove(keyCode, true);
}
 
void keyReleased() {
  setMove(keyCode, false);
}

boolean setMove(int k, boolean b) {
  switch (k) {
  case UP:
    return isUp = b;
 
  case DOWN:
    return isDown = b;
 
  case LEFT:
    return isLeft = b;
 
  case RIGHT:
    return isRight = b;

  case 87:
    return isUp = b;
 
  case 83:
    return isDown = b;
 
  case 65:
    return isLeft = b;
 
  case 68:
    return isRight = b;
    
  default:
    return b;
  }
}
