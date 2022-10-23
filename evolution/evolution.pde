
int cellSize = 20;
// Сколько бином видит клеток с каждой из сторон
int binViewSize = 5;
float maxBrainMutate = 0.1;
float brainMutatePercent = 0.2;

int initScore = 20;
int foodScore = 10;

int worldWidth;
int worldHeight;
float inf = 100000;

World world;

void setup() {
  size(800, 600);
  worldWidth = width / cellSize;
  worldHeight = height / cellSize;
  world = new World(worldWidth, worldHeight);
  world.initRandom();
  frameRate(3);
}

void draw() {
  world.update();
  world.display();
}
