import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


// A list for all of our rectangles
int arenasize = 200;
float joyx = 580, joyy = 120;
Boolean joystart = false;
float rmpowerhuman, lmpowerhuman;
float offset = 0; //y of wheels from center
float rmpowerai, lmpowerai;
Boolean startedturning = true;
int turncounter = 0;
int turnamount;
Boolean sensor1detected = false;
Boolean sensor2detected = false;
int human = 0, nonhuman = 1;

float linesensorx = 20; //y
float linesensory = 15; //x
//  ╔^═════════════════^╗ ─┐
//  ║ o───x───┬───x───o ║  │
//  ║[2]      y      [1]║  │
//  ║         ┼         ║  40
//  ║┌┐               ┌┐║  │
//  ║└┘               └┘║  │
//  ╚═══════════════════╝ ─┘
//  └──────── 50 ───────┘

Box2DProcessing box2d;		
Sumobot ai;
Sumobot h;

void setup() {
  size(700,700);
  smooth();
  // Initialize and create the Box2D world
  box2d = new Box2DProcessing(this);	
  box2d.createWorld();
  
  // Create ArrayLists
  ai = new Sumobot(-15,0,0,30);
  h = new Sumobot(15,0,180,10);
  box2d.setGravity(0, 0);
}

void draw() {
  background(0);
  stroke(255);
  strokeWeight(3);
  fill(0);
  ellipse(width/2,height/2,arenasize * 2,arenasize * 2);
  strokeWeight(1);
  sumohuman();
  sumoalgorithm();
  // We must always step through time!
  box2d.step();    
  slider();
  if(joystart){
    h.move(lmpowerhuman,rmpowerhuman);
  }else{
    h.applyFriction(0.8);
  }
  if(lmpowerai != 0 && rmpowerai != 0){
    ai.move(lmpowerai,rmpowerai);
  }else{
    ai.applyFriction(0.8);
  }
  
  h.display(human);
  ai.display(nonhuman);
  if(testgameloss() == 0){
    //text("YOU LOST", (width/2) - 50, height/2);
    println("YOU LOST");
    restart();
  }else if(testgameloss() == 1){
    //text("YOU WON", (width/2) - 50, height/2);
    println("YOU WON");
    restart();  
  }
}

int testgameloss(){
  fill(255,0,0);
  textSize(32);
  if(sq(h.position.x-width/2) + sq(h.position.y-height/2) >= sq(200)){
    return 0;
  }else if(sq(ai.position.x-width/2) + sq(ai.position.y-height/2) >= sq(200)){
    return 1;
  }else{
    return -1;
  }
}

void sumoalgorithm(){
  if(joystart){
    if(sensordetectedline(ai.position) || !startedturning){
      turnrandomamount(100, 10, 50);
    }else{
      //float distancevec = h.position.subLocal(ai.position).length();
      //locatehumanmove(60);
      rmpowerai = 100;
      lmpowerai = 100;
    }
  }else{
    rmpowerai = 0;
    lmpowerai = 0;
  }
}

void locatehumanmove(float range){
  //float distancevec = constrain(h.position.subLocal(ai.position).length(),90,100);
  line(h.position.x, h.position.y, ai.position.x, ai.position.y);
  float angleconnect = -atan2(h.position.y - ai.position.y, h.position.x - ai.position.x) % (2*PI);
  float botdirection = angleconnect + ai.direction;
  if(botdirection < 0){
    botdirection = botdirection + 2 * PI;
  }
  if(botdirection > PI){
    botdirection = botdirection - 2 * PI;
  }
  if(botdirection % (2*PI) < 0 && botdirection % (2*PI) > radians(-range)){
    lmpowerai = 100;
    rmpowerai = 180*botdirection/PI;
  }else if(botdirection % (2*PI) > 0 && botdirection % (2*PI) < radians(range)){
    lmpowerai = -180*botdirection/PI;
    rmpowerai = 100;
  }else{
    rmpowerai = 0;
    lmpowerai = 0;
  }
}

