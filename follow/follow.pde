ArrayList<PVector> mousetrail = new ArrayList<PVector>();
PVector[] mousetrailar = new PVector[5];
float mousefade = 255;
float lastmouseang = 0;
int traillength = 5;

void setup(){
  fullScreen(OPENGL);
  pixelDensity(displayDensity());
  frameRate(60);
  smooth();
  //mousetrail.add(new PVector(mouseX, mouseY));
  for(int i = 0; i < mousetrailar.length; i++){
    mousetrailar[i] = new PVector(mouseX, mouseY);
  }
}

void draw(){
  background(0);
  mouseareffect();
}

void mouseareffect(){
  for(int i = 0; i < mousetrailar.length-1; i++){
    mousetrailar[i] = mousetrailar[i+1];
  }
  mousetrailar[4] = new PVector(mouseX, mouseY);
  int trailweight = 1;
  
  for(int j = 0; j < mousetrailar.length-1; j++){
    strokeWeight(trailweight);
    stroke(255);
    line(mousetrailar[j].x, mousetrailar[j].y, mousetrailar[j+1].x, mousetrailar[j+1].y);
    trailweight += 1;
  }
  noFill();
  strokeWeight(1);
  ellipse(mouseX,mouseY,50,50);
}

void mouseeffect(){
  if(mousetrail.size() < traillength){
    mousetrail.add(new PVector(mouseX, mouseY));
  }else{
    mousetrail.add(new PVector(mouseX, mouseY));
    mousetrail.remove(0);
  }
  int trailweight = 1;
  for(int j = 0; j < mousetrail.size() - 1; j++){
    strokeWeight(trailweight);
    stroke(255);
    line(mousetrail.get(j).x, mousetrail.get(j).y, mousetrail.get(j+1).x, mousetrail.get(j+1).y);
    trailweight += 1;
  }
  noFill();
  strokeWeight(1);
  ellipse(mouseX,mouseY,50,50);
  //if(mouseX == pmouseX && mouseY == pmouseY){
  //  if(mousefade > 0){
  //    mousefade = lerp(mousefade, 0, 0.1);
  //  }
  //  fill(255,mousefade);
  //  noStroke();
  //  //ellipse(mouseX,mouseY,10,10);
  //  arc(mouseX, mouseY, 10, 10, lastmouseang-PI/2, lastmouseang+PI/2, CHORD);
  //  triangle(mouseX+5*sin(lastmouseang),mouseY-5*cos(lastmouseang),mouseX-5*sin(lastmouseang),mouseY+5*cos(lastmouseang),mouseX-50*cos(lastmouseang), mouseY-50*sin(lastmouseang));
  //}else{
  //  mousefade = 255;
  //  float mouseang = atan2(mouseY-pmouseY,mouseX-pmouseX);
  //  lastmouseang = mouseang;
  //  fill(255,mousefade);
  //  noStroke();
  //  //ellipse(mouseX,mouseY,10,10);
  //  arc(mouseX, mouseY, 10, 10, mouseang-PI/2, mouseang+PI/2, CHORD);
  //  triangle(mouseX+5*sin(mouseang),mouseY-5*cos(mouseang),mouseX-5*sin(mouseang),mouseY+5*cos(mouseang),mouseX-50*cos(mouseang), mouseY-50*sin(mouseang));
  //}
}
