class State implements Comparable<State> {

  int cost;
  Node node;

  public State(int cost, Node node) {
    this.cost = cost;
    this.node = node;
  }

  @Override
  public int compareTo(State o) {
    if (this.cost < o.cost)
      return 1;
    if (this.cost > o.cost)
      return -1;
    return this.node.compareTo(o.node);
  }

  @Override
  public String toString() {
    return "Pair [cost=" + cost + ", node=" + node + "]";
  }

}