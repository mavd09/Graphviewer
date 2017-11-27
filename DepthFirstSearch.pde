public class DepthFirstSearch extends InteractiveFrame implements Solver {
  
  Graph graph;
  EventManager eventManager;
  
  int currentLine;
  
  String[] pseudocode = { 
    "choose some starting vertex x",
    "add x to stack S",
    "mark x",
    "while S nonempty",
    "  choose vertex u from S and remove it",
    "  for each edge in adjacency list of u",
    "    if v is unmarked",
    "       mark v",
    "       add v to stack S"
  };
  
  public DepthFirstSearch( Scene scene, Graph graph, Node source, EventManager eventManager ) {
    super(scene);
    this.graph = graph;
    this.eventManager = eventManager;
    currentLine = -1;
    setShape("display");
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
  
  public void solve( Node source ) {
    TreeSet<Node> seen = new TreeSet<Node>();
    LinkedList<Node> q = new LinkedList<Node>();
    eventManager.addEvent(new Event(0,EventType.CODE));
    eventManager.addEvent(new Event(source, EventType.QUEUED));
    eventManager.addEvent(new Event(1,EventType.CODE));
    eventManager.addEvent(new Event(source,EventType.ADD_NODE));
    eventManager.addEvent(new Event(2,EventType.CODE));
    q.addLast(source);
    seen.add(source);
    source.minDistance = 0;
    eventManager.addEvent(new Event(source,EventType.SHOW_RESULT));
    while(q.size() > 0) {
      eventManager.addEvent(new Event(3,EventType.CODE));
      Node current = q.pollLast();
      eventManager.addEvent(new Event(4,EventType.CODE));
      eventManager.addEvent(new Event(current,EventType.PROCESSING));
      eventManager.addEvent(new Event(current,EventType.REMOVE_NODE));
      for(Integer edgeId : graph.adjacencyList.get(current)) {
        eventManager.addEvent(new Event(5,EventType.CODE));
        eventManager.addEvent(new Event(graph.edges.get(edgeId), EventType.PROCESSING));
        Edge edge = graph.edges.get(edgeId);
        Node neighbor = edge.getFrom();
        if(neighbor.compareTo(current) == 0) {
          neighbor = edge.getTo();
        }
        eventManager.addEvent(new Event(6,EventType.CODE));
        if(seen.contains(neighbor) == false) {
          eventManager.addEvent(new Event(7,EventType.CODE));
          eventManager.addEvent(new Event(neighbor, EventType.QUEUED));
          eventManager.addEvent(new Event(8,EventType.CODE));
          eventManager.addEvent(new Event(neighbor,EventType.ADD_NODE));
          q.addLast(neighbor);
          seen.add(neighbor);
          neighbor.minDistance = current.minDistance+1;
          eventManager.addEvent(new Event(neighbor,EventType.SHOW_RESULT));
        }
        eventManager.addEvent(new Event(graph.edges.get(edgeId), EventType.DEFAULT_EDGE));
      }
      eventManager.addEvent(new Event(current,EventType.VISITED));
    }
    eventManager.addEvent(new Event(3,EventType.CODE));
    eventManager.addEvent(new Event(-1,EventType.CODE));
  }
  
}