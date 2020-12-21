Tree tree;
PVector old_coord;
void setup(){
  old_coord = new PVector();
  tree = new Tree();
  size(1500, 900);
  background(150);
  for(int i = 0; i < 50; i++){
    //tree.insert((int)random(0, width));
  }
  tree.show();
}
boolean clicked = false;
int c = 0;
int max_c = 10;

void draw(){
  if(clicked){
    int x = mouseX;
    int y = mouseY;
    tree.delete((int)old_coord.x, (int)old_coord.y);
    old_coord.x = x;
    old_coord.y = y;
    tree.insert(x, y);
    tree.show();
  }
}

void mousePressed(){
  int x = mouseX;
  int y = mouseY;
  if(mouseButton == LEFT) {
    tree.insert(x, y);
    old_coord.x = x;
    old_coord.y = y;
    clicked = true;
  }
  if(mouseButton == RIGHT) tree.insert(x);
  //if(mouseButton == 3 && tree != null)clicked = true;
  
  tree.show();
  
}
void mouseReleased(){
  clicked = false;
}
