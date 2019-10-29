class Spacecloud{
  int maxparticles,scale;
  ArrayList<PVector> cloud = new ArrayList<PVector>();
  Spacecloud(int maxp, int scale){
    this.maxparticles = maxp;
    this.scale = scale;
  }
  
  void createCloud(float x, float y, float z){
    for(int i = 0; i < maxparticles; i++){
      PVector newpoint = new PVector(random(x-scale,x+scale),random(y-scale,y+scale),random(z-scale,z+scale));
      cloud.add(newpoint);
    }
  }
  
  void updateCloud(float x, float y, float z){
    for(int j = 0; j < cloud.size(); j++){
      if(dist(cloud.get(j).x, cloud.get(j).y, cloud.get(j).z, x, y, z) > scale*5){
        cloud.remove(j);
        PVector newpoint = new PVector(random(x-scale,x+scale),random(y-scale,y+scale),random(z-scale,z+scale));
        cloud.add(newpoint);
      }
    }
  }
  
  void drawCloud(){
    for(PVector cloudpoint : cloud){
      stroke(255);
      point(cloudpoint.x, cloudpoint.y, cloudpoint.z);
    }
  }
  
}
