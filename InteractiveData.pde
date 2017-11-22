public static enum Mode {
  EMPTY,
  INSERT_NODE,
  INSERT_EDGE,
  RUN
}

public static class InteractiveData {
  private static InteractiveData instance;
  private Mode mode;
  private int edgeCounter, nodeCounter;
  private Node lastPicked;
  
  private InteractiveData() {
    resetAll();
  }
  
  void reset() {
    mode = Mode.EMPTY;
    lastPicked = null;
  }
  
  void resetAll() {
    mode = Mode.EMPTY;
    edgeCounter = 0;
    nodeCounter = 0;
    lastPicked = null;
  }
  
  Mode getMode() {
    return mode;
  }
  
  void setMode(Mode mode) {
    this.mode = mode;
  }
  
  Node getLastPicked() {
    return lastPicked;
  }
  
  void setLastPicked(Node lastPicked) {
    this.lastPicked = lastPicked;
  }
  
  int getEdgeCounter() {
    return edgeCounter;
  }
  
  void setEdgeCounter() {
    edgeCounter++;
  }
  
  int getNodeCounter() {
    return nodeCounter;
  }
  
  void setNodeCounter() {
    nodeCounter++;
  }
  
  static InteractiveData getInstance() {
    if( instance == null ) {
      instance = new InteractiveData();
    }
    return instance;
  }
}