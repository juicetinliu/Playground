float[] x = new float[4];
float[] y = new float[4];
int[] a = new int[4];
float segLength = 50;
float rboxheight = 15.6;
float armtobox = 11.7;
float armheight = 130;
int flip = 1;
float prevang = 0.0;
int currentarm = 0;
boolean controlend = true;


void setup() {
  size(500, 500);
  textSize(18);
  x[0] = 250;
  y[0] = 250;
  x[1] = 300;
  y[1] = 250;
  x[2] = 350;
  y[2] = 250;
  x[3] = 350;
  y[3] = 300;
}


void draw() {
  
  background(249,122,67);
  
  drawrover();
  drawarms();
  strokeWeight(1);
  stroke(255); 
  if(controlend == true){
    fill(255,0,0);
  }else{
    fill(0,255,0);
  }
  ellipse(450, 50, 20, 20);
  hoverpoint();
  changearms();
  text("x", 10, 15);
  text("|  y", 60, 15);
  for(int i = 0; i < 4; i++){
    int xcor = round(x[i] - 250);
    int ycor = round(y[i] - 250);
    text(xcor, 10, 35+i*20);
    text("|  " + ycor, 60, 35+i*20);
  }
  
  
  a[0] = round(angle(x[1],x[0],250,y[1],y[0],250));
  text(a[0] + "º", x[0], y[0]);
  for(int j = 1; j < 3; j++){
    a[j] = round(angle(x[j+1], x[j], x[j-1], y[j+1], y[j], y[j-1]));
    text(a[j] + "º", x[j], y[j]);
  }
}

float angle(float x3, float x2, float x1, float y3, float y2, float y1){
  float retangle = -180 * (atan2((y3 - y2),(x3 - x2)) - atan2((y2 - y1),(x2 - x1))) / PI;
   if(retangle >= 180){
      retangle = retangle - 360;
   }else if(retangle < -180){
      retangle = retangle + 360;
   }
   return retangle;
}

void drawrover(){
  noStroke();
  fill(255);
  rect(0, 250 - rboxheight, 250 - armtobox, rboxheight * 2);
  stroke(255);
  strokeWeight(1);
  line(0,250 + armheight, 500, 250 + armheight);
}


void hoverpoint(){
  fill(255);
  if(sq(mouseX - x[1]) + sq(mouseY - y[1]) <= sq(10)){
    ellipse(x[1], y[1], 10, 10);
  }else if(sq(mouseX - x[2]) + sq(mouseY - y[2]) <= sq(10)){
    ellipse(x[2], y[2], 10, 10);
  }else if(sq(mouseX - x[3]) + sq(mouseY - y[3]) <= sq(10)){
    ellipse(x[3], y[3], 10, 10);
  }
}

void drawarms(){
  strokeWeight(8.0);
  stroke(255, 128); 
  ellipse(x[0], y[0], 10, 10);
  line(x[0], y[0], x[1], y[1]);
  ellipse(x[1], y[1], 10, 10);
  line(x[1], y[1], x[2], y[2]);
  ellipse(x[2], y[2], 10, 10);
  line(x[2], y[2], x[3], y[3]);
  
  ellipse(x[3], y[3], 10, 10);
}

void mouseClicked(){
  if(sq(mouseX - x[1]) + sq(mouseY - y[1]) <= sq(20)){
    if(currentarm == 1){
      currentarm = 0;
    }else{
      currentarm = 1;
    }
  }else if(sq(mouseX - x[2]) + sq(mouseY - y[2]) <= sq(20)){
    if(currentarm == 2){
      currentarm = 0;
    }else{
      currentarm = 2;
    }
  }else if(sq(mouseX - x[3]) + sq(mouseY - y[3]) <= sq(20)){
    if(currentarm == 3){
      currentarm = 0;
    }else{
      currentarm = 3;
    }
  }else{
    currentarm = 0;
  }
  if(sq(mouseX - 450) + sq(mouseY - 50) <= sq(10)){
    if(controlend == true){
      controlend = false;
    }else{
      controlend = true;
    }
  }
}
  

