class Tree{
  Point root = null;
  int depth = 1;
  color from = color(0, 0, 255);
  color to = color(0, 255, 0);
  
  color generate_color(int d){
    color c = lerpColor(from, to, (float)d / depth);
    return c;
  }
  
  void draw_down(Point v, Point p, int d){
    if(v == null) return;
    if(d>depth)depth = d;
    //println(v.x, v.y);
    v.connect(p);
    color curr_color = generate_color(d);
    v.show(curr_color);
    
    draw_down(v.left, v, d + 1);
    draw_down(v.right, v, d + 1);
  }
  
  void show(){
    background(150);
    draw_down(root, root, 0);
    println("depth = ", tree.depth);
  }
  
  Point merge(Point left, Point right){
    if(left == null) return right;
    if(right == null) return left;
    if(right.y < left.y){
      right.left = merge(left, right.left);
      return right;
    }
    else{
      left.right = merge(left.right, right);
      return left;
    }
  }
  
  pair split(Point tree, int x){
    if(tree == null) return new pair();
    if(tree.x > x){
      pair t = split(tree.left, x);
      tree.left = t.second;
      return new pair(t.first, tree);
    }
    else{
      pair t = split(tree.right, x);
      tree.right = t.first;
      return new pair(tree, t.second);
    }
  }
  Point del_right(Point v){
    if(v.right == null)
      return null;
    else
      return merge(v, del_right(v.right));
  }
  void delete(int x, int y){
    //root = null;
    pair t = split(root, x);
    Point n = t.first;
    if(n.right == null){
      t.first = t.first.left;
    }
    else{
      while(n.right.right != null)
        n = n.right;
      n.right = n.right.left;
    }
      
    //t.first = del_right(t.first);
    root = merge(t.first, t.second);
  }
  void insert_el(int x, int y){
    Point p = new Point(x, y);
    //println("new point", p.x, p.y);
    if(root == null)
      root = p;
    else{
      pair t = split(root, x);
      root = merge(merge(t.first, p), t.second);
    }
  }
  void insert(int x, int y){
    insert_el(x, y);
  }
  void insert(int x){
    insert_el(x, (int)random(0, height));
  }
  
}
