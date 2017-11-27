public class HeapInteractive extends InteractiveFrame implements DataStructureInteractive {
  private Heap<State> nodesInQueue;
  
  HeapInteractive(Scene scene) {
    super(scene);
    reset();
    setShape("display");
  }
  
  void reset() {
    nodesInQueue = new Heap<State>();
  }
  
  void add(Object obj) {
    State state = (State) obj;
    nodesInQueue.put(state);
  }
  
  void remove() {
    nodesInQueue.remove();
  }
  
  void display(PGraphics pg) {
    pg.pushStyle();
    pg.background(100);
    pg.strokeWeight(1);
    pg.stroke(082E00);
    int side = 20;
    pg.fill(0);
    pg.textSize(12);
    pg.text("Heap:",-100, side - side/3);
    pg.textSize(8);
    for(int i = 1; i <= nodesInQueue.size(); i++) {
      pg.fill(#058B00);
      pg.rect(i*side+2*i-70, 0, side, side);
      pg.fill(#FF9100);
      pg.text(""+nodesInQueue.get(i).cost+","+nodesInQueue.get(i).node.nodeId,i*side + 2*i + side/3 - 72, side - side/3);
    }
    pg.popStyle();
  }
}