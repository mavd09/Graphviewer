public class NonDirectedNonWeightedEdge extends InteractiveFrame implements Edge, Comparable<NonDirectedNonWeightedEdge> {
  Node from, to;
  int edgeId;
  private Scene scene;

  NonDirectedNonWeightedEdge(int edgeId, Node from, Node to, Scene scene) {
    super(scene);
    this.scene = scene;
    this.from = from;
    this.to = to;
    this.edgeId = edgeId;
  }

  public Node getFrom() {
    return from;
  }
  public Node getTo() {
    return to;
  }
  public void setFrom(Node from) {
    this.from = from;
  }
  public void setTo(Node to) {
    this.to = to;
  }

  public void removeEdge(Graph graph) {
    graph.removeEdge(new NonDirectedNonWeightedEdge(edgeId, from, to, scene) );
    graph.removeEdge(new NonDirectedNonWeightedEdge(edgeId, to, from, scene) );
  }
  public void addEdge(Graph graph) {
    graph.addEdge(new NonDirectedNonWeightedEdge(edgeId, from, to, scene) );
    graph.addEdge(new NonDirectedNonWeightedEdge(edgeId, to, from, scene) );
  }
  
  @Override
  public int compareTo(NonDirectedNonWeightedEdge otherEdge) {
    return edgeId - otherEdge.edgeId;
  }
    
}