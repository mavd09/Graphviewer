import remixlab.proscene.*;
import remixlab.dandelion.geom.*;
import remixlab.bias.event.*;
Scene scene;
Graph graph;
Node node1, node2;
Edge edge;
int edgeCounter, nodeCounter, mode;
float RADIUS_NODE = 9;

void setup() {
  size(800, 800, P3D);
  scene = new Scene(this);
  graph = new Graph();
  
  scene.translate(0,0);
  
  edgeCounter = 0; 
  nodeCounter = 0;
  
  mode = 0;
  
  node1 = new Node(1,10, scene);
  node2 = new Node(2,10, scene);
  node2.setPosition(40, 40, 0);
  
  graph.addNode(node1);
  graph.addNode(node2);
  edge = new NonWeightedEdge(1, node1, node2, true, scene);
  graph.addEdge(edge);
}

void draw() {
  background(0);
  if(frameCount == 200) {
    graph.removeEdge(1);
  }
  scene.drawFrames();
  
  //System.out.println(node1.position().x() + " " +  node1.position().y());
}

void mouseClicked() {
  if(mode == 1) {
    System.out.println("adding");
    Node node = new Node(nodeCounter, RADIUS_NODE, scene);
    
    node.setPosition(mouseX, mouseY, 0);
    System.out.println(mouseX + " " + mouseY);
    //Vec ans = scene.projectedCoordinatesOf(new Vec(mouseX, mouseY, 0));
    Vec ans = scene.eye().projectedCoordinatesOf(scene.anchor());
    System.out.println(scene.center());
    System.out.println(ans);
    graph.addNode(node);
    nodeCounter++;
  }
  mode = 0;
}


void keyPressed() {
  if(key == 'n') {
    System.out.println("mode n");
    mode = 1;
  }
  else if(key == 'e') mode = 2;
  else mode = 0;
  
  
}