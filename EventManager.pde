public static enum EventType {
  DEFAULT_EDGE,
  CODE,
  PROCESSING,
  VISITED,
  ADD_NODE,
  REMOVE_NODE,
  QUEUED
}

public class Event {
  private InteractiveElement element;
  private EventType eventType;
  private int lineOfCode;
  Event(InteractiveElement element, EventType eventType) {
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
}

public class EventManager {
  private LinkedList<Event> queueEvent;
  private DataStructureInteractive dataStructureInteractive;
  private Solver solver;
  int time;
  EventManager() {
    reset();
  }
  public void reset() {
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
  public void processEvent() {
    if( queueEvent.size() == 0 ) {
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
        dataStructureInteractive.removeNode();
        break;
      }
      case ADD_NODE: {
        dataStructureInteractive.addNode((Node)event.getElement());
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
      default: {
        break;
      }
    }
  }
}