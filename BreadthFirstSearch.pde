public class BreadthFirstSearch implements Solver {
  
  Graph graph;
  Node source;
  EventManager eventManager;
  
  public BreadthFirstSearch( Graph graph, Node source, EventManager eventManager ) {
    this.graph = graph;
    this.source = source;
    this.eventManager = eventManager;
  }
  
  public void solve( ) {
    TreeSet<Node> seen = new TreeSet<Node>();
    LinkedList<Node> q = new LinkedList<Node>();
    eventManager.addEvent(new Event(source, EventType.QUEUED));
    eventManager.addEvent(new Event(source,EventType.ADD_NODE));
    q.add(source);
    seen.add(source);
    source.minDistance = 0;
    while(q.size() > 0) {
      Node current = q.poll();
      eventManager.addEvent(new Event(current, EventType.PROCESSING));
      for(Integer edgeId : graph.adjacencyList.get(current)) {
        eventManager.addEvent(new Event(graph.edges.get(edgeId), EventType.PROCESSING));
        Edge edge = graph.edges.get(edgeId);
        Node neighbor = edge.getFrom();
        if(neighbor.compareTo(current) == 0) {
          neighbor = edge.getTo();
        }
        if(seen.contains(neighbor) == false) {
          eventManager.addEvent(new Event(neighbor, EventType.QUEUED));
          eventManager.addEvent(new Event(neighbor,EventType.ADD_NODE));
          q.add(neighbor);
          seen.add(neighbor);
          neighbor.minDistance = current.minDistance+1;
        }
        eventManager.addEvent(new Event(graph.edges.get(edgeId), EventType.DEFAULT_EDGE));
      }
      eventManager.addEvent(new Event(current,EventType.VISITED));
      eventManager.addEvent(new Event(current,EventType.REMOVE_NODE));
    }
  }
  
}