

class Brain {
  float [][][][] data;
  int cellTypesCount;
  int actionsCount;

  Brain (int actionsCount_, int cellTypesCount_) {
    cellTypesCount = cellTypesCount_;
    actionsCount = actionsCount_;
    data = new float[binViewSize*2 + 1][binViewSize*2 + 1][cellTypesCount_][actionsCount_];
  }

  void initRandom() {
    for (int action = 0; action < actionsCount; action ++) {
      for (int cellType = 0; cellType < cellTypesCount; cellType++) {
        for (int i = 0; i < binViewSize; i++) {
          for (int j = 0; j < binViewSize; j++) {
            data[i][j][cellType][action] = random(2) * 2 - 1;
          }
        }
      }
    }
  }

  void mutate(float percentMutateCells, float maxMutate) {
    for (int action = 0; action < actionsCount; action ++) {
      for (int cellType = 0; cellType < cellTypesCount; cellType++) {
        for (int i = 0; i < binViewSize; i++) {
          for (int j = 0; j < binViewSize; j++) {
            if (random(1) < percentMutateCells) {
              data[i][j][cellType][action] += random(maxMutate);
            }
          }
        }
      }
    }
  }

  float[] getActionsProbs(Cell[][] cells, int posX, int posY) {
    float[] actionProbs = new float[actionsCount];
    for (int action = 0; action < actionsCount; action++) {
      float prob = 0;
      for (int cellType = 0; cellType < cellTypesCount; cellType++) {
        for (int x = -binViewSize; x <= +binViewSize; x++) {
          for (int y = -binViewSize; y <= +binViewSize; y++) {
            int cellX = x + posX;
            int cellY = y + posY;
            if (cellX < 0 || cellX >= cells.length) {
              continue;
            }
            if (cellY < 0 || cellY >= cells[0].length) {
              continue;
            }
            if (cells[cellX][cellY].type.ordinal() == cellType) {
              prob += data[x + binViewSize][y + binViewSize][cellType][action];
            }
          }
        }
      }
      actionProbs[action] = prob;
    }

    return actionProbs;
  }

  Brain clone() {
    Brain newBrain = new Brain(actionsCount, cellTypesCount);
    arrayCopy(data, newBrain.data);
    return newBrain;
  }
}
