class Dot{
  PVector pos;
  PVector vel;
  Dot(){
    pos=new PVector();
    pos.x=random(width);
    pos.y=random(height);
    vel=PVector.random2D();
  }
  void show(){
    ellipse(pos.x,pos.y,5,5);
  }
  void update(){
    pos.add(vel);
    if(pos.x>width||pos.x<0)vel.x*=-1;
    if(pos.y>height||pos.y<0)vel.y*=-1;
  }
}
