public class NonWeightedEdge extends InteractiveFrame implements Edge, Comparable<NonWeightedEdge> {
  Node from, to;
  int edgeId;
  boolean directed, deleted;
  NonWeightedEdge(int edgeId, Node from, Node to, boolean directed, Scene scene) {
    super(scene);
    this.from = from;
    this.to = to;
    this.edgeId = edgeId;
    this.directed = directed;
    setShape("display");
    deleted = false;
  }
  
  void display(PGraphics pg) {
    if(deleted) return;
    System.out.println("drawing");
    pg.pushStyle();
    strokeWeight(3);
    stroke(255);
    line(from.position().x(), from.position().y(), to.position().x(), to.position().y());
    pg.popStyle();
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
  public void setDeleted(boolean deleted) {
    this.deleted = deleted;
  }
  public int getEdgeId() {
    return edgeId;
  }
  
  public boolean getDirected() {
    return directed; 
  }
  
  @Override
  public int compareTo(NonWeightedEdge otherEdge) {
    return edgeId - otherEdge.edgeId;
  }
    
}