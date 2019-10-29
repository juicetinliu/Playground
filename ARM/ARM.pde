float[] x = new float[4];
float[] y = new float[4];
int[] a = new int[4];
float segLength = 50;
float rboxheight = 15.6;
float armtobox = 11.7;
float armheight = 130;
int flip = 1;
float prevang = 0.0;


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
  changearms();
  drawrover();
  strokeWeight(8.0);
  stroke(255, 128); 
  ellipse(x[0], y[0], 10, 10);
  line(x[0], y[0], x[1], y[1]);
  ellipse(x[1], y[1], 10, 10);
  line(x[1], y[1], x[2], y[2]);
  ellipse(x[2], y[2], 10, 10);
  line(x[2], y[2], x[3], y[3]);
  ellipse(x[3], y[3], 10, 10);
  
  hoverpoint();
  
  text("x", 10, 15);
  text("|  y", 60, 15);
  for(int i = 0; i < 4; i++){
    int xcor = round(x[i] - 250);
    int ycor = round(y[i] - 250);
    text(xcor, 10, 35+i*20);
    text("|  " + ycor, 60, 35+i*20);
  }
  
  a[0] = round((-180 * atan2((y[1] - y[0]),(x[1] - x[0])) / PI));
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

void changearms(){
  if(sq(mouseX - x[1]) + sq(mouseY - y[1]) <= sq(20)){
    if(mousePressed == true){
      float dxp1 = mouseX - x[0];
      float dyp1 = mouseY - y[0];
      float angp1 = atan2(dyp1, dxp1);
      float xangp1 = atan2(y[1]-y[0], x[1]-x[0]);
      float addang = angp1 - xangp1;
      float xangp2 = atan2((y[2] - y[1]),(x[2] - x[1]));
      //float xangp3 = atan2((y[3] - y[2]),(x[3] - x[2]));
      if(-180 * angp1 / PI <= 130 && -180 * angp1 / PI >= -130){
        x[1] = x[0] + cos(angp1) * segLength;
        y[1] = y[0] + sin(angp1) * segLength;
        x[2] = x[1] + cos(xangp2 + addang) * segLength;
        y[2] = y[1] + sin(xangp2 + addang) * segLength;
        x[3] = x[2];
        y[3] = y[2] + segLength;
      }
      
      //x[3] = x[2] + cos(xangp3 + addang) * segLength;
      //y[3] = y[2] + sin(xangp3 + addang) * segLength;
      
    }
  //}else if(sq(mouseX - x[2]) + sq(mouseY - y[2]) <= sq(20)){
  //  if(mousePressed == true){
  //    float dxp2 = mouseX - x[1];
  //    float dyp2 = mouseY - y[1];
  //    float angp2 = atan2(dyp2, dxp2);
  //    float xangp2 = atan2(y[2]-y[1], x[2]-x[1]);
  //    float addang = angp2 - xangp2;
  //    float xangp3 = atan2((y[3] - y[2]),(x[3] - x[2]));
  //    x[2] = x[1] + cos(angp2) * segLength;
  //    y[2] = y[1] + sin(angp2) * segLength;
  //    x[3] = x[2];
  //    y[3] = y[2] + segLength;
  //    //x[3] = x[2] + cos(xangp3 + addang) * segLength;
  //    //y[3] = y[2] + sin(xangp3 + addang) * segLength;
  //    if(a[1] > 0){
  //        flip = 1;
  //    }else if(a[1] <= 0){
  //        flip = -1;
  //    }
  //  }
  //}else if(sq(mouseX - x[3]) + sq(mouseY - y[3]) <= sq(20)){
  //  if(mousePressed == true){
  //    float dxp3 = mouseX - x[2];
  //    float dyp3 = mouseY - y[2];
  //    float angp3 = atan2(dyp3, dxp3);
  //    x[3] = x[2] + cos(angp3) * segLength;
  //    y[3] = y[2] + sin(angp3) * segLength;
  //  }
  }
  
  if(sq(mouseX - x[2]) + sq(mouseY - y[2]) <= sq(20)){
    if(mousePressed == true){
    //float dx2 = mouseX - x[2];
    //float dy2 = mouseY - y[2];
    //float angseg3 = atan2(dy2, dx2);  
    //x[2] = mouseX - cos(angseg3) * segLength;
    //y[2] = mouseY - sin(angseg3) * segLength;
    if(sq(mouseX - 250) + sq(mouseY - 250) <= sq(2 * segLength)){
        float dx = x[2] - x[0];
        float dy = y[2] - y[0];
        float angle = atan2(dy, dx);  
        float angseg1 = flip * acos(sqrt(sq(dx) + sq(dy)) / (2 * segLength));
        x[1] = x[0]+segLength*cos(angseg1+angle);
        y[1] = y[0]+segLength*sin(angseg1+angle);
        float actualX = mouseX;
        float actualY = mouseY;
        x[2] = actualX;
        y[2] = actualY;
        x[3] = x[2];
        y[3] = y[2] + segLength;
        ellipse(actualX, actualY, 10, 10);
      }else{
        float dx = mouseX - x[0];
        float dy = mouseY - y[0];
        float angle = atan2(dy, dx);  
        float angseg1 = angle;
        float angseg2 = angle;
        x[1] = x[0]+segLength*cos(angseg1);
        y[1] = y[0]+segLength*sin(angseg1);
        x[2] = x[1]+segLength*cos(angseg2);
        y[2] = y[1]+segLength*sin(angseg2);
        //float actualX = x[2] + cos(angseg3) * segLength;
        //float actualY = y[2] + sin(angseg3) * segLength;
        //x[3] = actualX;
        //y[3] = actualY;
        x[3] = x[2];
        y[3] = y[2] + segLength;
        
        if(prevang - angseg2 > 0){
          flip = 1;
        }else{
          flip = -1;
        }
        prevang = angseg2;
      }
    }
  }
}
