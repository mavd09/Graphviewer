import java.util.*;

public class Graph {
  TreeMap<Node, TreeSet<Edge>> graph;
  
  Graph() {
    graph = new TreeMap<Node, TreeSet<Edge>>();
  }
  
  public void removeEdge(Edge edge) {
    graph.get(edge.getFrom()).remove(edge);
  }
  
  public void addEdge(Edge edge) {
    graph.get(edge.getFrom()).add(edge);
  }
  
  public void removeNode(Node node) {
    graph.remove(node); 
  }
  
  public void addNode(Node node) {
    graph.put(node, new TreeSet<Edge>()); 
  }
  
}