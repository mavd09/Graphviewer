public interface Edge { 
  public Node getFrom();
  public Node getTo();
  public void setFrom(Node from);
  public void setTo(Node to);
  public void removeEdge(Graph graph);
  public void addEdge(Graph graph);
}