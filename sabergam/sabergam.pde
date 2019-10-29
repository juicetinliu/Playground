ArrayList<hitblock> blox = new ArrayList<hitblock>();
float mousefade = 255;
float lastmouseang = 0;

void setup(){
  fullScreen();
  pixelDensity(displayDensity());
  frameRate(60);
  smooth();
  blox.add(new hitblock(width/2,height/2,radians(int(random(4))*90),150));
}

void draw(){
  background(0);
  for(hitblock blocks:blox){
    blocks.display();
  }
  mouseeffect();
  for(int b = 0; b < blox.size(); b++){
    if(blox.get(b).hit()){
      ellipse(mouseX,mouseY,25,25);
      blox.remove(b);
      //for(int i = int(random(2)); i >= 0; i--){
        blox.add(new hitblock(random(200,width-200),random(200,height-200),radians(int(random(4))*90),150));
      //}
    }
  }
  //stroke(255);
  //strokeWeight(3);
  //line(pmouseX, pmouseY, mouseX, mouseY);
  //if(pmouseX == mouseX && pmouseY == mouseY){
  //  fill(255);
  //  ellipse(mouseX,mouseY,25,25);
  //}else{
  //  float mouseang = atan2(mouseY-pmouseY,mouseX-pmouseX);
  //  if(mouseang < 0 + radians(30) && mouseang > 0 - radians(30)){
  //    strokeWeight(10);
  //  }else{
  //    strokeWeight(2);
  //  }
  //  line(mouseX,mouseY,mouseX+50*cos(mouseang),mouseY+50*sin(mouseang));
      
  //}
  //if(mouseang)
  
}

void mouseeffect(){
  if(mouseX == pmouseX && mouseY == pmouseY){
    if(mousefade > 0){
      mousefade = lerp(mousefade, 0, 0.1);
    }
    fill(255,mousefade);
    noStroke();
    arc(mouseX, mouseY, 10, 10, lastmouseang-PI/2, lastmouseang+PI/2, CHORD);
    triangle(mouseX+5*sin(lastmouseang),mouseY-5*cos(lastmouseang),mouseX-5*sin(lastmouseang),mouseY+5*cos(lastmouseang),mouseX-50*cos(lastmouseang), mouseY-50*sin(lastmouseang));
  }else{
    mousefade = 255;
    float mouseang = atan2(mouseY-pmouseY,mouseX-pmouseX);
    lastmouseang = mouseang;
    fill(255,mousefade);
    noStroke();
    arc(mouseX, mouseY, 10, 10, mouseang-PI/2, mouseang+PI/2, CHORD);
    triangle(mouseX+5*sin(mouseang),mouseY-5*cos(mouseang),mouseX-5*sin(mouseang),mouseY+5*cos(mouseang),mouseX-50*cos(mouseang), mouseY-50*sin(mouseang));
  }
}
