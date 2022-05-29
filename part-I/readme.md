# Notes of Algorithms, Part I <!-- omit in toc -->

> "An algorithm must be seen to be believed."— Donald Knuth


- [Introduction](#introduction)
- [Fundamentals](#fundamentals)
  - [Autoboxing](#autoboxing)
  - [Bags, Queues, and Stacks](#bags-queues-and-stacks)
    - [Stack implementation](#stack-implementation)
    - [Queue implementation](#queue-implementation)
    - [Bag Implementation](#bag-implementation)
  - [Analysis of Algorithms](#analysis-of-algorithms)
    - [Theory of algorithms](#theory-of-algorithms)
    - [Typical memory usage summary](#typical-memory-usage-summary)
  - [Union-Find](#union-find)
    - [Quick-find (eager approach)](#quick-find-eager-approach)
    - [Quick-union (lazy approach)](#quick-union-lazy-approach)
    - [Weighted quick-union](#weighted-quick-union)
- [Elementary Sorts](#elementary-sorts)
  - [Selection sort](#selection-sort)
  - [Insertion sort](#insertion-sort)
  - [Shellsort](#shellsort)
    - [h-sorting](#h-sorting)
  - [Shuffling](#shuffling)
  - [Convex hull](#convex-hull)
    - [Graham scan](#graham-scan)
- [Mergesort](#mergesort)
  - [Abstract in-place merge](#abstract-in-place-merge)
  - [Top-down mergesort](#top-down-mergesort)
    - [Mergesort: Java implementation](#mergesort-java-implementation)
    - [Mergesort: analysis](#mergesort-analysis)
    - [Mergesort: practical improvements](#mergesort-practical-improvements)
  - [Bottom-up mergesort](#bottom-up-mergesort)
  - [Complexity of sorting](#complexity-of-sorting)
  - [Comparator](#comparator)
    - [Polar order](#polar-order)
  - [Stability](#stability)
- [Quicksort](#quicksort)
  - [Mergesort vs. Quicksort](#mergesort-vs-quicksort)
  - [Quicksort implementation](#quicksort-implementation)
  - [Performance](#performance)
  - [Quicksort: practical improvements](#quicksort-practical-improvements)
  - [Selection](#selection)
    - [Quickselect](#quickselect)
  - [Duplicate keys](#duplicate-keys)
    - [Quicksort with 3-way partitioning](#quicksort-with-3-way-partitioning)
  - [Sorting applications](#sorting-applications)
  - [Java system sorts](#java-system-sorts)
- [Priority Queues](#priority-queues)
  - [Priority queue API](#priority-queue-api)
  - [Priority queue applications](#priority-queue-applications)
  - [Priority queue client example](#priority-queue-client-example)
  - [Priority queue: unordered array implementation](#priority-queue-unordered-array-implementation)
  - [Binary heaps](#binary-heaps)
    - [Binary heap representations](#binary-heap-representations)
      - [Promotion in a heap](#promotion-in-a-heap)
      - [Insertion in a heap](#insertion-in-a-heap)
      - [Demotion in a heap](#demotion-in-a-heap)
      - [Delete the maximum in a heap](#delete-the-maximum-in-a-heap)
    - [Binary heap: Java implementation](#binary-heap-java-implementation)
  - [Priority queues implementation cost summary](#priority-queues-implementation-cost-summary)
  - [Immutability](#immutability)
- [Heapsort](#heapsort)
  - [Heapsort: Java implementation](#heapsort-java-implementation)
  - [Heapsort: mathematical analysis](#heapsort-mathematical-analysis)
  - [Sorting algorithms: summary](#sorting-algorithms-summary)
- [Symbol Tables (Searching)](#symbol-tables-searching)
  - [Basic symbol table API](#basic-symbol-table-api)
  - [Ordered symbol tables](#ordered-symbol-tables)
    - [Ordered symbol table API](#ordered-symbol-table-api)
    - [Binary search: ordered symbol table operations summary](#binary-search-ordered-symbol-table-operations-summary)
- [Binary search trees](#binary-search-trees)
  - [BST implementation](#bst-implementation)
  - [Ordered operations](#ordered-operations)
    - [Minimum and maximum](#minimum-and-maximum)
    - [Floor and ceiling](#floor-and-ceiling)
    - [Selection](#selection-1)
    - [Rank](#rank)
    - [Inorder traversal](#inorder-traversal)
    - [BST: ordered symbol table operations summary](#bst-ordered-symbol-table-operations-summary)
    - [Deletion](#deletion)
  - [ST implementations: summary](#st-implementations-summary)


## Introduction

| topic | data structures and algorithms | course |
| :--: | :--: | :--: |
| data types | stack, queue, bag, union-find, priority queue | Part I |
| sorting | quicksort, mergesort, heapsort | Part I |
| searching | BST, red-black BST, hash table | Part I |
| graphs | BFS, DFS, Prim, Kruskal, Dijkstra | Part II |
| strings | radix sorts, tries, KMP, regexps, data compression | Part II |
| advanced | B-tree, suffix array, maxflow | Part II |

Algorithms have a strong influence in many fields and its applications are innumerable：

- *Internet*. Web search, packet routing, distributed file sharing, ...
- *Biology*. Human genome project, protein folding, ...
- *Computers*. Circuit layout, file system, compilers, ...
- *Computer graphics*. Movies, video games, virtual reality, ...
- *Security*. Cell phones, e-commerce, voting machines, ...
- *Multimedia*. MP3, JPG, DivX, HDTV, face recognition, ...
- *Social networks*. Recommendations, news feeds, advertisements, ...
- *Physics*. N-body simulation, particle collision simulation, ...
- ...

## Fundamentals

### Autoboxing

*Type parameters* have to be instantiated as *reference* types, so Java has special mechanisms to allow generic code to be used with primitive types. Recall that Java’s wrapper types are reference types that correspond to primitive types: `Boolean`, `Byte`, `Character`, `Double`, `Float`, `Integer`, `Long`, and `Short` correspond to `boolean`, `byte`, `char`, `double`, `float`, `int`, `long`, and `short`, respectively. Java automatically converts between these reference types and the corresponding primitive types—in assignments, method arguments, and arithmetic/logic expressions.

Automatically casting a primitive type to a wrapper type is known as **autoboxing**, and automatically casting a wrapper type to a primitive type is known as **auto-unboxing**.

### Bags, Queues, and Stacks

- The way in which we represent the objects in the collection directly impacts the efficiency of the various operations
- Use *generics* and *iteration* to substantially simplify client code
- Understanding *linked lists* is a key first step to the study of algorithms and data
structures

**Bag**

A bag is a collection where removing items is not supported. The order of iteration is unspecified and should be immaterial to the client.

| `public class Bag<Item> implements Iterable<Item>` | | 
| :--: | :--: |
| `Bag()` | create an empty bag |
| `void add(Item item)` | add an item |
| `boolean isEmpty()` | is the bag empty? |
| `int size()` | number of items in the bag |

```java
public class Stats {
    public static void main(String[] args) {
        Bag<Double> numbers = new Bag<Double>();
        
        while (!StdIn.isEmpty())
            numbers.add(StdIn.readDouble());
        int N = numbers.size();

        double sum = 0.0;
        for (double x : numbers)
            sum += x;
        double mean = sum / N;

        sum = 0.0;
        for (double x : numbers)
            sum += (x - mean) * (x - mean);
        double std = Math.sqrt(sum / (N - 1));

        StdOut.printf("Mean: %.2f\n", mean);
        StdOut.printf("Std dev: %.2f\n", std);
    }
}
```

**FIFO queue**

A typical reason to use a queue in an application is to save items in a collection while at the same time *preserving their relative order*.

| `public class Queue<Item> implements Iterable<Item>` | | 
| :--: | :--: |
| `Queue()` | create an empty queue |
| `void enqueue(Item item)` | add an item |
| `Item dequeue()` | remove the least recently added item |
| `boolean isEmpty()` | is the queue empty? |
| `int size()` | number of items in the queue |

**Pushdown (LIFO) stack**

A typical reason to use a stack iterator in an application is to save items in a collection while at the same time *reversing* their relative order .

| `public class Stack<Item> implements Iterable<Item>` | | 
| :--: | :--: |
| `Stack()` | create an empty stack |
| `void push(Item item)` | add an item |
| `Item pop()` | remove the most recently added item |
| `boolean isEmpty()` | is the stack empty? |
| `int size()` |number of items in the stack |

**Dijkstra’s Two-Stack Algorithm for Expression Evaluation**

Example of a stack client: consider a classic example that also demonstrates the utility of generics. computing the value of arithmetic expressions like this one:  
`( 1 + ( ( 2 + 3 ) * ( 4 * 5 ) ) )`

A remarkably simple algorithm that was developed by E. W. Dijkstra in the 1960s uses two stacks (one for operands and one for operators) to do this job.
- Push operands onto the operand stack.
- Push operators onto the operator stack.
- Ignore left parentheses.
- On encountering a right parenthesis, pop an operator, pop the requisite number of operands, and push onto the operand stack the result of applying that operator to those operands.


#### Stack implementation

**ALGORITHM 1.1 Pushdown (LIFO) stack (resizing array implementation)**

```java
import java.util.Iterator;
public class ResizingArrayStack<Item> implements Iterable<Item> 
{
    private Item[] a = (Item[]) new Object[1];  // stack items
    private int N = 0;                          // number of items

    public boolean isEmpty() {   return N == 0;  }
    public int size()        {   return N;       }

    private void resize(int max) 
    {   // Move stack to a new array of size max.
        Item[] temp = (Item[]) new Object[max];
        for (int i = 0; i < N; i++)
            temp[i] = a[i];
        a = temp;
    }

    public void push(Item item) 
    {   // Add item to top of stack.
        if (N == a.length)  resize(2 * a.length);
        a[N++] = item;
    }

    public Item pop() 
    {   // Remove item from top of stack.
        Item item = a[--N];
        a[N] = null; // Avoid loitering (see text).
        if (N > 0 && N == a.length / 4) resize(a.length / 2);
        return item;
    }

    public Iterator<Item> iterator() 
    {  return new ReverseArrayIterator(); }

    private class ReverseArrayIterator implements Iterator<Item> 
    {   // Support LIFO iteration.
        private int i = N;
        public boolean hasNext() {  return i > 0;  }
        public Item next()       {  return a[--i]; }
        public void remove()     {                 }
    }
}
```

**Definition**. A linked list is a recursive data structure that is either empty (null) or a reference to a node having a generic item and a reference to a linked list.

**ALGORITHM 1.2 Pushdown stack (linked-list implementation)**

```java
public class Stack<Item> implements Iterable<Item> 
{
    private Node first;     // top of stack (most recently added node)
    private int N;          // number of items

    private class Node 
    {   // nested class to define nodes
        Item item;
        Node next;
    }

    public boolean isEmpty() {  return first == null;  } // Or: N == 0.
    public int size()        {  return N;              }

    public void push(Item item) 
    {   // Add item to top of stack.
        Node oldfirst = first;
        first = new Node();
        first.item = item;
        first.next = oldfirst;
        N++;
    }

    public Item pop() 
    {   // Remove item from top of stack.
        Item item = first.item;
        first = first.next;
        N--;
        return item;
    }
 
    // iterator() implementation.
    public Iterator<Item> iterator() 
    {   return new ListIterator();  }

    private class ListIterator implements Iterator<Item> 
    {
        private Node current = first;

        public boolean hasNext() 
        {   return current != null; }

        public void remove() {  }
        public Item next() 
        {
            Item item = current.item;
            current = current.next;
            return item;
        }
    }

    // test client main().
    public static void main(String[] args) 
    {   // Create a stack and push/pop strings as directed on StdIn.
        Stack<String> s = new Stack<String>();
        while (!StdIn.isEmpty()) 
        {
            String item = StdIn.readString();
            if (!item.equals("-"))
                s.push(item);
            else if (!s.isEmpty())
                StdOut.print(s.pop() + " ");
        }
        StdOut.println("(" + s.size() + " left on stack)");
    }
}
```

#### Queue implementation

This implementation uses the same data structure as does Stack—*a linked list*—but it implements different algorithms for adding and removing items, which make the difference between LIFO and FIFO for the client.

**ALGORITHM 1.3 FIFO queue**

```java
public class Queue<Item> implements Iterable<Item> 
{
    private Node first;     // link to least recently added node
    private Node last;      // link to most recently added node
    private int N;          // number of items on the queue

    private class Node 
    {   // nested class to define nodes
        Item item;
        Node next;
    }

    public boolean isEmpty()    {  return first == null;  } // Or: N == 0.
    public int size()           {  return N;              }

    public void enqueue(Item item) 
    {   // Add item to the end of the list.
        Node oldlast = last;
        last = new Node();
        last.item = item;
        last.next = null;
        if (isEmpty())
            first = last;
        else
            oldlast.next = last;
        N++;
    }

    public Item dequeue() 
    {   // Remove item from the beginning of the list.
        Item item = first.item;
        first = first.next;
        if (isEmpty())
            last = null;
        N--;
        return item;
    }

    // iterator() implementation.
    public Iterator<Item> iterator() 
    {  return new ListIterator();  }

    private class ListIterator implements Iterator<Item> {
        private Node current = first;

        public boolean hasNext() {  return current != null; }
        public void remove() {  }

        public Item next() 
        {
            Item item = current.item;
            current = current.next;
            return item;
        }
    }

    // test client main().
    public static void main(String[] args) { // Create a queue and enqueue/dequeue strings.
        Queue<String> q = new Queue<String>();
        while (!StdIn.isEmpty()) {
            String item = StdIn.readString();
            if (!item.equals("-"))
                q.enqueue(item);
            else if (!q.isEmpty())
                StdOut.print(q.dequeue() + " ");
        }
        StdOut.println("(" + q.size() + " left on queue)");
    }
}
```

*Linked lists are a fundamental alternative to arrays* for structuring a collection of data. From a historical perspective, this alternative has been available to programmers for many decades. Indeed, a landmark in the history of programming languages was the development of **LISP** by John McCarthy in the 1950s, where linked lists are the primary structure for programs and data.

#### Bag Implementation

This Bag implementation maintains a linked list of the items provided in calls to `add()`. Code for `isEmpty()` and `size()` is the same as in Stack and is omitted. The iterator traverses the list, maintaining the current node in current.

**ALGORITHM 1.4 Bag**

```java
import java.util.Iterator;
public class Bag<Item> implements Iterable<Item>
{
    private Node first; // first node in list
    private class Node
    {
        Item item;
        Node next;
    }

    public void add(Item item)
    { // same as push() in Stack
        Node oldfirst = first;
        first = new Node();
        first.item = item;
        first.next = oldfirst;
    }

    public Iterator<Item> iterator()
    { return new ListIterator(); }

    private class ListIterator implements Iterator<Item>
    {
        private Node current = first;
        public boolean hasNext()
        { return current != null; }
        public void remove() { }
        public Item next()
        {
            Item item = current.item;
            current = current.next;
            return item;
        }
    }
}
```

**Data structures**. We now have two ways to represent collections of objects, arrays and linked lists. Arrays are built in to Java; linked lists are easy to build with standard Java records. These two alternatives, often referred to as sequential allocation and linked allocation, are fundamental.

| data structure | advantage | disadvantage |
| :--: | :--: | :--: |
| array | index provides immediate access to any item | need to know size on initialization |
| linked list | uses space proportional to size | need reference to access an item |

Examples of data structures developed in the book [*Algorithms, 4th Edition, Robert Sedgewick and Kevin Wayne, Princeton University*](https://algs4.cs.princeton.edu/home/):

| data structure | section | ADT | representation | 
| :--: | :--: | :--: | :--: |
| parent-link tree | 1.5 | UnionFind | array of integers |
| binary search tree | 3.2, 3.3 | BST | two links per node |
| string | 5.1 | String | array, offset, and length |
| binary heap | 2.4 | PQ | array of objects |
| hash table (separate chaining) | 3.4 | SeparateChainingHashST | arrays of linked lists |
| hash table (linear probing) | 3.4 | LinearProbingHashST | two arrays of objects |
| graph adjacency lists | 4.1, 4.2 | Graph | array of Bag objects |
| trie | 5.2 | TrieST | node with array of links |
| ternary search trie | 5.3 | TST | three links per node |


### Analysis of Algorithms

**Reasons to analyze algorithms**:
- Predict performance.
- Compare algorithms.
- Provide guarantees.
- Understand theoretical basis.

**Some algorithmic successes**:
- Discrete Fourier transform
  - Break down waveform of N samples into periodic components.
  - Applications: DVD, JPEG, MRI, astrophysics, ….
  - Brute force: N<sup>2</sup> steps.
  - [FFT algorithm](https://en.wikipedia.org/wiki/Fast_Fourier_transform): `NlogN` steps, enables new technology.
- N-body simulation.
  - Simulate gravitational interactions among N bodies.
  - Brute force: N<sup>2</sup> steps.
  - Barnes-Hut algorithm: `NlogN` steps, enables new research.

**Scientific method applied to analysis of algorithms**

A framework for predicting performance and comparing algorithms.

Scientific method:
- *Observe* some feature of the natural world.
- *Hypothesize* a model that is consistent with the observations.
- *Predict* events using the hypothesis.
- *Verify* the predictions by making further observations.
- *Validate* by repeating until the hypothesis and observations agree.

**Common order-of-growth classifications**

<img src="res/common-order-of-growth-classifications.png" alt="Common order-of-growth classifications" width="550">

**Types of analyses**

- Best case. Lower bound on cost.
- Worst case. Upper bound on cost.
- Average case. “Expected” cost.

#### Theory of algorithms

- Goals
  - Establish “difficulty” of a problem.
  - Develop “optimal” algorithms.
- Approach
  - Suppress details in analysis: analyze “to within a constant factor”.
  - Eliminate variability in input model by focusing on the worst case.
- Optimal algorithm
  - Performance guarantee (to within a constant factor) for any input.
  - No algorithm can provide a better performance guarantee.

Commonly-used notations in the theory of algorithms:
- Big Theta `Θ()`. provides *asymptotic order of growth*. used to *classify algorithms*.
- Big Oh `O()`. provides *`Θ()` and smaller*. used to *develop upper bounds*.
- Big Omega `Ω()`. provides *`Θ()` and larger*. used to *develop lower bounds*.

#### Typical memory usage summary

Total memory usage for a data type value:
- Primitive type: 4 bytes for int, 8 bytes for double, …
- Object reference: 8 bytes.
- Array: 24 bytes + memory for each array entry.
- Object: 16 bytes + memory for each instance variable + 8 bytes if inner class (for pointer to enclosing class).
- Padding: round up to multiple of 8 bytes.
  
*Shallow memory usage*: Don't count referenced objects.

*Deep memory usage*: If array entry or instance variable is a reference, add memory (recursively) for referenced object.

### Union-Find

We shall consider three different implementations, all based on using the site-indexed `id[]` array, to determine whether two sites are in the same connected component.

#### Quick-find (eager approach)

**Data structure.**
- Integer array `id[]` of length `N`.
- Interpretation: `p` and `q` are connected iff they have the same id.

**Find**. Check if `p` and `q` have the same id.

**Union**. To merge components containing `p` and `q`, change all entries whose id equals `id[p]` to `id[q]`.

```java
public class QuickFindUF
{
    private int[] id;
    public QuickFindUF(int N)
    {
        id = new int[N];
        for (int i = 0; i < N; i++)
            id[i] = i;
    }
    public boolean connected(int p, int q)
    { return id[p] == id[q]; }
    public void union(int p, int q)
    {
        int pid = id[p];
        int qid = id[q];
        for (int i = 0; i < id.length; i++)
            if (id[i] == pid) id[i] = qid;
    }
}
```

**Quick-find is too slow**:  
*Union is too expensive*. It takes *N<sup>2</sup>* array accesses to process a sequence of `N` union commands on `N` objects.

#### Quick-union (lazy approach)

**Data structure.**
- Integer array `id[]` of length `N`.
- Interpretation: `id[i]` is parent of `i`.
- *Root* of `i` is `id[id[id[...id[i]...]]]`.

**Find**. Check if `p` and `q` have the same root.

**Union**. To merge components containing `p` and `q`, set the id of `p`'s root to the id of `q`'s root.

```java
public class QuickUnionUF
{
    private int[] id;
    public QuickUnionUF(int N)
    {
        id = new int[N];
        for (int i = 0; i < N; i++) id[i] = i;
    }
    private int root(int i)
    {
        while (i != id[i]) i = id[i];
        return i;
    }
    public boolean connected(int p, int q)
    {
        return root(p) == root(q);
    }
    public void union(int p, int q)
    {
        int i = root(p);
        int j = root(q);
        id[i] = j;
    }
}
```

**Quick-union is also too slow**:

*Quick-find defect*.
- Union too expensive (`N` array accesses).
- Trees are flat, but too expensive to keep them flat.

*Quick-union defect*.
- Trees can get tall.
- Find too expensive (could be `N` array accesses).


#### Weighted quick-union

**Improvement 1: weighting**

- Modify quick-union to avoid tall trees.
- Keep track of size of each tree (number of objects).
- Balance by linking root of smaller tree to root of larger tree.

*Data structure*. Same as quick-union, but maintain extra array `sz[i]` to count number of objects in the tree rooted at `i`.

*Find*. Identical to quick-union.

*Union*. Modify quick-union to:
- Link root of smaller tree to root of larger tree.
- Update the `sz[]` array.

*Running time*.
- Find: takes time proportional to depth of `p` and `q`.
- Union: takes constant time, given roots.

**Proposition**. Depth of any node `x` is at most `lgN`.  

*Proof*. When does depth of `x` increase?
Increases by `1` when tree T<sub>1</sub> containing `x` is merged into another tree T<sub>2</sub>.
- The size of the tree containing `x` at least doubles since |T<sub>2</sub>|≥|T<sub>1</sub>|.
- Size of tree containing `x` can double at most `lgN` times. Why?

| algorithm | initialize | union | connected | 
| :--: | :--: | :--: | :--: |
| quick-find | N | N | 1 | 
| quick-union | N | N<sup>†</sup> | N | 
| weighted QU | N | lgN<sup>†</sup> | lgN | 

† includes cost of finding roots

```java
public class WeightedQuickUnionUF
{
    private int[] id;   // parent link (site indexed)
    private int[] sz;   // size of component for roots (site indexed)
    private int count;  // number of components
    public WeightedQuickUnionUF(int N)
    {
        count = N;
        id = new int[N];
        for (int i = 0; i < N; i++) id[i] = i;
        sz = new int[N];
        for (int i = 0; i < N; i++) sz[i] = 1;
    }

    public int count()
    { return count; }

    public boolean connected(int p, int q)
    { return find(p) == find(q); }

    private int find(int p)
    {   // Follow links to find a root.
        while (p != id[p]) p = id[p];
        return p;
    }

    public void union(int p, int q)
    {
        int i = find(p);
        int j = find(q);
        if (i == j) return;
        // Make smaller root point to larger one.
        if (sz[i] < sz[j]) { id[i] = j; sz[j] += sz[i]; }
        else { id[j] = i; sz[i] += sz[j]; }
        count--;
    }
}
```

**Improvement 2: path compression**

*Quick union with path compression*. Just after computing the root of `p`, set the id of each examined node to point to that root.

```java
private int root(int i)
{
    while (i != id[i])
    {
        id[i] = id[id[i]];
        i = id[i];
    }
    return i;
}
```

## Elementary Sorts

**Sorting cost model**. When studying sorting algorithms, we count compares and exchanges. For algorithms that do not use exchanges, we count array accesses.

**Total order**. A total order is a binary relation `≤` that satisfies:
- Antisymmetry: if `v ≤ w` and `w ≤ v`, then `v = w`.
- Transitivity: if `v ≤ w` and `w ≤ x`, then `v ≤ x`.
- Totality: either `v ≤ w` or `w ≤ v` or both.

*Note*: The `<=` operator for double is not a total order, for `(Double.NaN <= Double.NaN)` is false.

Implement `compareTo()` so that `v.compareTo(w)`
- Is a total order.
- Returns a negative integer, zero, or positive integer if v is less than, equal to, or greater than w, respectively.
- Throws an exception if incompatible types (or either is null).

*Built-in comparable types*. Integer, Double, String, Date, File, ...
*User-defined comparable types*. Implement the Comparable interface.

**Callback = reference to executable code.**
- Client passes array of objects to sort() function.
- The sort() function calls back object's compareTo() method as needed.

**Implementing callbacks.**
- Java: interfaces.
- C: function pointers.
- C++: class-type functors.
- C#: delegates.
- Python, Perl, ML, Javascript: first-class functions.

**Less**. Is item `v` less than `w`?

```java
private static boolean less(Comparable v, Comparable w)
{ return v.compareTo(w) < 0; }
```

**Exchange**. Swap item in array `a[]` at index `i` with the one at index `j`.

```java
private static void exch(Comparable[] a, int i, int j)
{
    Comparable swap = a[i];
    a[i] = a[j];
    a[j] = swap;
}
```

See more: [Sorting Algorithms Animations](https://www.toptal.com/developers/sorting-algorithms).

### Selection sort

- In iteration i, find index min of smallest remaining entry.
- Swap `a[i]` and `a[min]`.

Invariants.
- Entries the left of ↑ (including ↑, ↑ is current position) fixed and in ascending order.
- No entry to right of ↑ is smaller than any entry to the left of ↑.

**Selection sort: Java implementation**

```java
public class Selection 
{
    public static void sort(Comparable[] a) 
    {
        int N = a.length;
        for (int i = 0; i < N; i++) 
        {
            int min = i;
            for (int j = i + 1; j < N; j++)
                if (less(a[j], a[min]))
                    min = j;
            exch(a, i, min);
        }
    }

    private static boolean less(Comparable v, Comparable w) 
    {  /* as before */ }

    private static void exch(Comparable[] a, int i, int j) 
    {  /* as before */ }
}
```

**Proposition**. Selection sort uses `(N – 1) + (N – 2) + ... + 1 + 0` ~ N<sup>2</sup>/2 compares and `N` exchanges.

**Running time insensitive to input**. Quadratic time, even if input is sorted.

**Data movement is minimal**. Linear number of exchanges.

### Insertion sort

- In iteration `i`, swap `a[i]` with each larger entry to its left.

Invariants.
- Entries to the left of ↑ (including ↑) are in ascending order.
- Entries to the right of ↑ have not yet been seen.

**Insertion sort: Java implementation**

```java
public class Insertion {
    public static void sort(Comparable[] a) {
        int N = a.length;
        for (int i = 0; i < N; i++)
            for (int j = i; j > 0; j--)
                if (less(a[j], a[j - 1]))
                    exch(a, j, j - 1);
                else
                    break;
    }

    private static boolean less(Comparable v, Comparable w) {
        /* as before */ }

    private static void exch(Comparable[] a, int i, int j) {
        /* as before */ }
}
```

**Proposition**. To sort a randomly-ordered array with distinct keys, insertion sort uses ~1/4 N<sup>2</sup> compares and ~1/4 N<sup>2</sup> exchanges on average.

**Best case**. If the array is in ascending order, insertion sort makes `N - 1` compares and `0` exchanges.

**Worst case**. If the array is in descending order (and no duplicates), insertion sort makes ~1/2 N<sup>2</sup> compares and ~1/2 N<sup>2</sup> exchanges.

**Insertion sort for partially-sorted arrays**

*Def*. An *inversion* is a pair of keys that are out of order.  
e.g.: `A E E L M O T R X P S`  
(6 inversions): `T-R`, `T-P`, `T-S`, `R-P`, `X-P`, `X-S`.

*Def*. An array is partially sorted if the number of inversions is `≤ cN`.
- Ex 1. A subarray of size 10 appended to a sorted subarray of size N.
- Ex 2. An array of size N with only 10 entries out of place.

*Proposition*. For partially-sorted arrays, insertion sort runs in linear time.  
*Pf*. Number of exchanges equals the number of inversions. (number of compares = exchanges + (N – 1).)

### Shellsort

Shellsort is a simple extension of insertion sort that gains speed by allowing exchanges of array entries that are far apart, to produce partially sorted arrays that can be efficiently sorted, eventually by insertion sort.

*Idea*. Move entries more than one position at a time by `h-sorting` the array.

*Shellsort*. [Shell 1959] `h-sort` array for decreasing sequence of values of `h`.

#### h-sorting

*How to h-sort an array?* Insertion sort, with stride length `h`.

*Why insertion sort?*
- Big increments ⇒ small subarray.
- Small increments ⇒ nearly in order.

**Proposition**. A `g-sorted` array remains `g-sorted` after `h-sorting` it.

*Which increment sequence to use?* `3x + 1` is easy to compute. `1, 4, 13, 40, 121, 364, …`

**Shellsort: Java implementation**

```java
public class Shell {
    public static void sort(Comparable[] a) {
        int N = a.length;
        int h = 1;
        while (h < N / 3)
            h = 3 * h + 1; // 1, 4, 13, 40, 121, 364, ...
        while (h >= 1) { // h-sort the array.
            for (int i = h; i < N; i++) {
                for (int j = i; j >= h && less(a[j], a[j - h]); j -= h)
                    exch(a, j, j - h);
            }
            h = h / 3;
        }
    }

    private static boolean less(Comparable v, Comparable w) {
        /* as before */ }

    private static void exch(Comparable[] a, int i, int j) {
        /* as before */ }
}
```

**Proposition**. The worst-case number of compares used by shellsort with the `3x+1` increments is O(N<sup>3/2</sup>).

*Why are we interested in shellsort?*
- Useful in practice.
  - Fast unless array size is huge (used for small subarrays).
  - Tiny, fixed footprint for code (used in some embedded systems).
  - Hardware sort prototype.
- Simple algorithm, nontrivial performance, interesting questions.
  - Asymptotic growth rate?
  - Best sequence of increments?
  - Average-case performance?


### Shuffling

*Goal*. Rearrange array so that result is a uniformly random permutation.

**Shuffle sort**
- Generate a random real number for each array entry.
- Sort the array.

*Proposition*. Shuffle sort produces a uniformly random permutation of the input array, provided no duplicate values.

**Knuth shuffle**
- In iteration `i`, pick integer `r` between `0` and `i` uniformly at random.
- Swap `a[i]` and `a[r]`.

*Proposition*. [Fisher-Yates 1938] Knuth shuffling algorithm produces a uniformly random permutation of the input array in linear time.

```java
public class StdRandom {
    // ...
    public static void shuffle(Object[] a) {
        int N = a.length;
        for (int i = 0; i < N; i++) {
            int r = StdRandom.uniform(i + 1);
            exch(a, i, r);
        }
    }
}
```

### Convex hull

Geometric properties (fact):
- Can traverse the convex hull by making only counterclockwise turns.
- The vertices of convex hull appear in increasing order of polar angle with respect to point p with lowest y-coordinate.

    <img src="res/convex-hull.png" alt="convex hull" width="280">


#### Graham scan

- Choose point p with smallest y-coordinate.
- Sort points by polar angle with p.
- Consider points in order; discard unless it create a *counterclockwise* turn.

**Implementing ccw**

<img src="res/ccw.png" alt="implementing ccw" width="550">

```java
public class Point2D {
    private final double x;
    private final double y;

    public Point2D(double x, double y) {
        this.x = x;
        this.y = y;
    }

    // ...

    public static int ccw(Point2D a, Point2D b, Point2D c) {
        double area2 = (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
        if (area2 < 0)
            return -1;  // clockwise
        else if (area2 > 0)
            return +1;  // counter-clockwise
        else
            return 0;   // collinear
    }
}
```

## Mergesort

- Java sort for objects.
- Perl, C++ stable sort, Python stable sort, Firefox JavaScript, ...

**Basic plan**.
- Divide array into two halves.
- *Recursively* sort each half.
- Merge two halves.

**Goal**. Given two sorted subarrays `a[lo]` to `a[mid]` and `a[mid+1]` to `a[hi]`, replace with sorted subarray `a[lo]` to `a[hi]`.

### Abstract in-place merge

This method merges by first copying into the auxiliary array `aux[]` then merging back to `a[]`. In the merge (the second for loop), there are four conditions: left half exhausted (take from the right), right half exhausted (take from the left), current key on right less than current key on left (take from the right), and current key on right greater than or equal to current key on left (take from the left).

```java
private static void merge(Comparable[] a, Comparable[] aux, int lo, int mid, int hi)
{
    assert isSorted(a, lo, mid);        // precondition: a[lo..mid] sorted
    assert isSorted(a, mid+1, hi);      // precondition: a[mid+1..hi] sorted

    for (int k = lo; k <= hi; k++)
        aux[k] = a[k];

    // i is an iterating index for the left half, j for the right half
    int i = lo, j = mid + 1; 
    for (int k = lo; k <= hi; k++)
    {   // k is iterating index for the copy 
        if      (i > mid)               a[k] = aux[j++]; // left half run out, just copy remaining of right
        else if (j > hi)                a[k] = aux[i++]; // right half run out, just copy remaining of left
        else if (less(aux[j], aux[i]))  a[k] = aux[j++]; // copy by order, smaller first
        else                            a[k] = aux[i++]; // copy by order, smaller first
    }
    assert isSorted(a, lo, hi);         // postcondition: a[lo..hi] sorted
}
```

**Note**: *Assertion* is a statement to test assumptions about your program.
- Helps detect logic bugs.
- Documents code.

*Java assert statement*. Throws exception unless boolean condition is true. `assert isSorted(a, lo, hi);` Assertion can be enabled or disabled at runtime.

```
java -ea MyProgram // enable assertions
java -da MyProgram // disable assertions (default)
```

*Best practices*. Use assertions to check internal invariants; assume assertions will be disabled in production code.

See also: [Merge-sort with Transylvanian-saxon (German) folk dance](https://www.youtube.com/watch?v=dENca26N6V4&t=23s).

### Top-down mergesort

#### Mergesort: Java implementation

The code is based on top-down mergesort. It is one of the best-known examples of the utility of the divide-and-conquer paradigm for efficient algorithm design. This recursive code is the basis for an inductive proof that the algorithm sorts the array: if it sorts the two subarrays, it sorts the whole array, by merging together the subarrays.

```java
public class Merge
{
    private static void sort(Comparable[] a, Comparable[] aux, int lo, int hi)
    {
        if (hi <= lo) return;
        int mid = lo + (hi - lo) / 2;
        sort(a, aux, lo, mid);
        sort(a, aux, mid+1, hi);
        merge(a, aux, lo, mid, hi);
    }

    public static void sort(Comparable[] a)
    {
        aux = new Comparable[a.length];
        sort(a, aux, 0, a.length - 1);
    }
}
```

#### Mergesort: analysis

**Proposition**. 
- *Number of compares and array accesses*. Mergesort uses at most `NlgN` compares and `6NlgN` array accesses to sort any array of size `N`.
- *Divide-and-conquer recurrence*. If `D(N)` satisfies `D(N) = 2D(N/2) + N` for `N > 1`, with `D(1) = 0`, then `D(N) = NlgN`.
- *Memory*. Mergesort uses extra space proportional to `N`.

*Def*. A sorting algorithm is *in-place* if it uses `≤ clogN` extra memory.  
Ex. Insertion sort, selection sort, shellsort.

#### Mergesort: practical improvements

- Use insertion sort for small subarrays.
  - Mergesort has too much overhead for tiny subarrays.
  - Cutoff to insertion sort for `≈ 7` items.

```java
private static void sort(Comparable[] a, Comparable[] aux, int lo, int hi)
{
    if (hi <= lo + CUTOFF - 1)
    {
        Insertion.sort(a, lo, hi);
        return;
    }
    int mid = lo + (hi - lo) / 2;
    sort (a, aux, lo, mid);
    sort (a, aux, mid+1, hi);
    merge(a, aux, lo, mid, hi);
}
```

- Stop if already sorted.
  - Is biggest item in first half ≤ smallest item in second half?
  - Helps for partially-ordered arrays.

```java
private static void sort(Comparable[] a, Comparable[] aux, int lo, int hi)
{
    if (hi <= lo) return;
    int mid = lo + (hi - lo) / 2;
    sort (a, aux, lo, mid);
    sort (a, aux, mid+1, hi);
    if (!less(a[mid+1], a[mid])) return;
    merge(a, aux, lo, mid, hi);
}
```

- Eliminate the copy to the auxiliary array. Save time (but not space) by switching the role of the input and auxiliary array in each recursive call.

```java
private static void merge(Comparable[] a, Comparable[] aux, int lo, int mid, int hi)
{
    int i = lo, j = mid+1;
    for (int k = lo; k <= hi; k++)
    {
        if      (i > mid)           aux[k] = a[j++];
        else if (j > hi)            aux[k] = a[i++];
        else if (less(a[j], a[i]))  aux[k] = a[j++];
        else                        aux[k] = a[i++];
    }
}

private static void sort(Comparable[] a, Comparable[] aux, int lo, int hi)
{
    if (hi <= lo) return;
    int mid = lo + (hi - lo) / 2;
    sort (aux, a, lo, mid);
    sort (aux, a, mid+1, hi);
    merge(a, aux, lo, mid, hi); // switch roles of aux[] and a[]
}
```

### Bottom-up mergesort

Bottom-up mergesort consists of a sequence of passes over the whole array, doing `sz-by-sz` merges, starting with `sz` equal to `1` and doubling `sz` on each pass. The final subarray is of size `sz` only when the array size is an even multiple of `sz` (otherwise it is less than `sz`). 

Simple and non-recursive version of mergesort.

```java
public class MergeBU
{
    private static Comparable[] aux;    // auxiliary array for merges

    private static void merge(...)
    { /* as before */ }

    public static void sort(Comparable[] a)
    { // Do lgN passes of pairwise merges.
        int N = a.length;
        aux = new Comparable[N];
        for (int sz = 1; sz < N; sz = sz+sz)                // sz: subarray size
            for (int lo = 0; lo < N - sz; lo += sz + sz)    // lo: subarray index
                merge(a, lo, lo+sz-1, Math.min(lo+sz+sz-1, N-1));
    }
}
```
### Complexity of sorting

*Computational complexity*. Framework to study efficiency of algorithms for solving a particular problem `X`.

- *Model of computation*. Allowable operations.
- *Cost model*. Operation count(s).
- *Upper bound*. Cost guarantee provided by some algorithm for `X`.
- *Lower bound*. Proven limit on cost guarantee of all algorithms for `X`.
- *Optimal algorithm*. Algorithm with best possible cost guarantee for `X`.

**Proposition**. Any compare-based sorting algorithm must use at least `lg(N!) ~ NlgN` compares in the worst-case.

Proof:
- Assume array consists of `N` distinct values a<sub>1</sub> through a<sub>N</sub>.
- Worst case dictated by height `h` of decision tree.
- Binary tree of height `h` has at most 2<sup>h</sup> leaves.
- `N!` different orderings ⇒ at least `N!` leaves.

    `2h ≥ #leaves ≥ N!` ⇒ `h ≥ lg(N!) ~ NlgN` ([Stirling's formula](https://en.wikipedia.org/wiki/Stirling%27s_approximation)).

*Example: sorting.*
- Model of computation: decision tree. (can access information only through compares (e.g., Java Comparable framework))
- Cost model: #compares.
- Upper bound: ~ NlgN from mergesort.
- Lower bound: ~ NlgN
- Optimal algorithm: mergesort

**Complexity results in context**

- Compares? Mergesort is optimal with respect to number compares.
- Space? Mergesort is not optimal with respect to space usage.

*Lessons*. Use theory as a guide.
- Design sorting algorithm that guarantees ½ N lg N compares?
- Design sorting algorithm that is both time- and space-optimal?

Lower bound may not hold if the algorithm has information about:
- The initial order of the input.
- The distribution of key values.
- The representation of the keys.

*Partially-ordered arrays*. Depending on the initial order of the input, we may not need `NlgN` compares. (insertion sort requires only `N-1` compares if input array is sorted)

*Duplicate keys*. Depending on the input distribution of duplicates, we may not need `NlgN` compares.

*Digital properties of keys*. We can use digit/character compares instead of key compares for numbers and strings.

### Comparator

Comparator interface: sort using an *alternate order*.

To use with Java system sort:
- Create Comparator object.
- Pass as second argument to `Arrays.sort()`.

```java
String[] a;
Arrays.sort(a); // uses natural order

// uses alternate order defined by Comparator<String> object
Arrays.sort(a, String.CASE_INSENSITIVE_ORDER);
Arrays.sort(a, Collator.getInstance(new Locale("es")));
Arrays.sort(a, new BritishPhoneBookOrder());
```

To support comparators in our sort implementations:
- Use Object instead of Comparable.
- Pass Comparator to sort() and less() and use it in less().

```java
public static void sort(Object[] a, Comparator comparator)
{
    int N = a.length;
    for (int i = 0; i < N; i++)
        for (int j = i; j > 0 && less(comparator, a[j], a[j-1]); j--)
            exch(a, j, j-1);
}

private static boolean less(Comparator c, Object v, Object w)
{ return c.compare(v, w) < 0; }

private static void exch(Object[] a, int i, int j)
{ Object swap = a[i]; a[i] = a[j]; a[j] = swap; }
```

**To implement a comparator**:
- Define a (nested) class that implements the Comparator interface.
- Implement the `compare()` method.

```java
public class Student
{
    public static final Comparator<Student> BY_NAME = new ByName();
    public static final Comparator<Student> BY_SECTION = new BySection();
    private final String name;
    private final int section;
...
    private static class ByName implements Comparator<Student>
    {
        public int compare(Student v, Student w)
        { return v.name.compareTo(w.name); }
    }
    private static class BySection implements Comparator<Student>
    {
        public int compare(Student v, Student w)
        { return v.section - w.section; }
    }
}
```

#### Polar order

<img src="res/polar-order.png" alt="Polar order" width="380">

A ccw-based solution.
- If `q1` is above `p` and `q2` is below `p`, then `q1` makes smaller polar angle.
- If `q1` is below `p` and `q2` is above `p`, then `q1` makes larger polar angle.
- Otherwise, `ccw(p, q1, q2)` identifies which of `q1` or `q2` makes larger angle.

```java
public class Point2D
{
    public final Comparator<Point2D> POLAR_ORDER = new PolarOrder();
    private final double x, y;
...
    private static int ccw(Point2D a, Point2D b, Point2D c)
    { /* as in previous lecture */ }
    private class PolarOrder implements Comparator<Point2D>
    {
        public int compare(Point2D q1, Point2D q2)
        {
            double dy1 = q1.y - y;
            double dy2 = q2.y - y;
            if (dy1 == 0 && dy2 == 0) { ... }
            else if (dy1 >= 0 && dy2 < 0) return -1;
            else if (dy2 >= 0 && dy1 < 0) return +1;
            else return -ccw(Point2D.this, q1, q2);
        }
    }
}
```

### Stability

A stable sort preserves the relative order of items with equal keys.

*Stable*:
- Insertion sort
- Mergesort

*Not stable*: (Long-distance exchange might move an item past some equal item.)
- selection sort. 
- shellsort).


## Quicksort

[<img src="res/Sorting_quicksort_anim.gif" alt="Quicksort animation" width="280">](https://en.wikipedia.org/wiki/Quicksort "Wikipedia: Quicksort")

*via* [Wikipedia: Quicksort](https://en.wikipedia.org/wiki/Quicksort)

*Quicksort* is honored as one of top 10 algorithms of 20th century in science and engineering.

- Java sort for primitive types.
- C qsort, Unix, Visual C++, Python, Matlab, Chrome JavaScript, ...

**Basic plan**.
- *Shuffle* the array.
- *Partition* so that, for some `j`
  - entry `a[j]` is in place
  - no larger entry to the left of `j`
  - no smaller entry to the right of `j`
- *Sort* each piece recursively.


*Partitioning process*

- Repeat until `i` and `j` pointers cross**.
  - Scan `i` from left to right so long as (`a[i]` < `a[lo]`).
  - Scan `j` from right to left so long as (`a[j] > a[lo]`).
  - Exchange `a[i]` with `a[j]`.
- When pointers cross.
  - Exchange `a[lo]` with `a[j]`.

### Mergesort vs. Quicksort
- For mergesort, we break the array into two subarrays to be sorted and then combine the ordered subarrays to make the whole ordered array.
  - Do the two recursive calls before working on the whole array.
  - The array is divided in half.
- For quicksort, we rearrange the array such that, when the two subarrays are sorted, the whole array is ordered. 
  - Do the two recursive calls after working on the whole array.
  - The position of the partition depends on the contents of the array.


### Quicksort implementation

ALGORITHM 2.5 Quicksort

```java
public class Quick
{
    public static void sort(Comparable[] a)
    {
        StdRandom.shuffle(a);           // Eliminate dependence on input.
        sort(a, 0, a.length - 1);
    }

    private static void sort(Comparable[] a, int lo, int hi)
    {
        if (hi <= lo) return;
        int j = partition(a, lo, hi);   // Partition 
        sort(a, lo, j-1);               // Sort left part a[lo .. j-1].
        sort(a, j+1, hi);               // Sort right part a[j+1 .. hi].
    }

    private static int partition(Comparable[] a, int lo, int hi)
    {       // Partition into a[lo..i-1], a[i], a[i+1..hi].
        int i = lo, j = hi+1;           // left and right scan indices
        Comparable v = a[lo];           // partitioning item
        while (true)
        {   // Scan right, scan left, check for scan complete, and exchange.
            while (less(a[++i], v)) if (i == hi) break;
            while (less(v, a[--j])) if (j == lo) break;
            if (i >= j) break;
            exch(a, i, j);
        }
        exch(a, lo, j);                 // Put v = a[j] into position
        return j;                       // with a[lo..j-1] <= a[j] <= a[j+1..hi].
    }
}
```

### Performance

- Worst-case performance: *O(N<sup>2</sup>)*
- Best-case performance: 
  - *O(NlogN)* (simple partition)
  - *O(N)* (three-way partition and equal keys)
- Average performance: *O(NlogN)* (Number of compares is ~ 1.39 *NlogN*.)
  - 39% more compares than mergesort.
  - But faster than mergesort in practice because of less data movement.
- Worst-case space complexity 
  - *O(N)* auxiliary (naive)
  - *O(logN)* auxiliary (Hoare 1962)

*Proposition*. Quicksort is not stable.

### Quicksort: practical improvements

*Insertion sort small subarrays.*
- Even quicksort has too much overhead for tiny subarrays.
- Cutoff to insertion sort for ≈ 10 items.
- Note: could delay insertion sort until one pass at end.


```java
private static void sort(Comparable[] a, int lo, int hi)
{
    if (hi <= lo + CUTOFF - 1)
    {
        Insertion.sort(a, lo, hi);
        return;
    }
    int j = partition(a, lo, hi);
    sort(a, lo, j-1);
    sort(a, j+1, hi);
}
```

*Median of sample.*
- Best choice of pivot item = median.
- Estimate true median by taking median of sample.
- Median-of-3 (random) items.

```java
private static void sort(Comparable[] a, int lo, int hi)
{
    if (hi <= lo) return;
    int m = medianOf3(a, lo, lo + (hi - lo)/2, hi);
    swap(a, lo, m);
    int j = partition(a, lo, hi);
    sort(a, lo, j-1);
    sort(a, j+1, hi);
}
```

### Selection

*Goal*. Given an array of *N* items, find a `kth` smallest item.  
Ex. Min (`k = 0`), max (`k = N - 1`), median (`k = N / 2`).

*Applications*.
- Order statistics.
- Find the "top k."

#### Quickselect

[Quickselect](https://en.wikipedia.org/wiki/Quickselect) is a selection algorithm to find the `kth` smallest element in an unordered list. It is related to the quicksort algorithm.

- Partition array so that:
  - Entry `a[j]` is in place.
  - No larger entry to the left of `j`.
  - No smaller entry to the right of `j`.
- Repeat in one subarray, depending on `j`; finished when `j` equals `k`.

```java
public static Comparable select(Comparable[] a, int k)
{
    StdRandom.shuffle(a);
    int lo = 0, hi = a.length - 1;
    while (hi > lo)
    {
        int j = partition(a, lo, hi);
        if (j < k) lo = j + 1;
        else if (j > k) hi = j - 1;
        else return a[k];
    }
    return a[k];
}
```

*Proposition*. Quick-select takes **linear** time on average.

### Duplicate keys

Often, purpose of sort is to bring items with equal keys together.
- Sort population by age.
- Remove duplicates from mailing list.
- Sort job applicants by college attended.

Typical characteristics of such applications.
- Huge array.
- Small number of key values.

#### Quicksort with 3-way partitioning

One straightforward idea is to partition the array into three parts, one each for items with keys smaller than, equal to, and larger than the partitioning item’s key. 

It was a classical programming exercise popularized by E. W. Dijkstra as the [Dutch National Flag](https://users.monash.edu/~lloyd/tildeAlgDS/Sort/Flag/) problem, because it is like sorting an array with three possible key values, which might correspond to the three colors on the flag.

**Dijkstra 3-way partitioning**

- Let v be partitioning item `a[lo]`.
- Scan `i` from left to right.
  - `(a[i] < v)`: exchange `a[lt]` with `a[i]`; increment both `lt` and `i`
  - `(a[i] > v)`: exchange `a[gt]` with `a[i]`; decrement `gt`
  - `(a[i] == v)`: increment `i`

*Java implementation*:

```java
public class Quick3way
{
    private static void sort(Comparable[] a, int lo, int hi)
    {
        if (hi <= lo) return;
        int lt = lo, i = lo+1, gt = hi;
        Comparable v = a[lo];
        while (i <= gt)
        {
            int cmp = a[i].compareTo(v);
            if (cmp < 0) exch(a, lt++, i++);
            else if (cmp > 0) exch(a, i, gt--);
            else i++;
        } // Now a[lo..lt-1] < v = a[lt..gt] < a[gt+1..hi].
        sort(a, lo, lt - 1);
        sort(a, gt + 1, hi);
    }
}
```

**Proposition**. [Sedgewick-Bentley, 1997] Quicksort with 3-way partitioning is **entropy-optimal**.

Randomized quicksort with 3-way partitioning reduces running time from *linearithmic* to *linear* in broad class of applications.

### Sorting applications

Sorting algorithms are essential in a broad variety of applications:
- obvious applications:
  - Sort a list of names.
  - Organize an MP3 library.
  - Display Google PageRank results.
  - List RSS feed in reverse chronological order.
- problems become easy once items are in sorted order:
  - Find the median.
  - Identify statistical outliers.
  - Binary search in a database.
  - Find duplicates in a mailing list.
- non-obvious applications:
  - Data compression.
  - Computer graphics.
  - Computational biology.
  - Load balancing on a parallel computer.

### Java system sorts

***Arrays.sort()***
- Has different method for each primitive type.
- Has a method for data types that implement Comparable.
- Has a method that uses a Comparator.
- Uses tuned quicksort for primitive types; tuned mergesort for objects.
  - Why? read [discussion on stackoverflow](https://stackoverflow.com/questions/3707190/why-does-javas-arrays-sort-method-use-two-different-sorting-algorithms-for-diff).

**Engineering a system sort**

Basic algorithm = quicksort.
- Cutoff to insertion sort for small subarrays.
- Partitioning scheme: Bentley-McIlroy 3-way partitioning.
- Partitioning item.
  - small arrays: middle entry
  - medium arrays: median of 3
  - large arrays: Tukey's ninther

**Tukey's ninther**. (Better partitioning than random shuffle and less costly.)

Median of the median of 3 samples, each of 3 entries.
- Approximates the median of 9.
- Uses at most 12 compares.


## Priority Queues

Many applications require that we process items having keys in order, but not necessarily in full sorted order and not necessarily all at once. Often, we collect a set of items, then process the one with the largest key, then perhaps collect more items, then process the one with the current largest key, and so forth.

An appropriate data type in such an environment supports two operations: **remove the maximum** and **insert**. Such a data type is called a priority queue. Using priority queues is similar to using queues (remove the oldest) and stacks (remove the newest), but implementing them efficiently is more challenging.

*Collections*. Insert and delete items. Which item to delete?
- Stack. Remove the item most recently added.
- Queue. Remove the item least recently added.
- Randomized queue. Remove a random item.
- **Priority queue**. Remove the *largest* (or *smallest*) item.

### Priority queue API

| `public class MaxPQ<Key extends Comparable<Key>>` | Key must be Comparable (bounded type parameter) | 
| :--: | :--: | 
| `MaxPQ()` | create an empty priority queue | 
| `MaxPQ(Key[] a)` | create a priority queue with given keys | 
| `Key delMax()` | return and remove the largest key | 
| `boolean isEmpty()` | is the priority queue empty? | 
| `Key max()` | return the largest key | 
| `int size()` | number of entries in the priority queue | 

### Priority queue applications

- Event-driven simulation. [customers in a line, colliding particles]
- Numerical computation. [reducing roundoff error]
- Data compression. [Huffman codes]
- Graph searching. [Dijkstra's algorithm, Prim's algorithm]
- Number theory. [sum of powers]
- Artificial intelligence. [A* search]
- Statistics. [maintain largest M values in a sequence]
- Operating systems. [load balancing, interrupt handling]
- Discrete optimization. [bin packing, scheduling]
- Spam filtering. [Bayesian spam filter]

### Priority queue client example

*Challenge*. Find the largest `M` items in a stream of `N` items.
- Fraud detection: isolate $$ transactions.
- File maintenance: find biggest files or directories.

*Constraint*. Not enough memory to store `N` items.

Use a min-oriented pq. transaction data type is *Comparable* (ordered by `$$`)

```java
MinPQ<Transaction> pq = new MinPQ<Transaction>();
while (StdIn.hasNextLine())
{
    String line = StdIn.readLine();
    Transaction item = new Transaction(line);
    pq.insert(item);
    if (pq.size() > M)
        pq.delMin();
}
```

*Challenge*. Find the largest `M` items in a stream of `N` items.

Order of growth of finding the largest M in a stream of N items:

| implementation | time | space | 
| :--: | :--: | :--: | 
| sort | N log N | N | 
| elementary PQ | M N | M | 
| binary heap | N log M | M | 
| best in theory | N | M | 

### Priority queue: unordered array implementation

```java
public class UnorderedMaxPQ<Key extends Comparable<Key>>
{
    private Key[] pq;   // pq[i] = ith element on pq
    private int N;      // number of elements on pq

    public UnorderedMaxPQ(int capacity)
    { pq = (Key[]) new Comparable[capacity]; }

    public boolean isEmpty()
    { return N == 0; }

    public void insert(Key x)
    { pq[N++] = x; }

    public Key delMax()
    {
        int max = 0;
        for (int i = 1; i < N; i++)
            if (less(max, i)) max = i;
        exch(max, N-1);
        return pq[--N];
    }
}
```

*Challenge*. Implement *all* operations efficiently.

Order of growth of running time for priority queue with N items:

| implementation | insert | del max | max |  
| :--: | :--: | :--: | :--: | 
| unordered array | 1 | N | N | 
| ordered array | N | 1 | 1 | 
| goal | log N | log N | log N | 

### Binary heaps

*Binary tree*. Empty or node with links to left and right binary trees.  
*Complete tree*. Perfectly balanced, except for bottom level.  
*Property*. Height of complete tree with `N` nodes is `floor(log N)`.

#### Binary heap representations

*Binary heap*. Array representation of a heap-ordered complete binary tree.

*Heap-ordered binary tree*.
- Keys in nodes.
- Parent's key no smaller than children's keys.

**Array representation**.
- Indices start at `1`.
- Take nodes in *level* order.
- No explicit links needed!

*Proposition*. 

- Largest key is `a[1]`, which is root of binary tree.
- Can use array indices to move through tree.
  - Parent of node at `k` is at `k/2`.
  - Children of node at `k` are at `2k` and `2k+1`.

##### Promotion in a heap

*Scenario*. Child's key becomes *larger* key than its parent's key.

To eliminate the violation:
- Exchange key in child with key in parent.
- Repeat until heap order restored.

```java
private void swim(int k)
{
    while (k > 1 && less(k/2, k))
    {
        exch(k, k/2);
        k = k/2;
    }
}
```

[Peter principle](https://www.investopedia.com/terms/p/peter-principle.asp). Node promoted to level of incompetence.

##### Insertion in a heap

***Insert***. Add node at end, then swim it up.  
*Cost*. At most `1 + log N` compares.

```java
public void insert(Key x)
{
    pq[++N] = x;
    swim(N);
}
```

##### Demotion in a heap

*Scenario*. Parent's key becomes *smaller* than one (or both) of its children's.

To eliminate the violation:
- Exchange key in parent with key in larger child.
- Repeat until heap order restored.

```java
private void sink(int k)
{
    while (2*k <= N)
    {
        int j = 2*k;
        if (j < N && less(j, j+1)) j++;
        if (!less(k, j)) break;
        exch(k, j);
        k = j;
    }
}
```

Power struggle. Better subordinate promoted.

##### Delete the maximum in a heap

***Delete max***. Exchange root with node at end, then sink it down.  
*Cost*. At most `2 lg N` compares.

```java
public Key delMax()
{
    Key max = pq[1];    // Retrieve max key from top.
    exch(1, N--);       // Exchange with last item.
    pq[N+1] = null;     // Avoid loitering.
    sink(1);            // Restore heap property.
    return max;
}
```

#### Binary heap: Java implementation

ALGORITHM 2.6 Heap priority queue

```java
public class MaxPQ<Key extends Comparable<Key>>
{
    private Key[] pq;           // heap-ordered complete binary tree
    private int N = 0;          // in pq[1..N] with pq[0] unused

    public MaxPQ(int capacity)  // fixed capacity (for simplicity)
    { pq = (Key[]) new Comparable[capacity+1]; }

    public int size() { return N; }

    // PQ ops
    public boolean isEmpty() { return N == 0; }
    public void insert(Key v)           // see previous code
    public Key delMax()                 // see previous code

    // heap helper functions
    private void swim(int k)            // see previous code
    private void sink(int k)            // see previous code

    // array helper functions
    private boolean less(int i, int j)  // see Comparator
    private void exch(int i, int j)     // see Comparator
}
```

### Priority queues implementation cost summary

Order of growth of running time for priority queue with N items:

| implementation | insert | del max | max |  
| :--: | :--: | :--: | :--: | 
| unordered array | 1 | N | N | 
| ordered array | N | 1 | 1 | 
| binary heap | log N | log N | 1 | 
| d-ary heap | log<sub>d</sub> N | d log<sub>d</sub> N | 1 | 
| Fibonacci | 1 | log N † | 1 | 
| impossible | 1 | 1 | 1 | 

† amortized

*NOTE*: The [*d-ary heap*](https://en.wikipedia.org/wiki/D-ary_heap) or *d-heap* is a priority queue data structure, a generalization of the binary heap in which the nodes have `d` children instead of `2`.

### Immutability

Immutability of keys.
- Assumption: client does not change keys while they're on the PQ.
- Best practice: use immutable keys.

Data type. Set of values and operations on those values.  
**Immutable data type**. Can't change the data type value once created.

```java
public final class Vector { // final, can't override instance methods
    // all instance variables private and final
    private final int N;
    private final double[] data;

    public Vector(double[] data) {
        this.N = data.length;

        // defensive copy of mutable instance variables
        this.data = new double[N];
        for (int i = 0; i < N; i++)
            this.data[i] = data[i];
    }

    // instance methods don't change instance variables
    ...
}
```

*Immutable*. String, Integer, Double, Color, Vector, Transaction, Point2D.  
*Mutable*. StringBuilder, Stack, Counter, Java array.

**Advantages**.
- Simplifies debugging.
- Safer in presence of hostile code.
- Simplifies concurrent programming.
- Safe to use as key in priority queue or symbol table.

**Disadvantage**. Must create new object for each data type value.

## Heapsort


[<img src="res/Sorting_heapsort_anim.gif" alt="Heapsort animation" width="280">](https://en.wikipedia.org/wiki/Heapsort "Wikipedia: Heapsort")

*via* [Wikipedia: Heapsort](https://en.wikipedia.org/wiki/Heapsort)


We can use any priority queue to develop a sorting method. 

We insert all the items to be sorted into a minimum-oriented priority queue, then repeatedly use remove the minimum to remove them all in order. 

- Using a priority queue represented as an unordered array in this way corresponds to doing a *selection sort*; 
- Using an ordered array corresponds to doing an *insertion sort*. 
- Using the *heap* can develop a classic elegant sorting algorithm known as **heapsort**.


Basic plan for in-place sort.
- Create max-heap with all N keys.
- Repeatedly remove the maximum key.

Two steps:
- *Heap construction*. Build max heap using bottom-up method.
- *Sortdown*. Repeatedly delete the largest remaining item.
  - Remove the maximum, one at a time.
  - Leave in array, instead of nulling out.

```java
while (N > 1)
{
    exch(a, 1, N--);
    sink(a, 1, N);
}
```

### Heapsort: Java implementation


```java
public class Heap
{
    public static void sort(Comparable[] a)
    {
        int N = a.length;
        for (int k = N/2; k >= 1; k--)
            sink(a, k, N);
        while (N > 1)
        {
            exch(a, 1, N);
            sink(a, 1, --N);
        }
    }
    private static void sink(Comparable[] a, int k, int N)
    { /* as before */ }
    private static boolean less(Comparable[] a, int i, int j)
    { /* as before */ }
    private static void exch(Comparable[] a, int i, int j)
    { /* as before */ }
}
```

### Heapsort: mathematical analysis

*Proposition*. 
- Heap construction uses ≤ *2N* compares and exchanges.
- Heapsort uses ≤ *2 N lg N* compares and exchanges.

*Significance*. In-place sorting algorithm with *N log N* worst-case.
- Mergesort: no, linear extra space.
- Quicksort: no, quadratic time in worst case.
- Heapsort: yes!

*Bottom line*. Heapsort is optimal for both time and space, **but**:
- Inner loop longer than quicksort’s.
- Makes poor use of cache memory.
- Not stable.

### Sorting algorithms: summary

| | inplace? | stable? | worst | average | best | remarks |
| :--: | :--: | :--: | :--: | :--: | :----: | :-----: | 
| selection | x | | N<sup>2</sup> / 2 | N<sup>2</sup> / 2 | N<sup>2</sup> / 2 | N exchanges | 
| insertion | x | x | N<sup>2</sup> / 2 | N<sup>2</sup> / 4 | N | use for small N or partially ordered | 
| shell | x | | ? | ? | N | tight code, subquadratic | 
| quick | x | | N<sup>2</sup> / 2 | 2 N ln N | N lg N | N log N probabilistic guarantee fastest in practice | 
| 3-way quick | x | | N<sup>2</sup> / 2 | 2 N ln N | N | improves quicksort in presence of duplicate keys | 
| merge | | x | N lg N | N lg N | N lg N | N log N guarantee, stable | 
| heap | x | | 2 N lg N | 2 N lg N | N lg N | N log N guarantee, in-place | 
| ??? | x | x | N lg N | N lg N | N lg N | holy sorting grail | 


## Symbol Tables (Searching)

Key-value pair abstraction.
- Insert a value with specified key.
- Given a key, search for the corresponding value.

### Basic symbol table API

| `public class ST<Key, Value>` | | 
| :--: | :--: | 
|  `ST()` | create a symbol table | 
| `void put(Key key, Value val)` | put key-value pair into the table (remove key from table if value is null) | 
| `Value get(Key key)` | value paired with key (null if key is absent) | 
| `void delete(Key key)` | remove key (and its value) from table | 
| `boolean contains(Key key)` | is there a value paired with key? | 
| `boolean isEmpty()` | is the table empty? | 
| `int size()` | number of key-value pairs in the table | 
| `Iterable<Key> keys()` | all the keys in the table | 

*Conventions*
- Values are not null.
- Method `get()` returns null if key not present.
- Method `put()` overwrites old value with new value.

**Keys and values**

*Value type*. Any generic type.

*Key type*: several natural assumptions.
- Assume keys are Comparable, use compareTo().
- Assume keys are any generic type, use equals() to test equality.
- Assume keys are any generic type, use equals() to test equality;
use hashCode() to scramble key.

*Best practices*. Use immutable types for symbol table keys.
- Immutable in Java: Integer, Double, String, java.io.File, …
- Mutable in Java: StringBuilder, java.net.URL, arrays, ...

**Equality test**

Seems easy, but requires some care.

```java
// typically unsafe to use equals() with inheritance (would violate symmetry)
public final class Date implements Comparable<Date>
{
    private final int month;
    private final int day;
    private final int year;
...
    public boolean equals(Object y)     // must be Object.
    {
        if (y == this) return true;     // optimize for true object equality
        if (y == null) return false;    // check for null

        // objects must be in the same class (religion: getClass() vs. instanceof)
        if (y.getClass() != this.getClass())    
            return false;

        Date that = (Date) y;           // cast is guaranteed to succeed

        // check that all significant fields are the same
        if (this.day != that.day ) return false;
        if (this.month != that.month) return false;
        if (this.year != that.year ) return false;
        return true;
    }
}
```

*"Standard" recipe for user-defined types*.
- Optimization for reference equality.
- Check against `null`.
- Check that two objects are of the same type and cast.
- Compare each significant field:
  - if field is a primitive type, use `==`
  - if field is an object, use `equals() `
    - apply rule recursively
  - if field is an array, apply to each entry
    - alternatively, use `Arrays.equals(a, b)` or `Arrays.deepEquals(a, b)`, but not `a.equals(b)`


*Best practices*.
- No need to use calculated fields that depend on other fields.
- Compare fields mostly likely to differ first.
- Make `compareTo()` consistent with `equals()`.
  - `x.equals(y)` if and only if `(x.compareTo(y) == 0)`

Frequency counter implementation

```java
public class FrequencyCounter
{
    public static void main(String[] args)
    {
        int minlen = Integer.parseInt(args[0]);
        ST<String, Integer> st = new ST<String, Integer>();
        while (!StdIn.isEmpty())
        {
            String word = StdIn.readString();
            if (word.length() < minlen) continue;
            if (!st.contains(word)) st.put(word, 1);
            else st.put(word, st.get(word) + 1);
        }
        String max = "";
        st.put(max, 0);
        for (String word : st.keys())
            if (st.get(word) > st.get(max))
                max = word;
        StdOut.println(max + " " + st.get(max));
    }
}
```

### Ordered symbol tables

In typical applications, keys are *Comparable* objects, so the option exists of using the code `a.compareTo(b)` to compare two keys a and b.

Several symbol-table implementations take advantage of order among the keys that is implied by Comparable to provide efficient implementations of the `put()` and `get()` operations. 

More important, in such implementations, we can think of the symbol table as keeping the keys in order and consider a significantly expanded API that defines numerous natural and useful operations involving relative key order.

#### Ordered symbol table API

| `public class ST<Key extends Comparable<Key>, Value>` | | 
| :--: | :--: | 
|  `ST()` | create a symbol table | 
| `void put(Key key, Value val)` | put key-value pair into the table (remove key from table if value is null) | 
| `Value get(Key key)` | value paired with key (null if key is absent) | 
| `void delete(Key key)` | remove key (and its value) from table | 
| `boolean contains(Key key)` | is there a value paired with key? | 
| `boolean isEmpty()` | is the table empty? | 
| `int size()` | number of key-value pairs in the table | 
| `Key min()` | smallest key |
| `Key max()` | largest key |
| `Key floor(Key key)` | largest key less than or equal to key |
| `Key ceiling(Key key)` | smallest key greater than or equal to key |
| `int rank(Key key)` | number of keys less than key |
| `Key select(int k)` | key of rank `k` |
| `void deleteMin()` | delete smallest key |
| `void deleteMax()` | delete largest key |
| `int size(Key lo, Key hi)` | number of keys in `[lo..hi]` |
| `Iterable<Key> keys(Key lo, Key hi)` | keys in `[lo..hi]`, in sorted order |
| `Iterable<Key> keys()` | all the keys in the table | 

#### Binary search: ordered symbol table operations summary

Order of growth of the running time for ordered symbol table operations

| | sequential search | binary search | 
| :--: | :--: | :--: | 
| search | N | lg N | 
| insert / delete | N | N | 
| min / max | N | 1 | 
| floor / ceiling | N | lg N | 
| rank | N | lg N | 
| select | N | 1 | 
| ordered iteration | N lg N | N | 

## Binary search trees

Definition. A BST is a binary tree in symmetric order.

A binary tree is either:
- Empty.
- Two disjoint binary trees (left and right).

Symmetric order. Each node has a key, and every node’s key is:
- Larger than all keys in its left subtree.
- Smaller than all keys in its right subtree.
 

Java definition. A BST is a reference to a root Node.
A Node is comprised of four fields:
- A Key and a Value.
- A reference to the left (smaller keys) and right (larger keys) subtree.

```java
// Key and Value are generic types; Key is Comparable
private class Node
{
    private Key key;
    private Value val;
    private Node left, right;
    public Node(Key key, Value val)
    {
        this.key = key;
        this.val = val;
    }
}
```

### BST implementation

```java
public class BST<Key extends Comparable<Key>, Value>
{
    private Node root;
    private class Node
    { /* see previous slide */ }
    public void put(Key key, Value val)
    { /* see next slides */ }
    public Value get(Key key)
    { /* see next slides */ }
    public void delete(Key key)
    { /* see next slides */ }
    public Iterable<Key> iterator()
    { /* see next slides */ }
}
```

**Search**. If less, go left; if greater, go right; if equal, search hit.  
*Cost*. Number of compares is equal to 1 + depth of node.

```java
public Value get(Key key)
{
    Node x = root;
    while (x != null)
    {
        int cmp = key.compareTo(x.key);
        if (cmp < 0) x = x.left;
        else if (cmp > 0) x = x.right;
        else if (cmp == 0) return x.val;
    }
    return null;
}
```

**Insert**. If less, go left; if greater, go right; if null, insert.  
*Cost*. Number of compares is equal to 1 + depth of node.

```java
public void put(Key key, Value val)
{ root = put(root, key, val); }

private Node put(Node x, Key key, Value val)
{
    if (x == null) return new Node(key, val);
    int cmp = key.compareTo(x.key);
    if (cmp < 0)
        x.left = put(x.left, key, val);
    else if (cmp > 0)
        x.right = put(x.right, key, val);
    else if (cmp == 0)
        x.val = val;
    return x;
}
```

**Proposition**. If N distinct keys are inserted into a BST in random order, the expected number of compares for a search/insert is ~ *2 ln N*.  
Pf. 1-1 correspondence with quicksort partitioning.

Proposition. [Reed, 2003] If N distinct keys are inserted in random order, expected height of tree is ~ *4.311 ln N*.

Worst-case height is *N*. (exponentially small chance when keys are inserted in random order)


### Ordered operations

#### Minimum and maximum

*Minimum*. Smallest key in table.  
*Maximum*. Largest key in table.

How to find `min` / `max`?
- If the left link of the root is null, the smallest key in a BST is the key at the root;   
- if the left link is not null, the smallest key in the BST is the smallest key in the subtree rooted at the node referenced by the left link. 

This statement is both a description of a **recursive** `min()` method and an *inductive* proof that it finds the smallest key in the BST.


```java
public Key min()
{
    return min(root).key;
}

private Node min(Node x)
{
    if (x.left == null) return x;
    return min(x.left);
}
```


#### Floor and ceiling

*Floor*. Largest key ≤ a given key.  
*Ceiling*. Smallest key ≥ a given key.

How to find `floor` / `ceiling`?
- If a given key key is less than the key at the root of a BST, then the floor of key (the largest key in the BST less than or equal to key) must be in the left subtree. 
- If key is greater than the key at the root, then the floor of key could be in the right subtree, but only if there is a key smaller than or equal to key in the right subtree; 
- if not (or if key is equal to the key at the root), then the key at the root is the floor of key.


```java
public Key floor(Key key)
{
    Node x = floor(root, key);
    if (x == null) return null;
    return x.key;
}

private Node floor(Node x, Key key)
{
    if (x == null) return null;

    int cmp = key.compareTo(x.key);

    if (cmp == 0) return x;
    if (cmp < 0) return floor(x.left, key);

    Node t = floor(x.right, key);
    if (t != null) return t;
    else return x;
}
```

#### Selection

Return Node containing key of rank k.

Suppose that we seek the key of rank `k` (the key such that precisely `k` other keys in the BST are smaller). 
- If the number of keys `t` in the left subtree is larger than `k`, we look (recursively) for the key of rank `k` in the left subtree; 
- if `t` is equal to `k`, we return the key at the root; and if `t` is smaller than `k`, we look (recursively) for the key of rank `k - t - 1` in the right subtree.


```java
public Key select(int k)
{
    return select(root, k).key;
}

private Node select(Node x, int k)
{ // Return Node containing key of rank k.
    if (x == null) return null;
    int t = size(x.left);
    if (t > k) return select(x.left, k);
    else if (t < k) return select(x.right, k-t-1);
    else return x;
}
```

**BST implementation: subtree counts**

In each node, we store the number of nodes in the subtree rooted at that node; to implement `size()`, return the count at the root.

```java
private class Node
{
    private Key key;
    private Value val;
    private Node left;
    private Node right;
    private int count;  // number of nodes in subtree
}

public int size()
{ return size(root); }

private int size(Node x)
{
    if (x == null) return 0;
    return x.count;
}

private Node put(Node x, Key key, Value val)
{
    if (x == null) return new Node(key, val, 1);
    int cmp = key.compareTo(x.key);
    if (cmp < 0) x.left = put(x.left, key, val);
    else if (cmp > 0) x.right = put(x.right, key, val);
    else if (cmp == 0) x.val = val;
    x.count = 1 + size(x.left) + size(x.right);
    return x;
}
```


#### Rank

How many keys < `k`?

The inverse method `rank()` that returns the rank of a given key is similar: 
- if the given key is equal to the key at the root, we return the number of keys `t` in the left subtree; 
- if the given key is less than the key at the root, we return the rank of the key in the left subtree (recursively computed); 
- and if the given key is larger than the key at the root, we return `t` plus one (to count the key at the root) plus the rank of the key in the right subtree (recursively computed).


```java
public int rank(Key key)
{ return rank(key, root); }

private int rank(Key key, Node x)
{ // Return number of keys less than x.key in the subtree rooted at x.
    if (x == null) return 0;
    int cmp = key.compareTo(x.key);
    if (cmp < 0) return rank(key, x.left);
    else if (cmp > 0) return 1 + size(x.left) + rank(key, x.right);
    else return size(x.left);
}
```

#### Inorder traversal

Inorder traversal of a BST yields keys in ascending order.

- Traverse left subtree.
- Enqueue key.
- Traverse right subtree.

```java
public Iterable<Key> keys()
{
    Queue<Key> q = new Queue<Key>();
    inorder(root, q);
    return q;
}
private void inorder(Node x, Queue<Key> q)
{
    if (x == null) return;
    inorder(x.left, q);
    q.enqueue(x.key);
    inorder(x.right, q);
}
```

#### BST: ordered symbol table operations summary

Order of growth of the running time for ordered symbol table operations

| | sequential search | binary search | BST |
| :--: | :--: | :--: | :--: | 
| search | N | lg N | h |
| insert / delete | N | N | h |
| min / max | N | 1 | h |
| floor / ceiling | N | lg N | h |
| rank | N | lg N | h |
| select | N | 1 | h |
| ordered iteration | N lg N | N | N | 

NOTE: h = height of BST (proportional to log N if keys inserted in random order)



#### Deletion

We can proceed in a similar manner to delete any node that has one child (or no children), but what can we do to delete a node that has two children? We are left with two links, but have a place in the parent node for only one of them. 

An answer to this dilemma, first proposed by T. Hibbard in 1962, is to delete a node `x` by replacing it with its successor. Because `x` has a right child, its successor is the node with the smallest key in its right subtree. 

The replacement preserves order in the tree because there are no keys between `x.key` and the successor’s key. 

We can accomplish the task of replacing `x` by its successor in four (!) easy steps: 
- Save a link to the node to be deleted in `t`. 
- Set `x` to point to its successor `min(t.right)`. 
- Set the right link of `x` (which is supposed to point to the BST containing all the keys larger than `x.key`) to `deleteMin(t.right)`, the link to the BST containing all the keys that are larger than `x.key` after the deletion. 
- Set the left link of `x` (which was null) to `t.left` (all the keys that are less than both the deleted key and its successor).

Unsatisfactory solution. Not symmetric.

*Hibbard deletion in BSTs: Java implementation*

```java
public void deleteMin()
{
    root = deleteMin(root);
}

private Node deleteMin(Node x)
{
    if (x.left == null) return x.right;
    x.left = deleteMin(x.left);
    x.N = size(x.left) + size(x.right) + 1;
    return x;
}

public void delete(Key key)
{ root = delete(root, key); }

private Node delete(Node x, Key key)
{
    if (x == null) return null;
    int cmp = key.compareTo(x.key);
    if (cmp < 0) x.left = delete(x.left, key);
    else if (cmp > 0) x.right = delete(x.right, key);
    else
    {
        if (x.right == null) return x.left;
        if (x.left == null) return x.right;
        Node t = x;
        x = min(t.right);
        x.right = deleteMin(t.right);
        x.left = t.left;
    }
    x.N = size(x.left) + size(x.right) + 1;
    return x;
}
```

### ST implementations: summary


| implementation | search (guarantee) | insert (guarantee) | delete (guarantee) | search hit (average case) | insert (average case) | delete (average case) | ordered ops? | operations on keys |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | 
| sequential search (unordered list) | N | N | N | N/2 | N | N/2 | no | equals() | 
| binary search (ordered array) | lg N | N | N | lg N | N/2 | N/2 | yes | compareTo() | 
| BST | N | N | N | 1.39 lg N | 1.39 lg N | √N | yes | compareTo() | 


