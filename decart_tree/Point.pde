class Point{
  int x = 5;
  int y = 5;
  int radius = 18;
  Point(int x_, int y_){
    x = x_;
    y = y_;
  }
  Point(){}
  Point left = null;
  Point right = null;
  
  void show(color c){
    fill(c);
    ellipse(x, y, radius, radius);
  }
  void connect(Point v){
    line(x, y, v.x, v.y);
  }
}
