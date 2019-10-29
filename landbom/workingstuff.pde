void raisepoints(float pointerx, float pointerz, float area, float depth){
  if(pointerx > area/2 && pointerx < h - area/2 && pointerz > area/2 && pointerz < w - area/2){
    for (int z = int((pointerz - area/2)/spacing); z < int((pointerz + area/2)/spacing); z++) {
      for (int x = int((pointerx - area/2)/spacing); x < int((pointerx + area/2)/spacing); x++) {
        float disttobrush = dist(x,z,int(pointerx/spacing),int(pointerz/spacing));
        if(disttobrush <= area/(2*spacing)){
          float raiseamount = area/(2*spacing)-disttobrush;
          terrain[x][z] = terrain[x][z] - depth*raiseamount;
        }
      }
    }
  }
}
void lowerpoints(float pointerx, float pointerz, float area, float depth){
  if(pointerx > area/2 && pointerx < h - area/2 && pointerz > area/2 && pointerz < w - area/2){
    for (int z = int((pointerz - area)/spacing); z < int((pointerz + area/2)/spacing); z++) {
      for (int x = int((pointerx - area)/spacing); x < int((pointerx + area)/spacing); x++) {
        float disttobrush = dist(x,z,int(pointerx/spacing),int(pointerz/spacing));
        if(disttobrush <= area/(2*spacing)){
          float raiseamount = area/(2*spacing)-disttobrush;
          terrain[x][z] = terrain[x][z] + depth*raiseamount;
        }
      }
    }
  }
}

void createwater(){
  pushMatrix();
  tides = lerp(tides,tidechange, 0.001);
  if(tides > 0){
    tidechange = -2;
  }else if(tides < -1){
    tidechange = 1;
  }
  
  translate(0,120+tides,0);
  rotateX(PI/2);
  
  fill(#2767CB,150);
  noStroke();
  rect(0,0,w,h);
  popMatrix();
  //hint(ENABLE_DEPTH_TEST);

}

void createland(){
  pushMatrix();
  translate(0,100,0);
  if(lightson){
    noStroke();
  }else{
    noFill();
    stroke(255,50);
    strokeWeight(1);
  }
  for (int z = 0; z < cols-1; z++) {
    beginShape(TRIANGLE_STRIP);
    randomSeed(z);
    for (int x = 0; x < rows; x++) {
      int grass;
      if(lightson){
        grass = int(random(3));
        if(terrain[x][z] < -250){
          fill(255);
        }else if(terrain[x][z] < -200){
          fill(100);
        }else if(terrain[x][z] > 5){
          fill(#5A4B13);
        }else if(terrain[x][z] > 0){
          fill(#4D6701);
        }else{
          if(grass == 2){
            fill(#129519);
          }else if(grass == 1){
            fill(#109318);
          }else{
            fill(#13A01B);
          }
        }
      }
      //if(z%2 == 0){
      //  vertex(x*spacing, terrain[x][z], z*spacing);
      //  vertex(x*spacing+spacing/2, terrain[x][z+1], (z+1)*spacing);
      //}else{
      //  vertex(x*spacing, terrain[x][z+1], (z+1)*spacing);
      //  vertex(x*spacing+spacing/2, terrain[x][z], (z)*spacing);
      ////rect(x*scl, y*scl, scl, scl);
      //}
      vertex(x*spacing, terrain[x][z], z*spacing);
      if(lightson){
        grass = int(random(3));
        if(terrain[x][z] < -250){
          fill(255);
        }else if(terrain[x][z] < -200){
          fill(100);
        }else if(terrain[x][z] > 5){
          fill(#5A4B13);
        }else if(terrain[x][z] > 0){
          fill(#4D6701);
        }else{
          if(grass == 2){
            fill(#129519);
          }else if(grass == 1){
            fill(#109318);
          }else{
            fill(#13A01B);
          }
        }
      }
      vertex(x*spacing, terrain[x][z+1], (z+1)*spacing);
    }
    endShape();
  }
  popMatrix();
}

void createwalls(){
  float wallheight = 500;
  fill(255,0,0,128);
  pushMatrix();
  translate(0,100-wallheight,0);
  rect(0,0,h-spacing,wallheight);
  translate(0,0,w-spacing);
  rect(0,0,h-spacing,wallheight);
  popMatrix();
  pushMatrix();
  translate(0,100-wallheight,0);
  rotateY(-PI/2);
  rect(0,0,w-spacing,wallheight);
  translate(0,0,spacing-h);
  rect(0,0,w-spacing,wallheight);
  popMatrix();
}
