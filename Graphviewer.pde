import remixlab.proscene.*;
Scene scene;
Graph graph;
Node node;

void setup() {
  size(800, 800, P3D);
  scene = new Scene(this);
  graph = new Graph();
  node = new Node(1, 20, scene);
  
  graph.addNode(node);
}

void draw() {
  background(0);
  scene.drawFrames();
  System.out.println(node.position().x() + " " +  node.position().y());
}