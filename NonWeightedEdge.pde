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
  
  float dist(float x1, float y1, float x2, float y2) {
    return sqrt( (x1-x2)*(x1-x2) + (y1-y2)*(y1-y2) ); 
  }
  
  Point getPointAlong(float xFrom, float yFrom, float xTo, float yTo) {
    float dist = this.dist( xFrom, yFrom, xTo, yTo );
    float d2 = dist - InteractiveData.RADIUS_NODE;
    float xc = xFrom - ( (d2)*(xFrom - xTo) ) / dist;
    float yc = yFrom - ( (d2)*(yFrom - yTo) ) / dist;
    return new Point(xc, yc);
  }
  
  
  void display(PGraphics pg) {
    if(deleted) return;
    
    
    pg.pushStyle();
    pg.strokeWeight(3);
    pg.stroke(255);
    Point a = getPointAlong(from.position().x(), from.position().y(), to.position().x(), to.position().y());
    Point b = getPointAlong(to.position().x(), to.position().y(), from.position().x(), from.position().y());
    pg.line(b.x(), b.y(), a.x(), a.y());
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