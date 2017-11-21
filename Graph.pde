import java.util.*;

public class Graph {
  TreeMap<Node, TreeSet<Integer>> graph;
  TreeMap<Integer, Edge> edges;
  Node lastPicked;
  
  Graph() {
    graph = new TreeMap<Node, TreeSet<Integer>>();
    edges = new TreeMap<Integer, Edge>();
  }
  
  public void removeEdge(Integer edgeId) {
    Edge edge = edges.remove(edgeId); 
    graph.get(edge.getFrom()).remove(edge.getEdgeId());
    if(edge.getDirected() == false) {
      graph.get(edge.getTo()).remove(edge.getEdgeId());  
    }
    edge.setDeleted(true);
  }
  
  public void addEdge(Edge edge) {
    graph.get(edge.getFrom()).add(edge.getEdgeId());
    if(edge.getDirected() == false) {
      graph.get(edge.getTo()).add(edge.getEdgeId());  
    }
    edges.put(edge.getEdgeId(), edge);
  }
  
  public void removeNode(Node node) {
    graph.remove(node); 
  }
  
  public void addNode(Node node) {
    graph.put(node, new TreeSet<Integer>()); 
  }
  
  
}