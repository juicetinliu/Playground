boolean isLeft, isRight, isUp, isDown; 
float playerx, playery, playerz;
float playerxspeed, playeryspeed, playerzspeed;
float playerrotxz, playerroty, playerrotz;
float deltx;
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;
Robot robby;

int limit = 100;
Planet[] planets = new Planet[limit];
Spacecloud cloud = new Spacecloud(100,500);

float playerspeed = 100;
float renderheight = 10000;
PShape starsphere;
PImage backimg;

void setup() {
  randomSeed(0);
  //size(1280, 700, P3D); 
  fullScreen(P3D);
  pixelDensity(displayDensity());
  frameRate(60);
  try
  {
    robby = new Robot();
  }
  catch (AWTException e)
  {
    println("Robot class not supported by your system!");
    exit();
  }
  playerx = 0;
  playery = 0;
  playerz = 0;
  playerrotxz = 0;
  playerroty = 0;
  playerrotz = 0;
  noCursor();
  for (int i = 0; i < planets.length; i++){
    planets[i] = new Planet(random(-100000,100000),random(-100000,100000),random(-100000,100000), random(200,1000), int(random(0,255)), int(random(0,255)), int(random(0,255)));
  }
  
  cloud.createCloud(playerx,playery,playerz);
  float fov = PI/3.0;
  perspective(fov, float(width)/float(height), 0.01, 100050);
  
  backimg = loadImage("backgroundhr.png");
}

void draw(){
  background(0);
  fill(200);
  // Raise overall light in scene 
  moveCamera();
  pointLight(255,255,255,playerx,playery,playerz);
  ambientLight(255,255,255);
  cloud.updateCloud(playerx,playery,playerz);
  cloud.drawCloud();
  
  skyball();
  
  for(int i = 0; i < planets.length; i++){
    if(dist(playerx, playery, playerz, planets[i].x, planets[i].y, planets[i].z) < renderheight){
      planets[i].drawPlanet();
    }
  }
  
  //fill(255);
  //rect(0,0,1000,1000);
  hud();
}

void moveCamera(){
  if(isLeft){
    playerzspeed = playerspeed*sin(3*PI/2+playerroty);
    playerxspeed = playerspeed*cos(3*PI/2+playerroty);
  }
  if(isRight){
    playerzspeed = playerspeed*sin(PI/2+playerroty);
    playerxspeed = playerspeed*cos(PI/2+playerroty);
  }
  if(isDown){
    playerzspeed = -playerspeed*sin(playerroty)*sin(playerrotxz);
    playerxspeed = -playerspeed*cos(playerroty)*sin(playerrotxz);
    playeryspeed = playerspeed*cos(playerrotxz);
  }
  if(isUp){
    playerzspeed = playerspeed*sin(playerroty)*sin(playerrotxz);
    playerxspeed = playerspeed*cos(playerroty)*sin(playerrotxz);
    playeryspeed = playerspeed*cos(playerrotxz);
  }
  playerxspeed = lerp(playerxspeed,0,0.01);
  playeryspeed = lerp(playeryspeed,0,0.01);
  playerzspeed = lerp(playerzspeed,0,0.01);
  playerz = playerz + playerzspeed;
  playerx = playerx + playerxspeed;
  playery = playery + playeryspeed;
  mousemovement();
  spacemovement();
  //playerroty = map(mouseX,0,width,0,2*PI);
  playerroty = playerroty + radians(deltx/5);
  playerrotxz = map(mouseY,0,height,PI-0.01,0);
  camera(playerx, playery, playerz, playerx+cos(playerroty)*sin(playerrotxz), playery+cos(playerrotxz), playerz+sin(playerroty)*sin(playerrotxz), 0,1,0);
}

void skyball(){
  pushMatrix();
  translate(playerx,playery,playerz);
  noStroke();
  noFill();
  sphereDetail(100);
  starsphere = createShape(SPHERE,90000);
  starsphere.setTexture(backimg);
  shape(starsphere);
  popMatrix();
}

void mousemovement(){
  deltx = mouseX - pmouseX;
  if(mouseX < 100){
    robby.mouseMove(width-150, mouseY);
  }else if(mouseX > width-100){
    robby.mouseMove(150, mouseY);
  }
  deltx = deltx % (width-250);
}

void spacemovement(){
  
}

void hud(){
  //---- HUD
  camera(); 
  noLights();
   
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(MODEL);
   
  stroke(#FF2C2F,100);
  strokeWeight(6);
  line(0,height-mouseY,400,height-mouseY);
  line(width-400, height-mouseY, width, height-mouseY);
  noFill();
  ellipse(width/2,height/2,20,20);
  
  strokeWeight(1);
  stroke(#C4C3E3);
  fill(#020043);
  rect(10,10,200,200);
  fill(255);
  float hudpx = map(playerx,-100000,100000,210,10);
  float hudpz = map(playerz,-100000,100000,210,10);
  float hudpy = map(playery,-100000,100000,2,6);
  ellipse(110,110,5,5);
  stroke(#C4C3E3,128);
  line(10,110,210,110);
  line(110,10,110,210);
  
  
  pushMatrix();
  translate(110,110);
  rotate(playerroty-PI/2);
  noStroke();
  fill(255,100);
  triangle(0,0,-3,-7,3,-7);
  popMatrix();
  float minppdistance = 0;
  boolean planetnearby = false;
  for(int i = 0; i < planets.length; i++){
    float ppdistance = dist(planets[i].x,planets[i].y,planets[i].z,playerx,playery,playerz);
    if(ppdistance < renderheight){
      planetnearby = true;
      textSize(32);
      fill(255);
      text("Planet", 20, 250);
      text(i, 120, 250);
      minppdistance = ppdistance-planets[i].radius;
      println(minppdistance);
    }
    if(abs(planets[i].y - playery) < renderheight){
      float planethudx = map(planets[i].x,-100000,100000,210,10);
      float planethudz = map(planets[i].z,-100000,100000,210,10);
      if(planethudx-hudpx+110 < 210 && planethudx-hudpx+110 > 10 && planethudz-hudpz+110 < 210 && planethudz-hudpz+110 > 10){
        float planethudy = map(abs(planets[i].y-playery),0,renderheight,6,0);
        float planethudsize = map(planets[i].radius, 200,1000,0,4);
        stroke(255);
        fill(planets[i].r,planets[i].g,planets[i].b);
        ellipse(planethudx-hudpx+110, planethudz-hudpz+110,planethudy+planethudsize,planethudy+planethudsize);
      }
    }
  }
  if(planetnearby){
    playerspeed = 10*minppdistance/renderheight;
  }else{
    playerspeed = 100;
  }
  
  // prepare to return to 3D 
  hint(ENABLE_DEPTH_TEST);
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
