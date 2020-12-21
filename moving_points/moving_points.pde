//ArrayList<Dot>dots;
Plane plane;
void setup(){
  frameRate(100);
  size(1200, 800);
  //dots=new ArrayList<Dot>();
  int n=120;
  plane = new Plane(n);
}
boolean near_dot(Dot dot){
  return dist(dot.pos.x,dot.pos.y,mouseX,mouseY) < 60;
}

//float x=0;
void draw(){
  println(frameRate);
  background(0);
  plane.update();
  
  /*for(int i=0;i<dots.size();i++){
    Dot dot1=dots.get(i);
    for(int j=i+1;j<dots.size();j++){
      Dot dot2=dots.get(j);
      if(dot_dist(dot1,dot2))
        line(dot1.pos.x,dot1.pos.y,dot2.pos.x,dot2.pos.y);
    }
  }*/
}
