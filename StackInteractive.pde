public class StackInteractive extends InteractiveFrame implements DataStructureInteractive {
  private LinkedList<Integer> nodesInQueue;
  
  StackInteractive(Scene scene) {
    super(scene);
    reset();
    setShape("display");
  }
  
  void reset() {
    nodesInQueue = new LinkedList<Integer>();
  }
  
  void add(Object obj) {
    Node node = (Node) obj;
    nodesInQueue.addLast(node.nodeId);
  }
  
  void remove() {
    nodesInQueue.pollLast();
  }
  
  void display(PGraphics pg) {
    pg.pushStyle();
    pg.background(100);
    pg.strokeWeight(1);
    pg.stroke(082E00);
    int side = 20;
    pg.fill(0);
    pg.textSize(14);
    pg.text("Stack:",-100, side - side/3);
    pg.textSize(10);
    for(int i = 0; i < nodesInQueue.size(); i++) {
      pg.fill(#058B00);
      pg.rect(i*side+2*i-50, 0, side, side);
      pg.fill(#FF9100);
      pg.text(""+ nodesInQueue.get(i),i*side + 2*i + side/3 - 50, side - side/3);
    }
    pg.popStyle();
  }
}