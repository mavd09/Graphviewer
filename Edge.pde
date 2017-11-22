public interface Edge extends InteractiveElement { 
  public Node getFrom();
  public Node getTo();
  public void setFrom(Node from);
  public void setTo(Node to);
  public int getEdgeId();
  public boolean getDirected();
  public void setDeleted(boolean deleted);
}