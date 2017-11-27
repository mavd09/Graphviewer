public class Dijkstra extends InteractiveFrame implements Solver {
  
  Graph graph;
  EventManager eventManager;
  
  int currentLine;
  
  String[] pseudocode = { 
    "choose some starting vertex x",
    "add x to Priority Queue PQ",
    "mark x",
    "while PQ nonempty",
    "  choose vertex u from PQ and remove it",
    "  if current distance is worst continue",
    "  for each edge in adjacency list of u",
    "    if min_dist u + weight is less than min_dist v",
    "       mark v",
    "       add v to Priority Queue PQ"
  };
  
  public Dijkstra( Scene scene, Graph graph, EventManager eventManager ) {
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
    pg.background(200);
    pg.strokeWeight(1);
    pg.stroke(082E00);
    int side = 16;
    pg.textSize(12);
    for(int i = 0; i < pseudocode.length; i++) {
      if( i == currentLine ) pg.fill(Utility.ON_MOUSE_COLOR);
      else pg.fill(255);
      pg.rect(-200, i*side-60-side+2, 400, side);
      pg.fill(0);
      pg.text(pseudocode[i],-195,i*side-60);
    }
    pg.popStyle();
  }
  
  public void solve( Node source ) {
    TreeMap<Node,Integer> minDistance = new TreeMap<Node, Integer>();
    Heap<State> q = new Heap<State>();
    minDistance.put(source, 0);
    q.put(new State(minDistance.get(source),source));
    source.minDistance = 0;
    eventManager.addEvent(new Event(0,EventType.CODE));
    eventManager.addEvent(new Event(source, EventType.QUEUED));
    eventManager.addEvent(new Event(1,EventType.CODE));
    eventManager.addEvent(new Event(minDistance.get(source),source,EventType.ADD_STATE));
    eventManager.addEvent(new Event(2,EventType.CODE));
    while(q.size() > 0) {
      eventManager.addEvent(new Event(3,EventType.CODE));
      int distance = q.getTop().cost;
      Node current = q.getTop().node;
      q.remove();
      eventManager.addEvent(new Event(4,EventType.CODE));
      eventManager.addEvent(new Event(current,EventType.PROCESSING));
      eventManager.addEvent(new Event(current,EventType.REMOVE_NODE));
      eventManager.addEvent(new Event(5,EventType.CODE));
      if( distance == minDistance.get(current) ) {
        eventManager.addEvent(new Event(current,EventType.SHOW_RESULT));
        for(Integer edgeId : graph.adjacencyList.get(current)) {
          eventManager.addEvent(new Event(6,EventType.CODE));
          eventManager.addEvent(new Event(graph.edges.get(edgeId), EventType.PROCESSING));
          Edge edge = graph.edges.get(edgeId);
          Node neighbor = edge.getFrom();
          if(neighbor.compareTo(current) == 0) {
            neighbor = edge.getTo();
          }
          eventManager.addEvent(new Event(7,EventType.CODE));
          if(minDistance.containsKey(neighbor) == false || minDistance.get(current)+edge.getWeight() < minDistance.get(neighbor) ) {
            minDistance.put(neighbor, minDistance.get(current)+edge.getWeight() );
            q.put(new State(minDistance.get(neighbor), neighbor));
            neighbor.minDistance = minDistance.get(neighbor);
            eventManager.addEvent(new Event(8,EventType.CODE));
            eventManager.addEvent(new Event(neighbor, EventType.QUEUED));
            eventManager.addEvent(new Event(9,EventType.CODE));
            eventManager.addEvent(new Event(minDistance.get(neighbor),neighbor,EventType.ADD_STATE));
          }
          eventManager.addEvent(new Event(graph.edges.get(edgeId), EventType.DEFAULT_EDGE));
        }
      }
      eventManager.addEvent(new Event(current,EventType.VISITED));
    }
    eventManager.addEvent(new Event(3,EventType.CODE));
    eventManager.addEvent(new Event(-1,EventType.CODE));
  }
  
}