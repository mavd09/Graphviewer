public class QueueInteractiveData extends InteractiveFrame {
  private LinkedList<Integer> nodesInQueue;
  private TreeMap<Integer,Integer> minimumDistance;
  
  QueueInteractiveData(Scene scene) {
    super(scene);
    reset();
    setShape("display");
  }
  
  void reset() {
    nodesInQueue = new LinkedList<Integer>();
    minimumDistance = new TreeMap<Integer, Integer>();
  }
  
  void addNode(Node node) {
    nodesInQueue.add(node.nodeId);
    minimumDistance.put(node.nodeId,node.minDistance);
  }
  
  void removeNode() {
    nodesInQueue.poll();
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
    int i = 0;
    for(Map.Entry<Integer,Integer> entry : minimumDistance.entrySet()) {
      Integer key = entry.getKey();
      Integer value = entry.getValue();
      pg.fill(#058B00);
      pg.rect(i*side+2*i, side+2, side, side);
      pg.fill(#FF9100);
      pg.text(""+ value,i*side + 2*i + side/3, 2*side - side/3);
      pg.text(""+ key,i*side + 2*i + side/3, 3*side - side/3);
      i++;
    }
    pg.popStyle();
  }
}