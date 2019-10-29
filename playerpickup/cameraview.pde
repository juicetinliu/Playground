void cameraview(PVector playerpos, float amount){
  camerapos.x = lerp(camerapos.x, playerpos.x, amount);
  camerapos.y = lerp(camerapos.y, playerpos.y, amount);
  //int offsetxplus = int(camerapos.x - playerpos.x);
  //int offsetyplus = int(camerapos.y - playerpos.y);
  pushMatrix();
  translate(width/2, height/2);
  fill(255);
  noStroke();
  ellipse(camerapos.x, camerapos.y, 10,10);
  popMatrix();
}
