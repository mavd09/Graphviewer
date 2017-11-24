public static enum EventType {
  DEFAULT_EDGE,
  PROCESSING,
  VISITED,
  ADD_NODE,
  REMOVE_NODE,
  QUEUED
}

public class Event {
  private InteractiveElement element;
  private EventType eventType;
  Event(InteractiveElement element, EventType eventType) {
    this.element = element;
    this.eventType = eventType;
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
      default: {
        break;
      }
    }
  }
}