Boolean sensordetectedline(Vec2 location){
  float sensor1x = sqrt(sq(linesensory+offset) + sq(linesensorx))*sin(atan2(linesensory+offset,linesensorx)-ai.direction);
  float sensor1y = sqrt(sq(linesensory+offset) + sq(linesensorx))*cos(atan2(linesensory+offset,linesensorx)-ai.direction);
  float sensor2x = sqrt(sq(linesensory+offset) + sq(linesensorx))*sin(atan2(linesensory+offset,-linesensorx)-ai.direction);
  float sensor2y = sqrt(sq(linesensory+offset) + sq(linesensorx))*cos(atan2(linesensory+offset,-linesensorx)-ai.direction);
  //line(location.x + sensor2x, location.y + sensor2y, location.x , location.y);
  
  if(sensor1detected){
    stroke(255,0,255);
  }else{
    stroke(0,255,255);
  }
  ellipse(sensor1x+location.x, sensor1y+location.y, 5,5); 
  if(sensor2detected){
    stroke(255,0,255);
  }else{
    stroke(0,255,255);
  }
  ellipse(sensor2x+location.x, sensor2y+location.y, 5,5);
  
  if(sq(location.x + sensor1x - width/2) + sq(location.y + sensor1y - height/2) >= sq(200) && sq(location.x + sensor2x - width/2) + sq(location.y + sensor2y - height/2) >= sq(arenasize)){
    sensor1detected = true;
    sensor2detected = true;
    return true;
  }else if(sq(location.x + sensor1x - width/2) + sq(location.y + sensor1y - height/2) >= sq(arenasize)){
    sensor1detected = true;
    sensor2detected = false;
    return true;
  }else if(sq(location.x + sensor2x - width/2) + sq(location.y + sensor2y - height/2) >= sq(arenasize)){
    sensor2detected = true;
    sensor1detected = false;
    return true;
  }else{
    sensor1detected = false;
    sensor2detected = false;
    return false;
  }
}

void turnrandomamount(int turnpower, float minturnduration, float maxturnduration){
  if(startedturning){
    turnamount = int(random(minturnduration, maxturnduration));
    startedturning = false;
  }else{
    if(turncounter <= turnamount){
      if(sensor2detected){
        rmpowerai = -turnpower;
        lmpowerai = turnpower;
      }else if(sensor1detected){
        rmpowerai = turnpower;
        lmpowerai = -turnpower;
      }
      turncounter++;
    }else{
      startedturning = true;
      turncounter = 0;
      rmpowerai = 100;
      lmpowerai = 100;
    }
  }
}

void slider(){
  stroke(255);
  fill(255,120);
  line(50,120,50,20);
  line(100,120,100,20);
  
  line(45,70,55,70);
  line(95,70,105,70);
  //line(200,450,300,450);
  ellipse(50, map(lmpowerai, 100, -100, 20, 120), 10, 10);
  ellipse(100, map(rmpowerai, 100, -100, 20, 120), 10, 10);
  //ellipse(map(offset, 50, -50, 300, 200), 450, 10, 10);
}

void sumohuman(){
  fill(255, 222, 181, 120);
  stroke(255, 222, 181, 255);
  ellipse(580,120,200,200);
  line(580,20,580,220);
  line(480,120,680,120);
  ellipse(joyx, joyy, 50, 50);
  if(joystart){
    float mouseang = atan2((mouseY-120),(mouseX - 580));
    if(sq(mouseX-580)+sq(mouseY-120) >= sq(100)){
      joyx = 580 + 100 * cos(mouseang);
      joyy = 120 + 100 * sin(mouseang);
    }else{
      joyx = mouseX;
      joyy = mouseY;
    }
    int joymotx = int(joyx - 580);
    int joymoty = int(-joyy + 120);
    rmpowerhuman = joymoty - joymotx;
    lmpowerhuman = joymoty + joymotx;
  }else{
    joyx = 580;
    joyy = 120;
    rmpowerhuman = 0;
    lmpowerhuman = 0;
  }
}

void mouseClicked(){
  if(sq(mouseX - 580) + sq(mouseY - 120) <= sq(100) && joystart == false){
    joystart = true;
  }else{
    joystart = false;
  }
}

void keyPressed(){
  if(key == 'q'){
    joystart = false;
    rmpowerai = 0;
    lmpowerai = 0;
    rmpowerhuman = 0;
    lmpowerhuman = 0;
  }else if(key == 'Q'){
    restart();
  }
}

void restart(){
  joystart = false;
  rmpowerai = 0;
  lmpowerai = 0;
  rmpowerhuman = 0;
  lmpowerhuman = 0;
  ai.killBody();
  h.killBody();
  ai = new Sumobot(-15,0,0,30);
  h = new Sumobot(15,0,180,10);
}
