public class Heap<AnyType extends Comparable<? super AnyType>> {

  public static final int DEFAULT_SIZE = 10;

  AnyType[] heap;
  int size;

  @SuppressWarnings("unchecked")
  public Heap(int initialCapacity) {
    if (initialCapacity < 1)
      throw new IllegalArgumentException("initialCapacity must be >= 1");
    heap = (AnyType[]) new Comparable[initialCapacity + 1];
    size = 0;
  }

  public Heap() {
    this(DEFAULT_SIZE);
  }

  public boolean isEmpty() {
    return size == 0;
  }

  public int size() {
    return size;
  }

  public AnyType getTop() {
    if (isEmpty())
      return null;
    return heap[1];
  }
  
  public AnyType get( int i ) {
    return heap[i];
  }

  @SuppressWarnings({ "unchecked" })
  public void put(AnyType theElement) {
    if (size == heap.length - 1) {
      AnyType[] newHeap = (AnyType[]) new Comparable[2 * heap.length];
      System.arraycopy(heap, 1, newHeap, 1, size);
      heap = newHeap;
    }
    int currentNode = ++size;
    for (; currentNode != 1 && heap[currentNode / 2].compareTo(theElement) < 0; currentNode /= 2)
      heap[currentNode] = heap[currentNode / 2];
    heap[currentNode] = theElement;
  }

  public AnyType remove() {
    if (size == 0)
      return null;
    AnyType maxElement = heap[1];
    AnyType lastElement = heap[size--];
    int currentNode = 1, child = 2;
    for (; child <= size; currentNode = child, child *= 2) {
      if (child < size && heap[child].compareTo(heap[child + 1]) < 0)
        child++;
      if (lastElement.compareTo(heap[child]) >= 0)
        break;
      heap[currentNode] = heap[child];
    }
    heap[currentNode] = lastElement;
    return maxElement;
  }

  public String toString() {
    return Arrays.toString(heap);
  }

}