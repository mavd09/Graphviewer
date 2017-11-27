import java.util.*;

public class Graph {
  TreeMap<Node, TreeSet<Integer>> adjacencyList;
  TreeMap<Integer, Edge> edges;
  
  Graph() {
    adjacencyList = new TreeMap<Node, TreeSet<Integer>>();
    edges = new TreeMap<Integer, Edge>();
  }
  
  public void reset() {
    for( Map.Entry<Node, TreeSet<Integer>> entry : adjacencyList.entrySet() ) {
      entry.getKey().setColor(Utility.DEFAULT_NODE_COLOR);
    }
  }
  
  public void removeEdge(Integer edgeId) {
    Edge edge = edges.remove(edgeId); 
    adjacencyList.get(edge.getFrom()).remove(edge.getEdgeId());
    if(edge.getDirected() == false) {
      adjacencyList.get(edge.getTo()).remove(edge.getEdgeId());  
    }
    edge.setDeleted(true);
  }
  
  public void addEdge(Edge edge) {
    adjacencyList.get(edge.getFrom()).add(edge.getEdgeId());
    if(edge.getDirected() == false) {
      adjacencyList.get(edge.getTo()).add(edge.getEdgeId());  
    }
    edges.put(edge.getEdgeId(), edge);
  }
  
  public void removeNode(Node node) {
    adjacencyList.remove(node); 
  }
  
  public void addNode(Node node) {
    adjacencyList.put(node, new TreeSet<Integer>()); 
  }
  
}