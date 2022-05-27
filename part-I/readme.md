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

Quicksort honored as one of top 10 algorithms of 20th century in science and engineering.

- Java sort for primitive types.
- C qsort, Unix, Visual C++, Python, Matlab, Chrome JavaScript, ...

**Basic plan**.
- *Shuffle* the array.
- *Partition* so that, for some `j`
  - entry `a[j]` is in place
  - no larger entry to the left of `j`
  - no smaller entry to the right of `j`
- *Sort* each piece recursively.


**Repeat until `i` and `j` pointers cross**.
- Scan `i` from left to right so long as (`a[i]` < `a[lo]`).
- Scan `j` from right to left so long as (`a[j] > a[lo]`).
- Exchange `a[i]` with `a[j]`.

**When pointers cross**.
- Exchange `a[lo]` with `a[j]`.


