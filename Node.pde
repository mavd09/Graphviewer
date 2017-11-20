public class Node extends InteractiveFrame implements Comparable<Node> {
  int nodeId;
  float radius;
  Node(int nodeId, float radius, Scene scene) {
     super(scene);
     this.nodeId = nodeId;
     this.radius = radius;
     setShape("display");
  }
  
  void display(PGraphics pg) {
    pg.pushStyle();
    if(grabsInput())
      pg.fill(250, 250, 60);
    else
      pg.fill(100, 100, 255);
    pg.ellipse(0,0,2*radius,2*radius);
    pg.popStyle();
  }
  
  @Override
  public int compareTo(Node otherNode) {
    return nodeId - otherNode.nodeId;
  }
}