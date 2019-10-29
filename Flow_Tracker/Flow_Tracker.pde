import gab.opencv.*;
import processing.video.*;

float ellipsex = 320;
float ellipsey = 180;
PVector aveFlow;

OpenCV opencv;
Capture video;

void setup() {
  size(1280, 360);
  video = new Capture(this, 640, 360);
  opencv = new OpenCV(this, 640, 360);
  video.start();
  aveFlow = new PVector(0,0);
}

void draw() {
  background(0);
  video.read();
  opencv.loadImage(video);
  opencv.calculateOpticalFlow();

  image(video, 0, 0);
  ellipsex = ellipsex + 10*aveFlow.x;
  ellipsey = ellipsey + 10*aveFlow.y;
  ellipse(ellipsex,ellipsey,50,50);
  translate(video.width,0);
  //stroke(255,0,0);
  //opencv.drawOpticalFlow();
  
  
  aveFlow = opencv.getAverageFlow();
  int flowScale = 50;
  
  stroke(255);
  strokeWeight(2);
  line(video.width/2, video.height/2, video.width/2 + aveFlow.x*flowScale, video.height/2 + aveFlow.y*flowScale);
}

void captureEvent(Capture c) {
  c.read();
}
void mousePressed() {
  video.stop();
}
