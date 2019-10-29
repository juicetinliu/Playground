int spacing = 20;
int w = 2000;
int h = 2000;
int rows = h / spacing;
int cols = w/ spacing;
float[][] terrain = new float[rows][cols];

boolean isLeft, isRight, isUp, isDown, isRise, isFall; 
float editingx, editingy, editingz;
float pointerx, pointerz;
float brushsize = 250;
boolean raiseterrain = false, lowerterrain = false, lightson = false;

float tides = 0, tidechange = 11;
float suncoor = 1000;

boolean moveground = false;
int currentplayer = 1;
player player1;
player player2;
float maxlife = 100;

boolean shootbom = false,bomexists = false, chargebom = false;
float bomspeed = 0, bomspeedadd = 0.1;
bom thisbom;


import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;
Robot robby;

void setup(){
  fullScreen(P3D);
  pixelDensity(displayDensity());
  //frameRate(60);
  smooth();
  try
  {
    robby = new Robot();
  }
  catch (AWTException e)
  {
    println("Robot class not supported by your system!");
    exit();
  }
  editingx = -200;
  editingy = -600;
  editingz = 1000;
  for (int z = 0; z < cols; z++) {
    for (int x = 0; x < rows; x++) {
      terrain[x][z] = 0;
    }
  }
  float fov = PI/3.0;
  perspective(fov, float(width)/float(height), 0.05, 5000);
  player1 = new player(200,0,1000,PI/2,0,0.4, maxlife);
  player2 = new player(1000,0,1000,PI/2,PI,0.4, maxlife);
}

void draw(){
  background(#5DC7FF);
  createland();
  //createwalls();
  if(lightson){
    pointLight(64,64,64, 0, -10000, 0);
    pointLight(64,64,64, 0, -10000, suncoor);
    pointLight(64,64,64, suncoor, -10000, 0);
    pointLight(64,64,64, suncoor, -10000, suncoor);
    //pointLight(255,255,255, playerx, playery, playerz);
    createwater();
  }
  if (raiseterrain){
    raisepoints(pointerx, pointerz, brushsize,3);
  }
  if (lowerterrain){
    lowerpoints(pointerx, pointerz, brushsize,3);
  }
  
  if(moveground){
    hud();
    if(currentplayer == 1){
      player1.updateplayer(isUp,isDown,isLeft,isRight,spacing,terrain);
      player2.terrainmap(#00FF00);
    }else if(currentplayer == 2){
      player2.updateplayer(isUp,isDown,isLeft,isRight,spacing,terrain);
      player1.terrainmap(#FF0000);
    }
    createbom();
  }else{
    moveCamera();
    player1.terrainmap(#FF0000);
    player2.terrainmap(#00FF00);
    pointerx = editingx+300+((-editingy/100)-1)*map((mouseY-height/2),-height/2, height/2, 500, -100);
    pointerz = editingz+((-editingy/100)-1)*map((mouseX-width/2),-width/2, width/2, -300, 300);
    pushMatrix();
    translate(pointerx,95,pointerz);
    rotateX(PI/2);
    fill(#FFFA6A,128);
    noStroke();
    ellipse(0,0,brushsize,brushsize);
    popMatrix();
  }
  
  if(bomexists){
    thisbom.display();
    if(thisbom.move(w,h,terrain,spacing)){
      if(dist(thisbom.x,thisbom.y,thisbom.z,player1.x,player1.y,player1.z) < 50){
        player1.damageplayer(int(map(dist(thisbom.x,thisbom.y,thisbom.z,player1.x,player1.y,player1.z),0,50,20,10)));
      }
      if(dist(thisbom.x,thisbom.y,thisbom.z,player2.x,player2.y,player2.z) < 50){
        player2.damageplayer(int(map(dist(thisbom.x,thisbom.y,thisbom.z,player2.x,player2.y,player2.z),0,50,20,10)));
      }
      lowerpoints(thisbom.x,thisbom.z, 100,30);
      bomexists = false;
      bomspeed = 0;
    }
  }
}

void createbom(){
  if(chargebom){
    bomspeed = bomspeed + bomspeedadd;
    if(bomspeed > 5){
      bomspeed = 5;
      bomspeedadd = -0.1;
    }else if(bomspeed < 0){
      bomspeed = 0;
      bomspeedadd = 0.1;
    }
      
  }
  if(shootbom){
    bomexists = true;
    if(currentplayer == 1){
      float bomspeedx = bomspeed*cos(player1.directiony)*sin(player1.directionxz);
      float bomspeedy = bomspeed*cos(player1.directionxz);
      float bomspeedz = bomspeed*sin(player1.directiony)*sin(player1.directionxz);
      thisbom = new bom(player1.x,player1.y,player1.z,bomspeedx,bomspeedy,bomspeedz,5,0.025);
    }else if(currentplayer == 2){
      float bomspeedx = bomspeed*cos(player2.directiony)*sin(player2.directionxz);
      float bomspeedy = bomspeed*cos(player2.directionxz);
      float bomspeedz = bomspeed*sin(player2.directiony)*sin(player2.directionxz);
      thisbom = new bom(player2.x,player2.y,player2.z,bomspeedx,bomspeedy,bomspeedz,5,0.025);
    }
    //moveground = false;
    shootbom = false;
  }
}

void moveCamera(){
  if(isLeft){
    editingz = editingz - 10;
  }
  if(isRight){
    editingz = editingz + 10;
  }
  if(isDown){
    editingx = editingx - 10;
  }
  if(isUp){
    editingx = editingx + 10;
  }
  if(isRise){
    editingy = editingy - 10;
  }
  if(isFall){
    editingy = editingy + 10;
  }
  
  camera(editingx, editingy, editingz, editingx + 1, editingy + 1, editingz, 0,1,0);
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if(moveground){
      if(!bomexists){
        chargebom = true;
      }
    }else{
      raiseterrain = true;
    }
    //raisepoints(pointerx, pointerz);
  }else if (mouseButton == RIGHT) {
    if(moveground){
    }else{
      lowerterrain = true;
    }
    //lowerpoints(pointerx, pointerz);
  }
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    if(moveground){
      if(!bomexists){
        chargebom = false;
        shootbom = true;
      }
    }else{
      raiseterrain = false;
    }
  }else if (mouseButton == RIGHT) {
    if(moveground){
    }else{
      lowerterrain = false;
    }
  }else if (mouseButton == CENTER){
    lightson = !lightson;
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e > 0){
    brushsize = brushsize + spacing;
  }else{
    brushsize = brushsize - spacing;
  }
  if(brushsize < spacing){
    brushsize = spacing;
  }else if(brushsize > w || brushsize > h){
    brushsize = min(w,h);
  }
}

void keyPressed() {
  if(keyCode == 'X'){
    moveground = !moveground;
  }else if(keyCode == 'Z'){
     lightson = !lightson;
  }else if(keyCode == 'C'){
    for (int z = 0; z < cols; z++) {
      for (int x = 0; x < rows; x++) {
        terrain[x][z] = 0;
      }
    }
  }else if(keyCode == ' '){
    currentplayer += 1;
    if(currentplayer > 2){
      currentplayer = 1;
    }
  }else{
    setMove(keyCode, true);
  }
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

  case 87: //w
    return isUp = b;
 
  case 83: //s
    return isDown = b;
 
  case 65: //a
    return isLeft = b;
 
  case 68: //d
    return isRight = b;
    
  case 81: //q
    return isFall = b;
    
  case 69: //e
    return isRise = b;

  default:
    return b;
  }
}
