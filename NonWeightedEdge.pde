public class NonWeightedEdge extends InteractiveFrame implements Edge, Comparable<NonWeightedEdge> {
  Node from, to;
  int edgeId;
  boolean directed, deleted;
  color edgeColor;
  NonWeightedEdge(int edgeId, Node from, Node to, boolean directed, Scene scene) {
    super(scene);
    this.from = from;
    this.to = to;
    this.edgeId = edgeId;
    this.directed = directed;
    edgeColor = Utility.DEFAULT_EDGE_COLOR;
    setShape("display");
    deleted = false;
  }
  
  void display(PGraphics pg) {
    if(deleted) return;
    pg.pushStyle();
    pg.strokeWeight(3);
    pg.stroke(edgeColor);
    Point a = Utility.getPointAlong(to.position().x(), to.position().y(), from.position().x(), from.position().y());
    Point b = Utility.getPointAlong(from.position().x(), from.position().y(), to.position().x(), to.position().y());
    pg.line(a.x(), a.y(), b.x(), b.y());
    if(directed) {
      pg.strokeWeight(0);
      pg.fill(Utility.DEFAULT_ARROW_COLOR);
      pg.ellipse(b.x(),b.y(),2.0*Utility.RADIUS_ARROW,2.0*Utility.RADIUS_ARROW);
    }
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
  public void setColor(color newColor) {
    edgeColor = newColor;
  }
  
  @Override
  public int compareTo(NonWeightedEdge otherEdge) {
    return edgeId - otherEdge.edgeId;
  }
    
}