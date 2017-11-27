public static enum EventType {
  DEFAULT_EDGE,
  CODE,
  PROCESSING,
  VISITED,
  ADD_NODE,
  ADD_STATE,
  REMOVE_NODE,
  SHOW_RESULT,
  QUEUED
}

public class Event {
  private InteractiveElement element;
  private EventType eventType;
  private int lineOfCode, distance;
  Event(InteractiveElement element, EventType eventType) {
    this.element = element;
    this.eventType = eventType;
    lineOfCode = -1;
  }
  Event(int distance, InteractiveElement element, EventType eventType) {
    this.distance = distance;
    this.element = element;
    this.eventType = eventType;
    lineOfCode = -1;
  }
  Event(int lineOfCode, EventType eventType) {
    element = null;
    this.eventType = eventType;
    this.lineOfCode = lineOfCode;
  }
  InteractiveElement getElement() {
    return element;
  }
  EventType getEventType() {
    return eventType;
  }
  int getDistance() {
    return distance;
  }
}

public class EventManager {
  private boolean pause;
  private LinkedList<Event> queueEvent;
  private DataStructureInteractive dataStructureInteractive;
  private Solver solver;
  private ResultInteractive resultInteractive;
  int time;
  EventManager(ResultInteractive resultInteractive) {
    this.resultInteractive = resultInteractive; 
    reset();
  }
  public void reset() {
    pause = false;
    resultInteractive.reset();
    queueEvent = new LinkedList<Event>();
    time = Utility.TIME_BETWEEN_EVENTS;
  }
  public void addEvent(Event event) {
    queueEvent.add(event);
  }
  public void setDataStructure(DataStructureInteractive newDataStructureInteractive) {
    dataStructureInteractive = newDataStructureInteractive;
  }
  public void setSolver( Solver solver ) {
    this.solver = solver;
  }
  public void setPause( ) {
    pause = !pause;
  }
  public void processEvent() {
    if( queueEvent.size() == 0 || pause == true ) {
      return ;
    }
    if( time > 0 ) {
      time--;
      return ;
    }
    time = Utility.TIME_BETWEEN_EVENTS;
    Event event = queueEvent.poll();
    switch(event.getEventType()) {
      case DEFAULT_EDGE: {
        event.getElement().setColor(Utility.DEFAULT_EDGE_COLOR); 
        break;
      }
      case PROCESSING: {
        event.getElement().setColor(Utility.PROCESSING_COLOR);
        break;
      }
      case VISITED: {
        event.getElement().setColor(Utility.VISITED_COLOR);
        
        break; 
      }
      case REMOVE_NODE: {
        dataStructureInteractive.remove();
        break;
      }
      case ADD_NODE: {
        dataStructureInteractive.add((Node)event.getElement());
        break;
      }
      case ADD_STATE: {
        dataStructureInteractive.add(new State(event.getDistance(),(Node)event.getElement()));
        break;
      }
      case QUEUED: {
        event.getElement().setColor(Utility.QUEUED_COLOR);
        break; 
      }
      case CODE: {
        solver.setCurrentLine(event.lineOfCode);
        break;
      }
      case SHOW_RESULT: {
        resultInteractive.addResult((Node)event.getElement());
        break;
      }
      default: {
        break;
      }
    }
  }
}