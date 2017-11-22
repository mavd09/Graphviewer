import java.util.*;

public class Graph {
  TreeMap<Node, TreeSet<Integer>> graph;
  TreeMap<Integer, Edge> edges;
  
  QueueInteractiveData queueInteractiveData;
  
  Graph(Scene scene) {
    graph = new TreeMap<Node, TreeSet<Integer>>();
    edges = new TreeMap<Integer, Edge>();
    queueInteractiveData = new QueueInteractiveData(scene);
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
  
  public void bfs(Node source) {
    if(source == null) {  
      return;
    }
    TreeSet<Node> seen = new TreeSet<Node>();
    LinkedList<Node> q = new LinkedList<Node>();
    q.add(source);
    seen.add(source);
    queueInteractiveData.addNode(source);
    while(q.size() > 0) {
      Node current = q.poll();
      System.out.println(current.nodeId);
      delay(2000);
      for(Integer edgeId : graph.get(current)) {
        Edge edge = edges.get(edgeId);
        Node neighbor = edge.getFrom();
        if(neighbor.compareTo(current) == 0) {
          neighbor = edge.getTo();
        }
        if(seen.contains(neighbor) == false) {
          q.add(neighbor);
          seen.add(neighbor);
          queueInteractiveData.addNode(neighbor);
        }
      }
    }
  }
  
  
}