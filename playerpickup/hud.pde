void hud(){
  strokeWeight(5);
  stroke(255);
  noFill();
  rect(width/2-450,height/2-300,900,550);
  
  //fill(hudcolor);
  fill(0);
  rect(width/2-300, height-120,600,100);
  
  rect(width-120, height/2-200,100,400);
  int inventorycounter = 0;
  for(int in = 0; in < p1.inventory.size(); in++){
    item thisitem = p1.inventory.get(in);
    if(in % 2 == 0){
      thisitem.display(width-120+25,height/2-200+25+inventorycounter*50,2, false);
    }else{
      thisitem.display(width-120+70,height/2-200+25+inventorycounter*50,2, false);
      inventorycounter++;
    }
  }
  
  
  
  fill(255);
  text(frameRate,0,10);
  //text(frameCount,0,20);
}
