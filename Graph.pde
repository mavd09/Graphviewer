import java.util.*;

public class Graph {
  TreeMap<Node, TreeSet<Integer>> graph;
  TreeMap<Integer, Edge> edges;
  
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
  
  public void bfs(Node source, EventManager eventManager) {
    if(source == null) {  
      return;
    }
    TreeSet<Node> seen = new TreeSet<Node>();
    LinkedList<Node> q = new LinkedList<Node>();
    eventManager.addEvent(new Event(source, EventType.QUEUED));
    q.add(source);
    seen.add(source);
    source.minDistance = 0;
    while(q.size() > 0) {
      Node current = q.poll();
      eventManager.addEvent(new Event(current, EventType.PROCESSING));
      for(Integer edgeId : graph.get(current)) {
        eventManager.addEvent(new Event(edges.get(edgeId), EventType.PROCESSING));
        Edge edge = edges.get(edgeId);
        Node neighbor = edge.getFrom();
        if(neighbor.compareTo(current) == 0) {
          neighbor = edge.getTo();
        }
        if(seen.contains(neighbor) == false) {
          eventManager.addEvent(new Event(neighbor, EventType.QUEUED));
          q.add(neighbor);
          seen.add(neighbor);
          neighbor.minDistance = current.minDistance+1;
        }
        eventManager.addEvent(new Event(edges.get(edgeId), EventType.DEFAULT_EDGE));
      }
      eventManager.addEvent(new Event(current,EventType.VISITED));
    }
  }
  
  
}