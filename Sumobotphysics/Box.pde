// A rectangular box
class Sumobot {
  //  Instead of any of the usual variables, we will store a reference to a Box2D Body
  Body body;      
  
  float w,h;
  Vec2 position;
  float direction;
  float startingdirection;

  Sumobot(float x, float y, float dir, float mass) {
    w = 40;
    h = 50;
    startingdirection = radians(dir);
    direction = -startingdirection;
    position = new Vec2(350+x*10,350+y);
    // Build Body
    BodyDef bd = new BodyDef();      
    bd.type = BodyType.DYNAMIC;
    bd.position.set(x,y);
    body = box2d.createBody(bd);


   // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    //float box2dW = box2d.scalarPixelsToWorld(w/2);
    //float box2dH = box2d.scalarPixelsToWorld(h/2);  // Box2D considers the width and height of a
    sd.setAsBox(w/20, h/20);            // rectangle to be the distance from the
                           // center to the edge (so half of what we
                          // normally think of as width or height.) 
    // Define a fixture
    FixtureDef sumobody = new FixtureDef();
    sumobody.shape = sd;
    // Parameters that affect physics
    sumobody.density = mass;
    sumobody.friction = 0;
    sumobody.restitution = 0;

    // Attach Fixture to Body               
    body.createFixture(sumobody);
    //body.createFixture(frontpart);
    
  }
  
  void killBody() {
    box2d.destroyBody(body);
  }
  
  void display(int player) {
    // We need the Body’s location and angle
    Vec2 pos = box2d.getBodyPixelCoord(body);    
    float a = body.getAngle()+startingdirection;
    
    pushMatrix();
    translate(pos.x,pos.y);    // Using the Vec2 position and float angle to
    rotate(-a);              // translate and rotate the rectangle
    if(player == 0){
      fill(255, 222, 181, 120);
      stroke(255, 222, 181, 255);
    }else{
      fill(255, 120);
      stroke(255);
    }
    rectMode(CENTER);
    line(0,0,30,0);
    rect(0,0,w,h);
    popMatrix();
  }
  
  void move(float lmpower,float rmpower) {
    // From BoxWrap2D example
    Vec2 pos = box2d.getBodyPixelCoord(body);
    position = pos;
    direction = (-body.getAngle()-startingdirection) % (2*PI);
    Vec2 moveForce = new Vec2(0,0);
    moveForce.normalize();
    float rotateamount = map(lmpower - rmpower, 200, -200, radians(180), radians(-180));
    moveForce.x = map(lmpower + rmpower, 200, -200, 16, -16)*cos(body.getAngle()+startingdirection);
    moveForce.y = map(lmpower + rmpower, 200, -200, 16, -16)*sin(body.getAngle()+startingdirection);
    //+ rotateamount
    //moveForce.rotate(body.getAngle() + rotateamount);
    //moveforce.add(pos.x,pos.y);
    //directionhuman = directionhuman + rotateamount;
    Vec2 printforce;
    printforce = body.getLinearVelocity();
    stroke(255,0,0);
    line(pos.x+3*printforce.x, pos.y-3*printforce.y, pos.x, pos.y);
    // Now apply it to the body's center of mass.
    body.setLinearVelocity(moveForce);
    body.setAngularVelocity(-rotateamount);
    //line(200+moveForce.x, 200-moveForce.y, 200, 200);
  }
  
  void applyFriction(float frifactor){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    position = pos;
    direction = (-body.getAngle()-startingdirection) % (2*PI);
    Vec2 currentVelocity;
    currentVelocity = body.getLinearVelocity();
    body.setLinearVelocity(currentVelocity.mulLocal(frifactor));
    body.setAngularVelocity(body.getAngularVelocity() * frifactor);
  }
}