void changearms(){
  if(currentarm == 1){
    float dx1 = mouseX - x[0];
    float dy1 = mouseY - y[0];
    float newangp1 = atan2(dy1, dx1);
    float xangp1 = atan2(y[1]-y[0], x[1]-x[0]);
    float changeang = newangp1 - xangp1;
    float xangp2 = atan2((y[2] - y[1]),(x[2] - x[1]));
    float xangp3 = atan2((y[3] - y[2]),(x[3] - x[2]));
    if(-180 * newangp1 / PI <= 130 && -180 * newangp1 / PI >= -130){
      x[1] = x[0] + cos(newangp1) * segLength;
      y[1] = y[0] + sin(newangp1) * segLength;
      x[2] = x[1] + cos(xangp2 + changeang) * segLength;
      y[2] = y[1] + sin(xangp2 + changeang) * segLength;
      if(controlend){
        x[3] = x[2] + cos(xangp3 + changeang) * segLength;
        y[3] = y[2] + sin(xangp3 + changeang) * segLength;
      }else{
        x[3] = x[2];
        y[3] = y[2] + segLength;
      }
    }
  }else if(currentarm == 2){
    if(sq(mouseX - 250) + sq(mouseY - 250) <= sq(2 * segLength)){
      float dy2 = y[2] - y[0];
      float dx2 = x[2] - x[0];
      float dx = mouseX - x[0];
      float dy = mouseY - y[0];
      float angle1 = atan2(dy, dx);  
      float angle2 = atan2(dy2, dx2); 
      float angseg1 = flip * acos(sqrt(sq(dx) + sq(dy)) / (2 * segLength));
      float angseg2 = flip * acos(sqrt(sq(dx2) + sq(dy2)) / (2 * segLength));
      float changeang = angseg2 - angseg1 + angle1 - angle2;
      //text(changeang*-180/PI, 100, 45);
      float xangp3 = atan2((y[3] - y[2]),(x[3] - x[2]));
      x[1] = x[0] + cos(angseg1+angle1) * segLength;
      y[1] = y[0] + sin(angseg1+angle1) * segLength;
      x[2] = mouseX;
      y[2] = mouseY;
      if(controlend){
        x[3] = x[2] + cos(xangp3 + changeang) * segLength;
        y[3] = y[2] + sin(xangp3 + changeang) * segLength;
        text(xangp3, 100, 45);
        text(changeang, 100, 60);
      }else{
        x[3] = x[2];
        y[3] = y[2] + segLength;
      }
    }else{
      float dx = mouseX - x[0];
      float dy = mouseY - y[0];
      float newangp2 = atan2(dy, dx);  
      float xangp2 = atan2(y[2]-y[1], x[2]-x[1]);
      float changeang = newangp2 - xangp2;
      float xangp3 = atan2((y[3] - y[2]),(x[3] - x[2]));
      x[1] = x[0]+segLength*cos(newangp2);
      y[1] = y[0]+segLength*sin(newangp2);
      x[2] = x[1]+segLength*cos(newangp2);
      y[2] = y[1]+segLength*sin(newangp2);
      if(controlend){
        x[3] = x[2] + cos(xangp3 + changeang) * segLength;
        y[3] = y[2] + sin(xangp3 + changeang) * segLength;
        text(xangp3, 100, 45);
        text(changeang, 100, 60);
      }else{
        x[3] = x[2];
        y[3] = y[2] + segLength;
      }
      
      if(mouseY < 250){
        flip = 1;
      }else{
        flip = -1;
      }
      prevang = newangp2;
    }
  }else if(currentarm == 3){
    float dxp3 = mouseX - x[2];
    float dyp3 = mouseY - y[2];
    float angp3 = atan2(dyp3, dxp3);
    x[3] = x[2] + cos(angp3) * segLength;
    y[3] = y[2] + sin(angp3) * segLength;
  }
}
