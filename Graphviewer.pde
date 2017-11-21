import remixlab.proscene.*;
import remixlab.dandelion.geom.*;
import remixlab.bias.event.*;

Scene scene;
Graph graph;


void setup() {
  size(800, 800, P3D);
  scene = new Scene(this);
  graph = new Graph();
  
  scene.setAxesVisualHint(false); // hide axis
  scene.setGridVisualHint(false); // hide grid
  
  /*
  node1 = new Node(1,10, scene);
  node2 = new Node(2,10, scene);
  node2.setPosition(40, 40, 0);
  
  graph.addNode(node1);
  graph.addNode(node2);
  edge = new NonWeightedEdge(1, node1, node2, true, scene);
  graph.addEdge(edge);
  */
}

void draw() {
  scene.setCenter(new Vec(400,400,0));
  background(0);
  scene.drawFrames();
}

void mouseClicked() {
  if(InteractiveData.getInstance().getMode() == 1) {
    Node node = new Node(InteractiveData.getInstance().getNodeCounter(), InteractiveData.getInstance().RADIUS_NODE, graph, scene);
    graph.addNode(node);
    InteractiveData.getInstance().setNodeCounter();
    InteractiveData.getInstance().reset();
  }
}

void keyPressed() {
  if(key == 'n') {
    InteractiveData.getInstance().setMode(1);
  } else if(key == 'l') {
    InteractiveData.getInstance().setMode(2);
  } else {
    InteractiveData.getInstance().setMode(0);
  }
}