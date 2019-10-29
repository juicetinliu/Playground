PVector positionai, velocityai;
float rmpowerai, lmpowerai, directionai;
PVector positionhuman, velocityhuman;
float rmpowerhuman, lmpowerhuman, directionhuman;
float offset = 12; //y of wheels from center
int arenasize = 200;
Boolean startedturning = true;
int turncounter = 0;
int turnamount;
Boolean sensor1detected = false;
Boolean sensor2detected = false;
float joyx = 580, joyy= 120;
Boolean joystart = false;

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

void setup() {
  size(700, 700);
  positionai = new PVector(width/2-arenasize+50,height/2);
  velocityai = new PVector(0,0);
  directionai = radians(0);
  rmpowerai = 0;
  lmpowerai = 0;
  positionhuman = new PVector(width/2+arenasize-50,height/2);
  velocityhuman = new PVector(0,0);
  directionhuman = radians(180);
  rmpowerhuman = 0;
  lmpowerhuman = 0;
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
  slider();
  movebotai();
  movebothuman();
  drawbotai();
  drawbothuman();
}

//sumobot algorithm
void sumoalgorithm(){  
  if(joystart){
    if(sensordetectedline(positionai) || !startedturning){
      turnrandomamount(100, 10, 50);
    }else{
      rmpowerai = 100;
      lmpowerai = 100;
    }
  }else{
    rmpowerai = 0;
    lmpowerai = 0;
  }
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

Boolean sensordetectedline(PVector location){
  float sensor1x = sqrt(sq(linesensory+offset) + sq(linesensorx))*sin(atan2(linesensory+offset,linesensorx)-directionai);
  float sensor1y = sqrt(sq(linesensory+offset) + sq(linesensorx))*cos(atan2(linesensory+offset,linesensorx)-directionai);
  float sensor2x = sqrt(sq(linesensory+offset) + sq(linesensorx))*sin(atan2(linesensory+offset,-linesensorx)-directionai);
  float sensor2y = sqrt(sq(linesensory+offset) + sq(linesensorx))*cos(atan2(linesensory+offset,-linesensorx)-directionai);
  //line(location.x + sensor2x, location.y + sensor2y,location.x , location.y);
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

void movebotai(){
  velocityai.mult(0);
  float rotateamount = map(lmpowerai - rmpowerai, 200, -200, 0.07, -0.07);
  velocityai.x = map(lmpowerai + rmpowerai, 200, -200, 2, -2);
  velocityai.rotate(directionai + rotateamount);

  directionai = directionai + rotateamount;
  positionai.add(velocityai);
}

void movebothuman(){
  velocityhuman.mult(0);
  float rotateamount = map(lmpowerhuman - rmpowerhuman, 200, -200, 0.07, -0.07);
  velocityhuman.x = map(lmpowerhuman + rmpowerhuman, 200, -200, 2, -2);
  velocityhuman.rotate(directionhuman + rotateamount);

  directionhuman = directionhuman + rotateamount;
  positionhuman.add(velocityhuman);
}

void slider(){
  stroke(255);
  line(50,120,50,20);
  line(100,120,100,20);
  
  line(45,70,55,70);
  line(95,70,105,70);
  //line(200,450,300,450);
  ellipse(50, map(lmpowerai, 100, -100, 20, 120), 10, 10);
  ellipse(100, map(rmpowerai, 100, -100, 20, 120), 10, 10);
  //ellipse(map(offset, 50, -50, 300, 200), 450, 10, 10);
}

void drawbotai(){
  fill(255, 120);
  stroke(255);
  pushMatrix();
  translate(positionai.x, positionai.y);
  rotate(directionai);
  rect(-20+offset,-25, 40, 50);
  ellipse(0,0,5,5);
  line(0+offset,0,30+offset,0);
  
  if(sensor1detected){
    stroke(255,0,255);
  }else{
    stroke(0,255,255);
  }
  ellipse(linesensory+offset, linesensorx, 5,5); 
  if(sensor2detected){
    stroke(255,0,255);
  }else{
    stroke(0,255,255);
  }
  ellipse(linesensory+offset, -linesensorx, 5,5);
  popMatrix();
}

void drawbothuman(){
  fill(255, 222, 181, 120);
  stroke(255, 222, 181, 255);
  pushMatrix();
  translate(positionhuman.x, positionhuman.y);
  rotate(directionhuman);
  rect(-20+offset,-25, 40, 50);
  ellipse(0,0,5,5);
  line(0+offset,0,30+offset,0);
  popMatrix();
}

void mouseDragged(){
  //if(sq(mouseX - 50) + sq(mouseY - map(lmpower, 100, -100, 20, 120)) <= 100){
  //  if(mouseY >= 20 && mouseY <= 120){
  //    lmpower = map(mouseY, 20, 120, 100, -100);
  //  }
  //}
  //if(sq(mouseX - 450) + sq(mouseY - map(rmpower, 100, -100, 20, 120)) <= 100){
  //  if(mouseY >= 20 && mouseY <= 120){
  //    rmpower = map(mouseY, 20, 120, 100, -100);
  //  }
  //}
  
  //if(sq(mouseX - map(offset, 50, -50, 300, 200)) + sq(mouseY - 450) <= 100){
  //  if(mouseX >= 200 && mouseX <= 300){
  //    offset = map(mouseX, 300, 200, 50, -50);
  //  }
  //}
  
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
    positionai = new PVector(width/2-arenasize+50,height/2);
    velocityai = new PVector(0,0);
    directionai = radians(0);
    rmpowerai = 0;
    lmpowerai = 0;
    positionhuman = new PVector(width/2+arenasize-50,height/2);
    velocityhuman = new PVector(0,0);
    directionhuman = radians(180);
    rmpowerhuman = 0;
    lmpowerhuman = 0;
  }
}
