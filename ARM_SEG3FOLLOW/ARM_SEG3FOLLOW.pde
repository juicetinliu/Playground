/**
 * Follow 1  
 * based on code from Keith Peters. 
 * 
 * A line segment is pushed and pulled by the cursor.
 */

float x = 100;
float y = 100;
float angle1 = 0.0;
float segLength = 50;

void setup() {
  size(640, 360);
  strokeWeight(20.0);
  stroke(255, 100);
}

void draw() {
  background(0);
  
  float dx = mouseX - x;
  float dy = mouseY - y;
  angle1 = atan2(dy, dx);  
  x = mouseX - (cos(angle1) * segLength);
  y = mouseY - (sin(angle1) * segLength);
  
  strokeWeight(0);
  fill(255,100);
  ellipse(width/2, height/2, 200, 200);
  
  if(sq(x - width/2) + sq(y - height/2) > sq(100)){
    fill(255,0,0);
    float dfx = x - width/2;
    float dfy = y - height/2;
    float anglef = atan2(dfy, dfx);
    float fx = width/2 + (cos(anglef) * 100);
    float fy = height/2 + (sin(anglef) * 100);
    float mfx = mouseX - fx;
    float mfy = mouseY - fy;
    float anglem = atan2(mfy, mfx);
    float mx = fx + (cos(anglem) * segLength);
    float my = fy + (sin(anglem) * segLength);
    strokeWeight(20.0);
    line(fx, fy, mx, my); 
    ellipse(fx, fy, 20, 20);
  }else{
    fill(255);
    strokeWeight(20.0);
    line(x, y, mouseX, mouseY); 
    ellipse(x, y, 20, 20);
  }
}
