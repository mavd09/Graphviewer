public class DepthFirstSearch implements Solver {
  
  Graph graph;
  Node source;
  EventManager eventManager;
  
  int currentLine;
  
  String[] pseudocode = { 
    "choose some starting vertex x",
    "add x to queue Q",
    "mark x",
    "while Q nonempty",
    "  choose vertex u from Q and remove it",
    "  for each edge in adjacency list of u",
    "    if v is unmarked",
    "       mark v",
    "       add v to queue Q"
  };
  
  public DepthFirstSearch( Graph graph, Node source, EventManager eventManager ) {
    this.graph = graph;
    this.source = source;
    this.eventManager = eventManager;
    currentLine = -1;
  }
  
  public void setCurrentLine( int x ) {
    currentLine = x;
  }
  
  void display(PGraphics pg) {
    pg.pushStyle();
    pg.strokeWeight(1);
    pg.stroke(082E00);
    int side = 16;
    pg.textSize(12);
    for(int i = 0; i < pseudocode.length; i++) {
      if( i == currentLine ) pg.fill(Utility.ON_MOUSE_COLOR);
      else pg.fill(255);
      pg.rect(-200, i*side-50-side+2, 400, side);
      pg.fill(0);
      pg.text(pseudocode[i],-195,i*side-50);
    }
    pg.popStyle();
  }
  
  public void solve( ) {
    TreeSet<Node> seen = new TreeSet<Node>();
    LinkedList<Node> q = new LinkedList<Node>();
    eventManager.addEvent(new Event(source, EventType.QUEUED));
    eventManager.addEvent(new Event(source,EventType.ADD_NODE));
    q.addLast(source);
    seen.add(source);
    source.minDistance = 0;
    while(q.size() > 0) {
      Node current = q.pollLast();
      eventManager.addEvent(new Event(current,EventType.PROCESSING));
      eventManager.addEvent(new Event(current,EventType.REMOVE_NODE));
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
          q.addLast(neighbor);
          seen.add(neighbor);
          neighbor.minDistance = current.minDistance+1;
        }
        eventManager.addEvent(new Event(graph.edges.get(edgeId), EventType.DEFAULT_EDGE));
      }
      eventManager.addEvent(new Event(current,EventType.VISITED));
    }
  }
  
}