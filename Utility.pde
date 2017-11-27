public static class Utility {
  
  public static final float RADIUS_NODE = 50;
  public static final float RADIUS_ARROW = 10;
  
  public static final int TIME_BETWEEN_EVENTS = 10;
  
  public static final color DEFAULT_NODE_COLOR = #148AF0;
  public static final color DEFAULT_EDGE_COLOR = #FFFFFF;
  public static final color DEFAULT_ARROW_COLOR = #FF8000;
  public static final color PROCESSING_COLOR = #DE15C3;
  public static final color QUEUED_COLOR = #13F06B;
  public static final color VISITED_COLOR = #F0134E;
  public static final color ON_MOUSE_COLOR = #E9F013;
  
  public static float dist(float x1, float y1, float x2, float y2) {
    return sqrt( (x1-x2)*(x1-x2) + (y1-y2)*(y1-y2) ); 
  }
  
  public static Point getPointAlong(float xFrom, float yFrom, float xTo, float yTo) {
    float dist = Utility.dist( xFrom, yFrom, xTo, yTo );
    float d2 = dist - Utility.RADIUS_NODE;
    float xc = xFrom - ( (d2)*(xFrom - xTo) ) / dist;
    float yc = yFrom - ( (d2)*(yFrom - yTo) ) / dist;
    return new Point(xc, yc);
  }
  
}