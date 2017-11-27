import remixlab.proscene.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;
import remixlab.bias.event.*;

final int WIDTH = 1920, HEIGHT = 1000;

final int WIDTH_MAIN_CANVAS = 1920, HEIGHT_MAIN_CANVAS = 700;
final int WIDTH_RESULT_CANVAS = 1200, HEIGHT_RESULT_CANVAS = 150;
final int WIDTH_DATA_STRUCTURE_CANVAS = 1200, HEIGHT_DATA_STRUCTURE_CANVAS = 150;
final int WIDTH_PSEUDOCODE_CANVAS = 720, HEIGHT_PSEUDOCODE_CANVAS = 300;

Scene mainScene, dataStructureScene, resultScene, pseudocodeScene;
PGraphics mainCanvas, dataStructureCanvas, resultCanvas, pseudocodeCanvas;

GenericFrame[] genericFrames;

Graph graph;
EventManager eventManager;
Solver solver;

void settings() {
  size(WIDTH, HEIGHT, P2D);
}

void setup() {
  mainCanvas = createGraphics(WIDTH_MAIN_CANVAS, HEIGHT_MAIN_CANVAS, P2D);
  mainScene = new Scene(this, mainCanvas);
  
  dataStructureCanvas = createGraphics(WIDTH_DATA_STRUCTURE_CANVAS, HEIGHT_DATA_STRUCTURE_CANVAS, P2D);
  dataStructureScene = new Scene(this, dataStructureCanvas, 0, HEIGHT-HEIGHT_DATA_STRUCTURE_CANVAS);
  
  resultCanvas = createGraphics(WIDTH_RESULT_CANVAS, HEIGHT_RESULT_CANVAS, P2D);
  resultScene = new Scene(this, resultCanvas, 0, HEIGHT-HEIGHT_DATA_STRUCTURE_CANVAS-HEIGHT_RESULT_CANVAS);
  
  pseudocodeCanvas = createGraphics(WIDTH_PSEUDOCODE_CANVAS, HEIGHT_PSEUDOCODE_CANVAS, P2D);
  pseudocodeScene = new Scene(this, pseudocodeCanvas, WIDTH-WIDTH_PSEUDOCODE_CANVAS, HEIGHT-HEIGHT_PSEUDOCODE_CANVAS);
  
  genericFrames = new GenericFrame[] {
    new GenericFrame(mainScene, new Vec(0, 0) ),
    new GenericFrame(mainScene, new Vec(5000, 5000) ),
    new GenericFrame(mainScene, new Vec(0, 5000) )
  };
  
  mainScene.eye().interpolateTo(gfs[0], 1.0 );
  
  graph = new Graph();
  
  eventManager = new EventManager();
  
  mainScene.setAxesVisualHint(false);
  mainScene.setGridVisualHint(false);
  
  dataStructureScene.setAxesVisualHint(false);
  dataStructureScene.setGridVisualHint(false);
  
  resultScene.setAxesVisualHint(false);
  resultScene.setGridVisualHint(false);
  
  pseudocodeScene.setAxesVisualHint(false);
  pseudocodeScene.setGridVisualHint(false);
  
  dataStructureScene.eye().lookAt(new Vec(0,0));
  rectMode(CENTER);
  dataStructureScene.eye().interpolateToZoomOnRegion(new Rect(800,55,20,10));
  
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
  mainCanvas.text("Breadth First Search", genericFrames[0].position().x()-500, genericFrames[0].position().y()-200);
  mainCanvas.rect(genericFrames[0].position().x(),genericFrames[0].position().y(),1800,600);
  mainCanvas.text("Depth First Search", genericFrames[1].position().x()-450, genericFrames[1].position().y()-200);
  mainCanvas.rect(genericFrames[1].position().x(),genericFrames[1].position().y(),1800,600);
  mainCanvas.text("Dijkstra", genericFrames[2].position().x()-250, genericFrames[2].position().y()-200);
  mainCanvas.rect(genericFrames[2].position().x(),genericFrames[2].position().y(),1800,600);
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
  
  resultScene.beginDraw();
  resultCanvas.background(0,0,255);
  resultScene.endDraw();
  resultScene.display();
  
  pseudocodeScene.beginDraw();
  pseudocodeCanvas.background(0,255,0);
  pseudocodeScene.endDraw();
  pseudocodeScene.display();
  
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
    mainScene.eye().interpolateTo(genericFrames[0], 1.0 );
  } else if( key == '2' ) {
    mainScene.eye().interpolateTo(genericFrames[1], 1.0 );
  } else if( key == '3' ) {
    mainScene.eye().interpolateTo(genericFrames[2], 1.0 );
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