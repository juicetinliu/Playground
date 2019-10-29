ArrayList<PVector> line = new ArrayList<PVector>();
float direction = PI/5;
float speed = 5;
float maxlength = 100;

void setup(){
  fullScreen();
  pixelDensity(displayDensity());
  frameRate(60);
  line.add(new PVector(width/2,height/2));
  line.add(new PVector(width/2,height/2));
}

void draw(){
  background(0);
  stroke(255);
  PVector front = line.get(line.size()-1);
  PVector directionhead = PVector.fromAngle(direction).mult(speed);
  PVector newfront = front.add(directionhead);
  line.remove(line.size()-1);
  
  if(dist(line.get(0).x, line.get(0).y, newfront.x, newfront.y) > maxlength){
    PVector end = line.get(0);
    PVector newend = end.add(directionhead);
    line.remove(0);
    line.add(newend);
  }
  line.add(newfront);
  
  line(line.get(0).x, line.get(0).y, line.get(line.size()-1).x, line.get(line.size()-1).y);

}
