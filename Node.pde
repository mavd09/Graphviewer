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
    pg.text("" + nodeId, -Utility.RADIUS_NODE/2-6, Utility.RADIUS_NODE/2+6, 0);
    pg.popStyle();
  }
  
  public void play(ClickEvent event) {
    if(InteractiveData.getInstance().getMode() == Mode.INSERT_EDGE && InteractiveData.getInstance().getLastPicked() != null && InteractiveData.getInstance().getLastPicked().compareTo(this) != 0 ) {
      Edge edge = null;
      if( graph.getWeightedEdges() ) {
        int weight = Utility.random.nextInt(10);
        edge = new WeightedEdge(InteractiveData.getInstance().getEdgeCounter(), InteractiveData.getInstance().getLastPicked(), this, weight, graph.getDirectedEdges(), scene);
      } else {
        edge = new NonWeightedEdge(InteractiveData.getInstance().getEdgeCounter(), InteractiveData.getInstance().getLastPicked(), this, graph.getDirectedEdges(), scene);
      }
      InteractiveData.getInstance().setEdgeCounter();
      graph.addEdge(edge);
      InteractiveData.getInstance().reset();
      InteractiveData.getInstance().setLastPicked(null);
      return ;
    }
    InteractiveData.getInstance().setLastPicked(this);
  }
  
  public void setColor(color newColor) {
    nodeColor = newColor;
  }
  
  @Override
  public int compareTo(Node otherNode) {
    return nodeId - otherNode.nodeId;
  }
}