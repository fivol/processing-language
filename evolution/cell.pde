
enum CellContent {
  EMPTY,
  FOOD,
  BINOM
}

class Cell {
  Binom binom;
  CellContent type = CellContent.EMPTY;
  
  PVector start;
  int size;
  int x, y;
  
  Cell(PVector start_, int x_, int y_, int size_) {
    start = start_;
    x = x_;
    y = y_;
    size = size_;
  }
  
  void fillWith(CellContent type_) {
    type = type_;
  }
  
  void setBinom(Binom bin) {
    binom = bin;
  }
  
  void display() {
    if (type == CellContent.EMPTY) {
      fill(255, 255, 255);
    } else if (type == CellContent.BINOM) {
      fill(0, 0, 255);
    } else if (type == CellContent.FOOD) {
      fill(0, 255, 0);
    }
    rect(start.x, start.y, size, size);
  }
}
