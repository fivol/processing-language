import controlP5.*;
ControlP5 cp5;


ArrayList<PVector>vert;
ArrayList<PVector>lines;
Textarea myTextarea;
int find(int x,int y){
  for(int i=0;i<vert.size();i++){
    PVector v=vert.get(i);
    if(dist(x,y,v.x,v.y)<min_dist)return i;
  }
  return -1;
}
boolean show=true;
void setup(){
  size(1000,600);
  vert=new ArrayList<PVector>();
  lines=new ArrayList<PVector>();
  
  PFont font = createFont("arial",20);
  
  cp5 = new ControlP5(this);
  
  myTextarea=cp5.addTextarea("")
     .setPosition(width-120,10)
     .setSize(80,500)
     .setFont(font)
     //.isCollapse(true)
     .setColor(color(255))
     ;
  cp5.addButton("Clear")
     //.setValue(0)
     .setPosition(10,10)
     .setSize(200,19)
     ;
}
int diametr=20;
int min_dist=50;
boolean drag=false;
boolean move_vert=false;
PVector clicked;
int clicked_vert;
String str="";
boolean delete=false;
void draw(){
  textSize(30);
  background(0);
  if(delete){
    delete=false;
    while(vert.size()!=0)vert.remove(0);
    while(lines.size()!=0)lines.remove(0);
  }
  if(drag){
    strokeWeight(2);
    stroke(255);
    line(clicked.x,clicked.y,mouseX,mouseY);
  }else if(move_vert){
    vert.get(clicked_vert).x=mouseX;
    vert.get(clicked_vert).y=mouseY;
  }
  str=str(vert.size())+" "+str(lines.size())+"\n";
  //println("loop",lines.size());
  for(int i=0;i<lines.size();i++){
    PVector l=lines.get(i);
    str+=str((int)l.x+1)+" "+str((int)l.y+1)+"\n";
    
    strokeWeight(4);
    stroke(255);
    //println("!!",l.x,l.y);
    line(vert.get((int)l.x).x,vert.get((int)l.x).y,
    vert.get((int)l.y).x,vert.get((int)l.y).y);
  }
  
  
  for(int i=0;i<vert.size();i++){
    PVector v=vert.get(i);
    fill(0, 102, 153);
    strokeWeight(2);
    stroke(100,100,255);
    ellipse(v.x,v.y,diametr,diametr);
    fill(255);
    text(str(i+1), v.x-diametr, v.y-diametr);
  }
  if(show){
    show=false;
    myTextarea.setText(str);
    println(str.replace('\n', ' '));
  }
}
public void Clear() {
  delete=true;
  //println(vert.size(),"size");
}
void new_vert(int x,int y){
  
  vert.add(new PVector(x,y));
}
void new_line(int x,int y){
  //println(x,y);
  lines.add(new PVector(x,y));
}
int find_line(int x,int y){
  for(int i=0;i<lines.size();i++){
    PVector l=lines.get(i);
    if(x==l.x&&y==l.y||x==l.y&&y==l.x)return i;
  }
  return -1;
}
void mouseReleased(){
  show=true;
  
  int x=mouseX;
  int y=mouseY;
  if(drag){
    int curr_v=find(x,y);
    if(curr_v==-1){
      new_vert(x,y);
    }
    if(curr_v==-1)curr_v=vert.size()-1;
    if(clicked_vert!=curr_v&&find_line(curr_v,clicked_vert)==-1)
    new_line(curr_v, clicked_vert);
    drag=false;
  }
  else if(move_vert){
    move_vert=false;
  }
  
}

void mousePressed(){
  
  
  //println(mouseButton);
  int x=mouseX;
  int y=mouseY;
  clicked_vert=find(x,y);
  if(mouseButton == LEFT){
    if(clicked_vert==-1) {
      new_vert(x,y);
      clicked_vert=vert.size()-1;
    }
    clicked=new PVector(x,y);
    drag=true;
  }
  else if(clicked_vert!=-1){
    if(mouseButton == RIGHT){
      move_vert=true;
    }else if(mouseButton == 3){
      vert.remove(clicked_vert);
      int i=0;
      while(i<lines.size()){
        PVector l=lines.get(i);
        if(l.x==clicked_vert||l.y==clicked_vert){
          lines.remove(i);
        }
        else{
          if(l.x>clicked_vert)lines.get(i).x--;
          if(l.y>clicked_vert)lines.get(i).y--;
          i++;
        }
      }
      //println(lines.size(),"size");
    }
  }else if(mouseButton==3){
    double x1,x2,x3,y1,y2,y3,a,b;
    double line_delta=7;
    x3=x;
    y3=y;
    for(int i=0;i<lines.size();i++){
      PVector l=lines.get(i);
      x1=vert.get((int)l.x).x;
      y1=vert.get((int)l.x).y;
      x2=vert.get((int)l.y).x;
      y2=vert.get((int)l.y).y;
      if(x2-x1!=0)
        a=(y2-y1)/(x2-x1);
      else a=1000000;
      b=y1-a*x1;
      if(abs((float)(a*x3+b-y3))<line_delta){
        lines.remove(i);
        break;
      }
    } 
  }
}
