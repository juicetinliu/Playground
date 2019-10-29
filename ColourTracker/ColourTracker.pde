/**
 * Brightness Tracking 
 * by Golan Levin. 
 *
 * Tracks the brightest pixel in a live video signal. 
 */


import processing.video.*;

Capture video;

int cindex;
float cred, cgreen, cblue;

void setup() {
  frameRate(30);
  size(640, 480);
  // Uses the default video input, see the reference if this causes an error
  video = new Capture(this, width, height);
  video.start();  
  noStroke();
  smooth();
}

void draw() {
  if (video.available()) {
    video.read();
    image(video, 0, 0, width, height); 
    int colourX = 0;
    int colourY = 0;
    float bestValue = 442;
    
    video.loadPixels();
    int index = 0;
      for (int y = 0; y < video.height; y++) {
      for (int x = 0; x < video.width; x++) {
        
        float pred = red(video.pixels[index]);
        float pgreen = green(video.pixels[index]);
        float pblue = blue(video.pixels[index]);
        
        float pixelColour = abs(dist(cred,cgreen,cblue,pred,pgreen,pblue));
        
        if (pixelColour < bestValue) {
          bestValue = pixelColour;
          colourY = y;
          colourX = x;
        }
        index++;
      }
      }
    fill(255, 255, 255, 128);
    ellipse(colourX, colourY, 100, 100);
  }
}

void mouseClicked(){
      cindex = mouseX+mouseY*width;
      cred = red(video.pixels[cindex]);
      cgreen = green(video.pixels[cindex]);
      cblue = blue(video.pixels[cindex]);
}
