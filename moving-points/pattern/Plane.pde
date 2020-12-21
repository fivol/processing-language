class Plane{
  
  int side = 100;
  int num = width / side + 1;
  ArrayList<ArrayList<ArrayList<Dot>>>sheet;
  
  int get_box(Dot d){
    float x = d.pos.x;
    float y = d.pos.y;
    int a = (int)x / side;
    int b = (int)y / side;
    return a * num + b;
  }
  
  Plane(int count){
    sheet = new ArrayList<ArrayList<ArrayList<Dot>>>();
    println(num);
    for(int i = 0; i < num; i++){
      sheet.add(new ArrayList<ArrayList<Dot>>());
      for(int j = 0 ; j < num; j++)sheet.get(i).add(new ArrayList<Dot>());
    }
    println(sheet.size());
    println(sheet.get(0).size());
    for(int i = 0; i < count; i++){
      sheet.get(0).get(0).add(new Dot());
    }
    update();
  }
  void one_line(Dot a, Dot b){
    if(dot_dist(a, b))
      line(a.pos.x, a.pos.y, b.pos.x, b.pos.y);  
  }
  void draw_sheet(){
    
    for(int i = 0; i < width; i+= side){
      line(i, 0, i, height);
    }
    for(int i = 0; i < height; i+= side){
      line(0, i, width, i);
    }
  }
  boolean dot_dist(Dot a,Dot b){
    return dist(a.pos.x,a.pos.y,b.pos.x,b.pos.y) < 80;
  }
  void draw_lines(){
    for(int i = 0; i < num - 1; i++){
      for(int j = 0; j < num - 1; j++){
        for(int c = 0; c < sheet.get(i).get(j).size(); c++){
          for(int a = 0; a < 2; a++){
            for(int b = 0; b < 2; b++){
              for(int v = 0; v < sheet.get(i + a).get(j + b).size(); v++)
              one_line(sheet.get(i).get(j).get(c), sheet.get(i + a).get(j + b).get(v));
            }
          }
        }
        
      }
    }
  }
  void update(){
    stroke(50);
    draw_sheet();
    stroke(255);
    for(int i = 0; i < num; i++){
      for(int j = 0; j < num; j++){
        int curr = i * num + j;
        for(int k = 0; k < sheet.get(i).get(j).size(); k++){
          Dot dot = sheet.get(i).get(j).get(k);
          dot.update();
          dot.show();
          int pos = get_box(dot);
          if(pos != curr){
            sheet.get(pos / num).get(pos % num).add(dot);
            sheet.get(i).get(j).remove(k);
            k--;
          }
        }
      }
    }
    draw_lines();
  }
  
}
