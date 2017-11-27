public class ResultInteractive extends InteractiveFrame {
  private TreeMap<Integer,Integer> minimumDistance;
  
  ResultInteractive(Scene scene) {
    super(scene);
    reset();
    setShape("display");
  }
  
  void reset() {
    minimumDistance = new TreeMap<Integer, Integer>();
  }
  
  void addResult(Node node) {
    minimumDistance.put(node.nodeId,node.minDistance);
  }
  
  void display(PGraphics pg) {
    pg.pushStyle();
    pg.strokeWeight(1);
    pg.stroke(082E00);
    int side = 20;
    pg.fill(0);
    pg.textSize(14);
    pg.text("Dist:",-100, side - side/3);
    side = 10;
    pg.textSize(10);
    int i = 0;
    for(Map.Entry<Integer,Integer> entry : minimumDistance.entrySet()) {
      Integer key = entry.getKey();
      Integer value = entry.getValue();
      pg.fill(#058B00);
      pg.rect(i*side+2*i-50, side, side, side);
      pg.fill(#FF9100);
      pg.text(""+ key,i*side + 2*i + side/3 - 51, side-2);
      pg.text(""+ value,i*side + 2*i + side/3 - 51 - (value >= 10 ? 3 : 0), 2*side-1);
      i++;
    }
    pg.popStyle();
  }
}