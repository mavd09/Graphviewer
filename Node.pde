public class Node extends InteractiveFrame implements Comparable<Node> {
  int nodeId;
  float radius;
  Graph graph;
  Scene scene;
  Node(int nodeId, float radius, Graph graph, Scene scene) {
     super(scene);
     this.nodeId = nodeId;
     this.radius = radius;
     this.graph = graph;
     this.scene = scene;
     setShape("display");
     setClickBinding(LEFT, 1, "play");
  }
  
  void display(PGraphics pg) {
    pg.pushStyle();
    if(grabsInput())
      pg.fill(250, 250, 60);
    else
      pg.fill(100, 100, 255);
    pg.ellipse(0,0,2*radius,2*radius);
    pg.textFont(loadFont("FreeSans-36.vlw"), 12);
    pg.strokeWeight(1);
    pg.fill(0, 0, 20);
    pg.text("" + nodeId, -radius, radius, 0);
    pg.popStyle();
  }
  
  public void play(ClickEvent event) {
    if(InteractiveData.getInstance().getMode() == 2) {
      if(InteractiveData.getInstance().getLastPicked() == null || InteractiveData.getInstance().getLastPicked().compareTo(this) == 0) {
        InteractiveData.getInstance().setLastPicked(this);
      } else {
        Edge edge = new NonWeightedEdge(InteractiveData.getInstance().getEdgeCounter(), InteractiveData.getInstance().getLastPicked(), this, true, scene);
        InteractiveData.getInstance().setEdgeCounter();
        graph.addEdge(edge);
        InteractiveData.getInstance().reset();
      }
    }
  }
  
  @Override
  public int compareTo(Node otherNode) {
    return nodeId - otherNode.nodeId;
  }
}