import remixlab.proscene.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;
import remixlab.bias.event.*;

final int WIDTH = 1920, HEIGHT = 1000;
final int WIDTH_DATA_STRUCTURE = WIDTH, HEIGHT_DATA_STRUCTURE = 100;
final int POSITION_DATA_STRUCTURE_X = WIDTH - WIDTH_DATA_STRUCTURE, POSITION_DATA_STRUCTURE_Y = HEIGHT - HEIGHT_DATA_STRUCTURE;

GenericFrame[] gfs;

Scene mainScene, dataStructureScene;
PGraphics mainCanvas, dataStructureCanvas;
Graph graph;
EventManager eventManager;
Solver solver;

void settings() {
  size(WIDTH, HEIGHT, P3D);
}

void setup() {
  mainCanvas = createGraphics(WIDTH, HEIGHT-100, P2D);
  mainScene = new Scene(this, mainCanvas);
  
  gfs = new GenericFrame[] {
    new GenericFrame(mainScene, new Vec(0, 0, 200) ),
    new GenericFrame(mainScene, new Vec(5000, 5000, 200) ),
    new GenericFrame(mainScene, new Vec(-25, 20, 200) ),
    new GenericFrame(mainScene, new Vec(-25, 75, 200) )
  };
  
  mainScene.disableKeyboardAgent();
  mainScene.eye().interpolateTo(gfs[0], 1.0 );
  
  dataStructureCanvas = createGraphics(WIDTH_DATA_STRUCTURE, HEIGHT_DATA_STRUCTURE, P2D);
  dataStructureScene = new Scene(this, dataStructureCanvas, POSITION_DATA_STRUCTURE_X, POSITION_DATA_STRUCTURE_Y);
  
  graph = new Graph();
  
  eventManager = new EventManager();
  
  mainScene.setAxesVisualHint(false); // hide axis
  mainScene.setGridVisualHint(false); // hide grid
  
  dataStructureScene.setAxesVisualHint(false); // hide axis
  dataStructureScene.setGridVisualHint(false); // hide grid
  
  dataStructureScene.eye().lookAt(new Vec(0,0));
  rectMode(CENTER);
  dataStructureScene.eye().interpolateToZoomOnRegion(new Rect(800,55,20,10));
  
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
  
  mainCanvas.pushStyle();
  mainCanvas.stroke(0,255,0);
  mainCanvas.strokeWeight(5);
  mainCanvas.noFill();
  mainCanvas.rectMode(CENTER);
  mainCanvas.textSize(100);
  
  mainCanvas.text("Breadth First Search", 0-500, 0-300);
  mainCanvas.rect(0,0,1800, 800);
  
  mainCanvas.text("Depth First Search", 5000-450, 5000-300);
  mainCanvas.rect(5000,5000,1800,800);
  
  mainCanvas.popStyle();
  mainScene.drawFrames();
  
  mainScene.endDraw();
  mainScene.display();
  
  dataStructureScene.beginDraw();
  dataStructureCanvas.background(255);
  dataStructureScene.pg().fill(255, 0, 255, 125);
  dataStructureScene.drawFrames();
  dataStructureScene.endDraw();
  dataStructureScene.display();
  
  dataStructureScene.setBoundingRect(new Vec(0, 20), new Vec(20, 0));
  dataStructureScene.showAll();
  
  eventManager.processEvent();
}

void mouseClicked() {
  if(InteractiveData.getInstance().getMode() == Mode.INSERT_NODE) {
    Node node = new Node(InteractiveData.getInstance().getNodeCounter(), graph, mainScene);
    graph.addNode(node);
    Vec p = mainScene.eye().unprojectedCoordinatesOf(new Vec(mouseX, mouseY));
    node.setPosition(p);
    InteractiveData.getInstance().setNodeCounter();
    InteractiveData.getInstance().reset();
  }
}

void keyPressed() {
  if( key == '1' ) {
    mainScene.eye().interpolateTo(gfs[0], 1.0 );
  } else if( key == '2' ) {
    mainScene.eye().interpolateTo( gfs[1], 1.0 );
  } else if( key == '3' ) {
    mainScene.eye().fitScreenRegion(new Rect(2500,2500,5000,5000));
    mainScene.eye().interpolateToFitScene();
  } else if(key == 'n') {
    InteractiveData.getInstance().setMode(Mode.INSERT_NODE);
  } else if(key == 'e') {
    InteractiveData.getInstance().setMode(Mode.INSERT_EDGE);
  } else if(key == 'b') {
    if( InteractiveData.getInstance().getLastPicked() != null ) {
      eventManager.setDataStructure(new QueueInteractive(dataStructureScene));
      solver = new BreadthFirstSearch( graph, InteractiveData.getInstance().getLastPicked(), eventManager );
      solver.solve();
    }
  } else if(key == 'd') {
    if( InteractiveData.getInstance().getLastPicked() != null ) {
      eventManager.setDataStructure(new StackInteractive(dataStructureScene));
      solver = new DepthFirstSearch( graph, InteractiveData.getInstance().getLastPicked(), eventManager );
      solver.solve();
    }
  }else {
    InteractiveData.getInstance().setMode(Mode.EMPTY);
  }
}