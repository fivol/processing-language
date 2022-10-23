

class Event {
  Cell cell;
  Action action;
  Event(Cell c, Action a) {
    cell = c;
    action = a;
  }
}

class World {
  Cell[][] cells;
  
  World(int cellsWidth, int cellsHeight) {
    cells = new Cell[cellsWidth][cellsHeight];
    for(int x = 0; x < cells.length; x++) {
      for(int y = 0; y < cells[0].length; y++) {
        cells[x][y] = new Cell(new PVector(x * cellSize, y * cellSize), x, y, cellSize);
      }
    }
  }
  
  void initRandom() {
    for(int x = 0; x < cells.length; x++) {
      int columnLen = cells[0].length;
      for(int y = 0; y < columnLen; y++) {
        float r = random(1);
        if (r < 0.05) {
          cells[x][y].fillWith(CellContent.FOOD);
        } else if(r < 0.1) {
          cells[x][y].fillWith(CellContent.BINOM);
          Binom binom = new Binom();
          cells[x][y].binom = binom;
        }
      }
    }
  }
  
  void moveBinom(Cell cell, int x, int y) {
    int nextX = cell.x + x;
    int nextY = cell.y + y;
    if(nextX < 0) {nextX = 0;}
    if(nextY < 0) {nextY = 0;}
    if(nextX >= cells.length) {nextX = cells.length-1;}
    if(nextY >= cells[0].length) {nextY = cells[0].length-1;}
    if(cells[nextX][nextY].type == CellContent.BINOM) {
      return;
    }
    Binom binom = cell.binom;
    cell.binom = null;
    cell.fillWith(CellContent.EMPTY);
    Cell nextCell = cells[nextX][nextY];
    nextCell.binom = binom;
    if (nextCell.type == CellContent.FOOD) {
      binom.score += foodScore;
    }
    nextCell.fillWith(CellContent.BINOM);
  }
  
  void applyEvents(Event[] events) {
    for(Event event: events) {
      switch (event.action) {
        case WAIT:
          break;
        case UP:
          moveBinom(event.cell, 0, -1);
          break;
        case DOWN:
          moveBinom(event.cell, 0, 1);
          break;
        case LEFT:
          moveBinom(event.cell, -1, 0);
          break;
        case RIGHT:
          moveBinom(event.cell, 1, 0);
          break;
      }
    }
  }
  
  void handleBinomStep(Cell cell) {
    Binom bin = cell.binom;
    bin.score--;
    if(bin.score == 0) {
      cell.fillWith(CellContent.EMPTY);
    }
  }
  
  Event[] calcEvents() {
    Event[] events = {};
      for(int x = 0; x < cells.length; x++) {
        for(int y = 0; y < cells[0].length; y++) {
          if (cells[x][y].type == CellContent.BINOM) {
            Action action = cells[x][y].binom.chooseAction(cells, x, y);
            handleBinomStep(cells[x][y]);
            if (cells[x][y].type == CellContent.BINOM){
              events = (Event[])append(events, new Event(cells[x][y], action));
            }
          }
        }
      }
      return events;
  }
  
  void update() {
    Event[] events = calcEvents();
    applyEvents(events);
  }
  
  void display() {
    for(int x = 0; x < cells.length; x++) {
      for(int y = 0; y < cells[0].length; y++) {
        cells[x][y].display();
      }
    }
  }
}
