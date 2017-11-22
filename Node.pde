public class Node extends InteractiveFrame implements InteractiveElement, Comparable<Node> {
  int nodeId, minDistance;
  Graph graph;
  Scene scene;
  color nodeColor;
  Node(int nodeId, Graph graph, Scene scene) {
     super(scene);
     this.nodeId = nodeId;
     this.graph = graph;
     this.scene = scene;
     minDistance = -1;
     nodeColor = Utility.DEFAULT_NODE_COLOR;
     setShape("display");
     setClickBinding(LEFT, 1, "play");
  }
  
  void display(PGraphics pg) {
    pg.pushStyle();
    if(grabsInput()) {
      pg.fill(Utility.ON_MOUSE_COLOR);
    } else {
      pg.fill(nodeColor);
    }
    pg.ellipse(0,0,2.0*Utility.RADIUS_NODE,2.0*Utility.RADIUS_NODE);
    pg.strokeWeight(1);
    pg.fill(0, 0, 20);
    pg.text("" + nodeId, -Utility.RADIUS_NODE/2+1, Utility.RADIUS_NODE/2-1, 0);
    pg.popStyle();
  }
  
  public void play(ClickEvent event) {
    if(InteractiveData.getInstance().getMode() == Mode.INSERT_EDGE) {
      if(InteractiveData.getInstance().getLastPicked() == null || InteractiveData.getInstance().getLastPicked().compareTo(this) == 0) {
        InteractiveData.getInstance().setLastPicked(this);
      } else {
        Edge edge = new NonWeightedEdge(InteractiveData.getInstance().getEdgeCounter(), InteractiveData.getInstance().getLastPicked(), this, false, scene);
        InteractiveData.getInstance().setEdgeCounter();
        graph.addEdge(edge);
        InteractiveData.getInstance().reset();
      }
    }
  }
  
  public void setColor(color newColor) {
    nodeColor = newColor;
  }
  
  @Override
  public int compareTo(Node otherNode) {
    return nodeId - otherNode.nodeId;
  }
}