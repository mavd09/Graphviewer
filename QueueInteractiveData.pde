public class QueueInteractiveData extends InteractiveFrame {
  LinkedList<Integer> nodesInQueue;
  
  QueueInteractiveData(Scene scene) {
    super(scene);
    nodesInQueue = new LinkedList<Integer>();
    setShape("display");
  }
  
  void addNode(Node node) {
    nodesInQueue.add(node.nodeId);
  }
  
  void display(PGraphics pg) {
    pg.pushStyle();
    pg.strokeWeight(1);
    pg.stroke(082E00);
    int side = 20;
    for(int i = 0; i < nodesInQueue.size(); i++) {
      pg.fill(#058B00);
      pg.rect(i*side+2*i, 0, side, side);
      pg.fill(#FF9100);
      pg.text(""+ nodesInQueue.get(i),i*side + 2*i + side/3, side - side/3);
    }
    pg.popStyle();
  }
}