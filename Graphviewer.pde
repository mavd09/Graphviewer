import remixlab.proscene.*;
import remixlab.dandelion.geom.*;
import remixlab.bias.event.*;

Scene mainScene, queueScene;
PGraphics mainCanvas, queueCanvas;
Graph graph;
EventManager eventManager;

final int WIDTH = 1200, HEIGHT = 600;
final int WIDTH_QUEUE = WIDTH, HEIGHT_QUEUE = 100;
final int queueX = WIDTH - WIDTH_QUEUE, queueY = HEIGHT - HEIGHT_QUEUE;

void settings() {
  size(WIDTH, HEIGHT, P3D);
}

void setup() {
  mainCanvas = createGraphics(WIDTH, HEIGHT, P2D);
  mainScene = new Scene(this, mainCanvas);
  
  queueCanvas = createGraphics(WIDTH_QUEUE, HEIGHT_QUEUE, P2D);
  queueScene = new Scene(this, queueCanvas, queueX, queueY);
  
  graph = new Graph();
  
  eventManager = new EventManager(queueScene);
  
  mainScene.setAxesVisualHint(false); // hide axis
  mainScene.setGridVisualHint(false); // hide grid
  
  queueScene.setAxesVisualHint(false); // hide axis
  queueScene.setGridVisualHint(false); // hide grid
  
  queueScene.eye().lookAt(new Vec(0,0));
  rectMode(CENTER);
  queueScene.eye().interpolateToZoomOnRegion(new Rect(800,55,20,10));
  
  /*Node node1 = new Node(1,10, graph, mainScene);
  Node node2 = new Node(2,10, graph, mainScene);
  node2.setPosition(40, 40, 0);
  
  graph.addNode(node1);
  graph.addNode(node2);
  Edge edge = new NonWeightedEdge(1, node1, node2, true, mainScene);
  graph.addEdge(edge);*/
  
}

void draw() {
  mainScene.beginDraw();
  mainCanvas.background(0);
  mainScene.drawFrames();
  mainScene.endDraw();
  mainScene.display();
  
  queueScene.beginDraw();
  queueCanvas.background(255);
  queueScene.pg().fill(255, 0, 255, 125);
  queueScene.drawFrames();
  queueScene.endDraw();
  queueScene.display();
  
  eventManager.processEvent();
}

void mouseClicked() {
  if(InteractiveData.getInstance().getMode() == Mode.INSERT_NODE) {
    Node node = new Node(InteractiveData.getInstance().getNodeCounter(), graph, mainScene);
    graph.addNode(node);
    InteractiveData.getInstance().setNodeCounter();
    InteractiveData.getInstance().reset();
  }
}

void keyPressed() {
  if(key == 'n') {
    InteractiveData.getInstance().setMode(Mode.INSERT_NODE);
  } else if(key == 'e') {
    InteractiveData.getInstance().setMode(Mode.INSERT_EDGE);
  } else {
    InteractiveData.getInstance().setMode(Mode.EMPTY);
  }
  if(key == 'b') {
    graph.bfs(InteractiveData.getInstance().getLastPicked(), eventManager);
  }
  
}