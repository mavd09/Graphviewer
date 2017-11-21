public static class InteractiveData {
  public static final float RADIUS_NODE = 10;
  private PFont font1; 
  private static InteractiveData instance;
  private int edgeCounter, nodeCounter, mode;
  private Node lastPicked;
  
  private InteractiveData() {
    resetAll();
  }
  
  void reset() {
    mode = 0;
    lastPicked = null;
  }
  
  void resetAll() {
    mode = 0;
    edgeCounter = 0;
    nodeCounter = 0;
    lastPicked = null;
  }
  
  int getMode() {
    return mode;
  }
  
  void setMode(int mode) {
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