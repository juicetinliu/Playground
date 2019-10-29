int tilesize = 5;
int rows = 600/tilesize;
int cols = 1100/tilesize;
float[][] terrain = new float[cols][rows];
float craziness = 0.05;
float height1, height2, height3, height4, height5;
prey poorguy;

void setup(){
  fullScreen(P3D);
  pixelDensity(displayDensity());
  frameRate(60);
  smooth();
  noiseSeed(3323);
  float noisex = 0;
  for(int x = 0; x < cols; x++){
    float noisey = 0;
    for(int y = 0; y < rows; y++){
      terrain[x][y] = noise(noisex,noisey);
      noisey += craziness;
    }
    noisex += craziness;
  }
  height1 = 0.65;
  height2 = 0.59;
  height3 = 0.5;  
  poorguy = new prey(width/2, height/2, 0,1,150);
}

void draw(){
  background(0);
  for(int x = 0; x < cols; x++){
    for(int y = 0; y < rows; y++){
        noStroke();
      //fill(map(terrain[x][y],0,1,0,255));
      landcolours(x, y);
      rect(width/2+(x-cols/2)*tilesize, height/2+(y-rows/2)*tilesize, tilesize, tilesize);
    }
  }
  terrainbar();
  poorguy.display();
  poorguy.move();
  //poorguy.avoidwater(tilesize,cols,rows, terrain, height1);
}

void landcolours(int x, int y){
  if(terrain[x][y] >= height1){
    fill(#3B8FE8);
  //}else if(terrain[x][y] > 0.6){
  //  fill(#F5E888);
  }else if(terrain[x][y] >= height2 && terrain[x][y] < height1){
    fill(#778130);
  }else if(terrain[x][y] >= height3 && terrain[x][y] < height2){
    fill(#409013);
  }else{
    fill(#18B419);
  }
}

void terrainbar(){
  stroke(255);
  float bar1 = map(height1,0,1,400,0);
  float bar2 = map(height2,0,1,400,0);
  float bar3 = map(height3,0,1,400,0);
  fill(#18B419);
  rect(20,height/2-200,40,400);
  fill(#409013);
  rect(20,height/2+200-bar3,40,bar3);
  fill(#778130);
  rect(20,height/2+200-bar2,40,bar2);
  fill(#3B8FE8);
  rect(20,height/2+200-bar1,40,bar1);
}
