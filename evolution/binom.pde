

enum Action {
 UP,
 RIGHT,
 DOWN,
 LEFT,
 WAIT
}

class Binom {
  Brain brain;
  int score;
  
  Binom() {
    brain = new Brain(Action.values().length, CellContent.values().length);
    brain.initRandom();
    score = initScore;
  }
  
  Action chooseAction(Cell[][] cells, int posX, int posY) {
    float[] probs = brain.getActionsProbs(cells, posX, posY);
    Action[] values = Action.values();
    Action action = Action.UP;
    float maxProb = -inf;
    for(int i = 0; i < Action.values().length; i++) {
      if (probs[i] > maxProb) {
        action = values[i];
        maxProb = probs[i];
      }
    } 
    return action;
  }
  
  Binom clone() {
    Binom newBinom = new Binom();
    newBinom.brain = brain.clone();
    newBinom.brain.mutate(brainMutatePercent, maxBrainMutate);
    return newBinom;
  }
}
