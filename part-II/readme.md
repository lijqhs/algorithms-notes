# Notes of Algorithms, Part II <!-- omit in toc -->

> "In the practice of computing, where we have so much latitude for making a mess of it, mathematical elegance is not a dispensable luxury, but a matter of life and death." — Edsger W. Dijkstra

Notes are taken from the course [Algorithms, Part II](https://www.coursera.org/learn/algorithms-part2) by Robert Sedgewick and Kevin Wayne. The notes are for tracking learning progress and easy reference. Section numbers are used to distinguish different parts of the content, not the original chapter numbers.


- [1. Undirected Graph](#1-undirected-graph)
  - [1.1. Introduction](#11-introduction)
    - [1.1.1. Graph applications](#111-graph-applications)
    - [1.1.2. Some graph-processing problems](#112-some-graph-processing-problems)
    - [1.1.3. Graph terminology](#113-graph-terminology)
  - [1.2. Graph API](#12-graph-api)
  - [1.3. Depth-first search](#13-depth-first-search)
  - [1.4. Breadth-first search](#14-breadth-first-search)
  - [1.5. Connected components](#15-connected-components)
  - [1.6. Cycle detection](#16-cycle-detection)
  - [1.7. Two-colorability](#17-two-colorability)
  - [1.8. Symbol graphs](#18-symbol-graphs)
  - [1.9. Challenges](#19-challenges)
- [2. Directed Graph](#2-directed-graph)
  - [2.1. Introduction](#21-introduction)
    - [2.1.1. Definition](#211-definition)
    - [2.1.2. Digraph applications](#212-digraph-applications)
    - [2.1.3. Some digraph problems](#213-some-digraph-problems)
  - [2.2. Digraph API](#22-digraph-api)
    - [2.2.1. Adjacency-lists digraph representation](#221-adjacency-lists-digraph-representation)
  - [2.3. Digraph search](#23-digraph-search)
    - [2.3.1. Reachability in digraphs](#231-reachability-in-digraphs)
    - [2.3.2. Finding paths in digraphs](#232-finding-paths-in-digraphs)
    - [2.3.3. Depth-first search in digraphs](#233-depth-first-search-in-digraphs)
      - [2.3.3.1. Mark-and-sweep garbage collection](#2331-mark-and-sweep-garbage-collection)
    - [2.3.4. Breadth-first search in digraphs](#234-breadth-first-search-in-digraphs)
      - [2.3.4.1. Breadth-first search in digraphs application: web crawler](#2341-breadth-first-search-in-digraphs-application-web-crawler)
  - [2.4. Topological sort](#24-topological-sort)
    - [2.4.1. Typical topological-sort applications](#241-typical-topological-sort-applications)
    - [2.4.2. DAG (directed acyclic graph)](#242-dag-directed-acyclic-graph)
  - [2.5. Strongly-connected components](#25-strongly-connected-components)
    - [2.5.1. Strong component application](#251-strong-component-application)
    - [2.5.2. API for strong components](#252-api-for-strong-components)
    - [2.5.3. Kosaraju’s algorithm](#253-kosarajus-algorithm)
- [3. Minimum spanning trees](#3-minimum-spanning-trees)
  - [3.1. Greedy algorithm](#31-greedy-algorithm)
  - [3.2. Edge-weighted graph API](#32-edge-weighted-graph-api)
    - [3.2.1. Edge-weighted graph: adjacency-lists representation](#321-edge-weighted-graph-adjacency-lists-representation)
  - [3.3. Minimum spanning tree API](#33-minimum-spanning-tree-api)
  - [3.4. Kruskal's algorithm](#34-kruskals-algorithm)
  - [3.5. Prim's algorithm](#35-prims-algorithm)
    - [3.5.1. Prim's algorithm: lazy implementation](#351-prims-algorithm-lazy-implementation)
    - [3.5.2. Indexed priority queue](#352-indexed-priority-queue)
    - [3.5.3. Prim's algorithm: eager implementation](#353-prims-algorithm-eager-implementation)
    - [3.5.4. Prim's algorithm: running time](#354-prims-algorithm-running-time)
  - [3.6. context](#36-context)
    - [3.6.1. Euclidean MST](#361-euclidean-mst)
    - [3.6.2. Scientific application: clustering](#362-scientific-application-clustering)
      - [3.6.2.1. Single-link clustering](#3621-single-link-clustering)
- [4. Shortest Paths](#4-shortest-paths)
  - [4.1. Shortest path variants](#41-shortest-path-variants)
  - [4.2. Weighted directed edge API](#42-weighted-directed-edge-api)
    - [4.2.1. Edge-weighted digraph: adjacency-lists implementation in Java](#421-edge-weighted-digraph-adjacency-lists-implementation-in-java)
    - [4.2.2. Single-source shortest paths API](#422-single-source-shortest-paths-api)
  - [4.3. Shortest-paths properties](#43-shortest-paths-properties)
    - [4.3.1. Data structures for single-source shortest paths](#431-data-structures-for-single-source-shortest-paths)
    - [4.3.2. Edge relaxation](#432-edge-relaxation)
    - [4.3.3. Shortest-paths optimality conditions](#433-shortest-paths-optimality-conditions)
  - [4.4. Generic shortest-paths algorithm](#44-generic-shortest-paths-algorithm)
  - [4.5. Dijkstra's algorithm](#45-dijkstras-algorithm)
    - [4.5.1. Dijkstra’s algorithm variants](#451-dijkstras-algorithm-variants)
  - [4.6. Edge-weighted DAGs (acyclic edge-weighted digraph)](#46-edge-weighted-dags-acyclic-edge-weighted-digraph)
    - [4.6.1. Application: content-aware resizing](#461-application-content-aware-resizing)
    - [4.6.2. Longest paths in edge-weighted DAGs](#462-longest-paths-in-edge-weighted-dags)
    - [4.6.3. Longest paths in edge-weighted DAGs: application](#463-longest-paths-in-edge-weighted-dags-application)
      - [4.6.3.1. Parallel job scheduling](#4631-parallel-job-scheduling)
  - [4.7. Negative weights](#47-negative-weights)
    - [4.7.1. Bellman-Ford algorithm](#471-bellman-ford-algorithm)
    - [4.7.2. Finding a negative cycle](#472-finding-a-negative-cycle)
    - [4.7.3. Negative cycle application: arbitrage detection](#473-negative-cycle-application-arbitrage-detection)
  - [4.8. Single source shortest-paths implementation: summary](#48-single-source-shortest-paths-implementation-summary)
- [5. Maximum Flow and Minimum Cut](#5-maximum-flow-and-minimum-cut)
  - [Mincut problem](#mincut-problem)
  - [Maxflow problem](#maxflow-problem)
  - [Ford-Fulkerson algorithm](#ford-fulkerson-algorithm)
  - [Maxflow-mincut theorem](#maxflow-mincut-theorem)
    - [Computing a mincut from a maxflow](#computing-a-mincut-from-a-maxflow)
    - [Ford-Fulkerson algorithm with integer capacities](#ford-fulkerson-algorithm-with-integer-capacities)
    - [How to choose augmenting paths?](#how-to-choose-augmenting-paths)
  - [Ford-Fulkerson: Java implementation](#ford-fulkerson-java-implementation)
  - [Maxflow and mincut applications](#maxflow-and-mincut-applications)
- [6. Radix Sorts](#6-radix-sorts)


## 1. Undirected Graph

### 1.1. Introduction

Graph: Set of vertices connected pairwise by edges.

Importance of graph algorithms:
- Thousands of practical applications
- Hundreds of graph algorithms known
- Interesting and broadly useful abstraction
- Challenging branch of computer science and discrete math

Examples of graph applications:

- [The Internet as mapped by the Opte Project](https://www.opte.org/the-internet)

[![The Internet 1997 - 2021](https://img.youtube.com/vi/OzDgI0sJQBA/0.jpg)](https://www.youtube.com/watch?v=OzDgI0sJQBA "The Internet 1997 - 2021 Youtube Video")

- [Map of science clickstreams](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0004803)

![Map of science clickstreams](res/pone.0004803.g005.png)

#### 1.1.1. Graph applications

| graph | vertex | edge |
| :---: | :----: | :---: |
| communication | telephone, computer | fiber optic cable |
| circuit | gate, register, processor | wire |
| mechanical | joint | rod, beam, spring |
| financial | stock, currency | transactions |
| transportation | street intersection, airport | highway, airway route |
| internet | class C network | connection |
| game | board position | legal move |
| social relationship | person, actor | friendship, movie cast |
| neural network | neuron | synapse |
| protein network | protein | protein-protein interaction |
| molecule | atom | bond |


#### 1.1.2. Some graph-processing problems

- **Path**. Is there a path between s and t ?
- **Shortest path**. What is the shortest path between s and t ?
- **Cycle**. Is there a cycle in the graph?
- **Euler tour**. Is there a cycle that uses each edge exactly once?
- **Hamilton tour**. Is there a cycle that uses each vertex exactly once.
- **Connectivity**. Is there a way to connect all of the vertices?
- **MST**. What is the best way to connect all of the vertices?
- **Biconnectivity**. Is there a vertex whose removal disconnects the graph?
- **Planarity**. Can you draw the graph in the plane with no crossing edges
- **Graph isomorphism**. Do two adjacency lists represent the same graph?

#### 1.1.3. Graph terminology

- **Path**. Sequence of vertices connected by edges.
- **Cycle**. Path whose first and last vertices are the same.

Two vertices are connected if there is a path between them.


A ***path*** in a graph is a sequence of vertices connected by edges. A *simple path* is one with no repeated vertices. A ***cycle*** is a path with at least one edge whose first and last vertices are the same. A *simple cycle* is a cycle with no repeated edges or vertices (except the requisite repetition of the first and last vertices). The *length* of a path or a cycle is its number of edges.

A ***graph*** is connected if there is a path from every vertex to every other vertex in the graph. A graph that is *not connected* consists of a set of *connected components*, which are maximal connected subgraphs.

An ***acyclic*** graph is a graph with no cycles.

A *tree* is an acyclic connected graph. A disjoint set of trees is called a *forest*. A *spanning tree* of a connected graph is a subgraph that contains all of that graph’s vertices and is a single tree. A *spanning forest* of a graph is the union of spanning trees of its connected components.

A graph G with V vertices is a tree if and only if it satisfies any of the following five conditions:
- G has `V-1` edges and no cycles.
- G has `V-1` edges and is connected.
- G is connected, but removing any edge disconnects it.
- G is acyclic, but adding any edge creates a cycle.
- Exactly one simple path connects each pair of vertices in G.

A *bipartite graph* is a graph whose vertices we can divide into two sets such that all edges connect a vertex in one set with a vertex in the other set.


### 1.2. Graph API


| `public class Graph` |   |
| :--: | :--: |
| `Graph(int V)` | *create an empty graph with `V` vertices* |
| `Graph(In in)` | *create a graph from input stream* |
| `void addEdge(int v, int w)` | *add an edge `v-w`* |
| `Iterable<Integer> adj(int v)` | *vertices adjacent to `v`* |
| `int V()` | *number of vertices* |
| `int E()` | *number of edges* |
| `String toString()` | *string representation* |

Simple client:

```java
In in = new In(args[0]);    // read graph from input stream
Graph G = new Graph(in);

for (int v = 0; v < G.V(); v++)
    for (int w : G.adj(v))
        StdOut.println(v + "-" + w);    // print out each edge (twice)
```

Typical graph-processing code:

```java
// compute the degree of v
public static int degree(Graph G, int v)
{
    int degree = 0;
    for (int w : G.adj(v)) 
        degree++;
    return degree;
}

// compute maximum degree
public static int maxDegree(Graph G)
{
    int max = 0;
    for (int v = 0; v < G.V(); v++)
        if (degree(G, v) > max)
            max = degree(G, v);
    return max;
}

// compute average degree
public static double averageDegree(Graph G)
{ return 2.0 * G.E() / G.V(); }

// count self-loops
public static int numberOfSelfLoops(Graph G)
{
    int count = 0;
    for (int v = 0; v < G.V(); v++)
        for (int w : G.adj(v))
            if (v == w) count++;
    return count/2; // each edge counted twice
```

**Graph representation**:

- Set-of-edges graph representation: Maintain a list of the edges (linked list or array).
- Adjacency-matrix graph representation: Maintain a two-dimensional `V-by-V` boolean array; `for each edge v–w in graph: adj[v][w] = adj[w][v] = true.`
- **Adjacency-list graph representation**: Maintain vertex-indexed array of lists.

    <img src="res/adjacency-list-graph-representation.png" alt="adjacency-list-graph-representation" width="550"></img>


In practice. Use adjacency-lists representation.
- Algorithms based on iterating over vertices adjacent to `v`.
- Real-world graphs tend to be sparse. (huge number of vertices, small average vertex degree)

| representation | space | add edge | edge between `v` and `w`? | iterate over vertices adjacent to `v`? |
| :--: | :--: | :--: | :--: | :--: |
| list of edges | E | 1 | E | E |
| adjacency matrix | V<sup>2</sup> | 1 | 1 | V |
| adjacency lists | E+V| 1 | degree(v) | degree(v) |

Adjacency-lists representation Java implementation

```java
public class Graph
{
    private final int V;                    // number of vertices
    private int E;                          // number of edges
    private Bag<Integer>[] adj;             // adjacency lists

    public Graph(int V)
    {
        this.V = V; this.E = 0;
        adj = (Bag<Integer>[]) new Bag[V];  // Create array of lists.
        for (int v = 0; v < V; v++)         // Initialize all lists
            adj[v] = new Bag<Integer>();    // to empty.
    }

    public Graph(In in)
    {
        this(in.readInt());                 // Read V and construct this graph.
        int E = in.readInt();               // Read E.
        for (int i = 0; i < E; i++)
        {                                   // Add an edge.
            int v = in.readInt();           // Read a vertex,
            int w = in.readInt();           // read another vertex,
            addEdge(v, w);                  // and add edge connecting them.
        }
    }

    public int V() { return V; }
    public int E() { return E; }
    
    public void addEdge(int v, int w)
    {
        adj[v].add(w);                      // Add w to v’s list.
        adj[w].add(v);                      // Add v to w’s list.
        E++;
    }

    public Iterable<Integer> adj(int v)
    { return adj[v]; }
}
```

### 1.3. Depth-first search

Searching through a graph is equivalent to finding way through a maze. There are many methods in [solving maze problem](https://en.wikipedia.org/wiki/Maze-solving_algorithm). [Trémaux's algorithm](https://en.wikipedia.org/wiki/Maze-solving_algorithm#Tr%C3%A9maux's_algorithm) was discovered in the 19th century, has been used about a hundred years later as [depth-first search](https://en.wikipedia.org/wiki/Depth-first_search).

Use depth-first search to solve problems:
- ***Connectivity***. Given a graph, support queries of the form Are two given vertices connected? and How many connected components does the graph have?  
- ***Single-source paths***. Given a graph and a source vertex `s`, support queries of the
form Is there a path from `s` to a given target vertex `v`? If so, find such a path.

Tremaux exploration is an intuitive starting point, but it differs in subtle ways from exploring a graph, so we now move on to searching in graphs. To search a graph, invoke a recursive method that visits vertices. To visit a vertex:
- Mark it as having been visited.
- Visit (recursively) all the vertices that are adjacent to it and that have not yet been marked.

**Algorithm**
- Use recursion (ball of string).
- Mark each visited vertex (and keep track of edge taken to visit it).
- Return (retrace steps) when no unvisited options.

**Data structures**
- `boolean[]` marked to mark visited vertices.
- `int[] edgeTo` to keep tree of paths. (`edgeTo[w] == v`) means that edge `v-w` taken to visit `w` for first time

Java implementation of *depth-first search* API is as follows. The recursive method marks the given vertex and calls itself for any unmarked vertices on its adjacency list. If the graph is connected, every adjacency-list entry is checked.

```java
public class DepthFirstSearch
{
    private boolean[] marked;
    private int count;

    public DepthFirstSearch(Graph G, int s)
    {
        marked = new boolean[G.V()];
        dfs(G, s);
    }

    private void dfs(Graph G, int v)
    {
        marked[v] = true;
        count++;
        for (int w : G.adj(v))
            if (!marked[w]) dfs(G, w);
    }

    public boolean marked(int w)
    { return marked[w]; }

    public int count()
    { return count; }
}
```

**Design pattern**. Decouple graph data type from graph processing.
- Create a Graph object.
- Pass the Graph to a graph-processing routine.
- Query the graph-processing routine for information.

| `public class Paths` | |
|:--: | :--: |
| `Paths(Graph G, int s)` | *find paths in G from source `s`* |
| `boolean hasPathTo(int v)` | *is there a path from `s` to `v`?* |
| `Iterable<Integer> pathTo(int v)` | *path from `s` to `v`; null if no such path* |

Depth-first search to find paths in a graph (recursive implementation) (ALGORITHM 4.1):

```java
public class DepthFirstPaths
{
    private boolean[] marked;   // Has dfs() been called for this vertex?
    private int[] edgeTo;       // last vertex on known path to this vertex
    private final int s;        // source

    public DepthFirstPaths(Graph G, int s)
    {
        marked = new boolean[G.V()];
        edgeTo = new int[G.V()];
        this.s = s;
        dfs(G, s);
    }

    private void dfs(Graph G, int v)
    {
        marked[v] = true;
        for (int w : G.adj(v))
            if (!marked[w])
            {
                edgeTo[w] = v;
                dfs(G, w);
            }
    }

    public boolean hasPathTo(int v)
    { return marked[v]; }
    
    public Iterable<Integer> pathTo(int v)
    {
        if (!hasPathTo(v)) return null;
        Stack<Integer> path = new Stack<Integer>();
        for (int x = v; x != s; x = edgeTo[x])
            path.push(x);
        path.push(s);
        return path;
    }
}
```

This Graph client uses depth-first search to find paths to all the vertices in a graph that are connected to a given start vertex `s`. To save known paths to each vertex, this code maintains a vertex-indexed array `edgeTo[]` such that `edgeTo[w] = v` means that `v-w` was the edge used to access `w` for the first time. The `edgeTo[]` array is a parent-link representation of a tree rooted at `s` that contains all the vertices connected to `s`.


**Depth-first search properties**:

- **Proposition A**. DFS marks all the vertices connected to a given source in time proportional to the sum of their degrees.
- **Proposition A (continued)**. After DFS, can find vertices connected to `s` in constant time and can find a path to `s` (if one exists) in time proportional to its length.


### 1.4. Breadth-first search

[Breadth-first search](https://en.wikipedia.org/wiki/Breadth-first_search) can be used to solve the following problem:  
**Single-source shortest paths**. Given a graph and a source vertex `s`, support queries of the form *Is there a path from `s` to a given target vertex `v`*? If so, find a *shortest* such path (one with a minimal number of edges).

> Repeat until queue is empty:  
> - Remove vertex `v` from queue.
> - Add to queue all unmarked vertices adjacent to `v` and mark them.

*BFS* and *DFS* differ only in the rule used to take the next vertex from the data structure (least recently added for *BFS*, most recently added for *DFS*). This difference leads to completely different views of the graph, even though all the vertices and edges connected to the source are examined no matter what rule is used.

**Depth-first search**. Put unvisited vertices on a *stack*.  
**Breadth-first search**. Put unvisited vertices on a *queue*.  

Breadth-first search properties:  
- **Proposition B**. For any vertex `v` reachable from `s`, BFS computes a shortest path from `s` to `v` (no path from `s` to `v` has fewer edges).
- **Proposition B (continued)**. BFS takes time proportional to `V + E` in the worst case.

Breadth-first search to find paths in a graph (non-recursive implementation) (ALGORITHM 4.2):

```java
public class BreadthFirstPaths
{
    private boolean[] marked;           // Is a shortest path to this vertex known?
    private int[] edgeTo;               // last vertex on known path to this vertex
    private final int s;                // source

    public BreadthFirstPaths(Graph G, int s)
    {
        marked = new boolean[G.V()];
        edgeTo = new int[G.V()];
        this.s = s;
        bfs(G, s);
    }

    private void bfs(Graph G, int s)
    {
        Queue<Integer> queue = new Queue<Integer>();
        marked[s] = true;               // Mark the source
        queue.enqueue(s);               // and put it on the queue.
        while (!queue.isEmpty())
        {
            int v = queue.dequeue();    // Remove next vertex from the queue.
            for (int w : G.adj(v))
                if (!marked[w])             // For every unmarked adjacent vertex,
                {
                    edgeTo[w] = v;          // save last edge on a shortest path,
                    marked[w] = true;       // mark it because path is known,
                    queue.enqueue(w);       // and add it to the queue.
                }
        }
    }

    public boolean hasPathTo(int v)
    { return marked[v]; }

    public Iterable<Integer> pathTo(int v)
    // Same as for DFS
}
```

Breadth-first search application:
- Routing. Fewest number of hops in a communication network.
- Kevin Bacon numbers
  - Include one vertex for each performer and one for each movie.
  - Connect a movie to all performers that appear in that movie.
  - Compute shortest path from s = Kevin Bacon.
- [Erdös numbers](https://en.wikipedia.org/wiki/Erd%C5%91s_number)

### 1.5. Connected components

**Definitions**:
- Vertices `v` and `w` are connected if there is a path between them.
- A **connected component** is a maximal set of connected vertices.

**Goal**:   
Preprocess graph to answer queries of the form is `v` connected to `w`? in **constant** time.


| public class CC | |
| :--: | :--: |
| `CC(Graph G)` | *preprocessing constructor* |
| `boolean connected(int v, int w)` | *are `v` and `w` connected?* |
| `int count()` | *number of connected components* |
| `int id(int v)` | *component identifier for `v` ( between `0` and `count()-1` )* |

How does the DFS-based solution for graph connectivity in CC compare with the union-find approach of Chapter 1?   
- In theory, DFS is faster than union-find because it provides a constant-time guarantee, which union-find does not.
- In practice, this difference is negligible, and union-find is faster because it does not have to build a full representation of the graph. 
- More important, union-find is an online algorithm (we can check whether two vertices are connected in near-constant time at any point, even while adding edges), whereas the DFS solution must first preprocess the graph. 

Therefore, for example, we prefer union-find when determining connectivity is our only task or when we have a large number of queries intermixed with edge insertions but may find the DFS solution more appropriate for use in a graph ADT because it makes efficient use of existing infrastructure.

Depth-first search to find connected components in a graph (ALGORITHM 4.3):

```java
public class CC
{
    private boolean[] marked;
    private int[] id;
    private int count;

    public CC(Graph G)
    {
        marked = new boolean[G.V()];
        id = new int[G.V()];
        for (int s = 0; s < G.V(); s++)
            if (!marked[s])
            {
                dfs(G, s);
                count++;
            }
    }

    private void dfs(Graph G, int v)
    {
        marked[v] = true;
        id[v] = count;
        for (int w : G.adj(v))
            if (!marked[w])
                dfs(G, w);
    }

    public boolean connected(int v, int w)
    { return id[v] == id[w]; }

    public int id(int v)
    { return id[v]; }

    public int count()
    { return count; }
}
```

**Proposition C**. DFS uses preprocessing time and space proportional to `V + E` to support constant-time connectivity queries in a graph.

### 1.6. Cycle detection 

*Is a given graph acylic?*

```java
public class Cycle
{
    private boolean[] marked;
    private boolean hasCycle;

    public Cycle(Graph G)
    {
        marked = new boolean[G.V()];
        for (int s = 0; s < G.V(); s++)
            if (!marked[s])
                dfs(G, s, s);
    }

    private void dfs(Graph G, int v, int u)
    {
        marked[v] = true;
        for (int w : G.adj(v))
            if (!marked[w])
                dfs(G, w, v);
            else if (w != u) hasCycle = true;
    }

    public boolean hasCycle()
    { return hasCycle; }
}
```

### 1.7. Two-colorability 

*Is the graph bipartite?*

```java
public class TwoColor
{
    private boolean[] marked;
    private boolean[] color;
    private boolean isTwoColorable = true;

    public TwoColor(Graph G)
    {
        marked = new boolean[G.V()];
        color = new boolean[G.V()];
        for (int s = 0; s < G.V(); s++)
            if (!marked[s])
                dfs(G, s);
    }

    private void dfs(Graph G, int v)
    {
        marked[v] = true;
        for (int w : G.adj(v))
            if (!marked[w])
            {
                color[w] = !color[v];
                dfs(G, w);
            }
            else if (color[w] == color[v]) isTwoColorable = false;
    }

    public boolean isBipartite()
    { return isTwoColorable; }
}
```

### 1.8. Symbol graphs

Typical applications involve processing graphs defined in files or on web pages, using strings, not integer indices, to define and refer to vertices. To accommodate such applications, we define an input format with the following properties:
- Vertex names are strings.
- A specified delimiter separates vertex names (to allow for the possibility of spaces in names).
- Each line represents a set of edges, connecting the fi rst vertex name on the line to each of the other vertices named on the line.
- The number of vertices V and the number of edges E are both implicitly defined.

| `public class SymbolGraph` | |
| :--: | :--: |
| `SymbolGraph(String filename, String delim)` | *build graph specified in filename using delim to separate vertex names* |
| `boolean contains(String key)` | *is key a vertex?* |
| `int index(String key)` | *index associated with key* |
| `String name(int v)` | *key associated with index v* |
| `Graph G()` | *underlying Graph* |


<img src="res/symbol-graph-data-structures.png" alt="symbol-graph-data-structures" width="550"></img>

Symbol graph data type

```java
public class SymbolGraph {
    private ST<String, Integer> st;                 // String -> index
    private String[] keys;                          // index -> String
    private Graph G;                                // the graph

    public SymbolGraph(String stream, String sp) {
        st = new ST<String, Integer>();
        In in = new In(stream);                     // First pass
        while (in.hasNextLine())                    // builds the index
        {
            String[] a = in.readLine().split(sp);   // by reading strings
            for (int i = 0; i < a.length; i++)      // to associate each
                if (!st.contains(a[i]))             // distinct string
                    st.put(a[i], st.size());        // with an index.
        }
        keys = new String[st.size()];               // Inverted index
        for (String name : st.keys())               // to get string keys
            keys[st.get(name)] = name;              // is an array.
        G = new Graph(st.size());
        in = new In(stream);                        // Second pass
        while (in.hasNextLine())                    // builds the graph
        {
            String[] a = in.readLine().split(sp);   // by connecting the
            int v = st.get(a[0]);                   // first vertex
            for (int i = 1; i < a.length; i++)      // on each line
                G.addEdge(v, st.get(a[i]));         // to all the others.
        }
    }

    public boolean contains(String s) {
        return st.contains(s);
    }

    public int index(String s) {
        return st.get(s);
    }

    public String name(int v) {
        return keys[v];
    }

    public Graph G() {
        return G;
    }
}
```

### 1.9. Challenges

How difficult?
1. Any programmer could do it.
2. Typical diligent algorithms student could do it.
3. Hire an expert.
4. Intractable.
5. No one knows.
6. Impossible.

Problems
- **Is a graph bipartite**? (*is dating graph bipartite?*) [2]
- **Find a cycle**. (simple DFS-based solution) [2] 
- **Euler tour**. Is there a (general) cycle that uses each edge exactly once? [2]
  - Answer. A connected graph is Eulerian iff all vertices have even degree.
- **Hamiltonian cycle**. Find a cycle that visits every vertex exactly once. *(classical NP-complete problem)* [4]
- **Are two graphs identical except for vertex names**? *graph isomorphism is longstanding open problem* [5]
- **Lay out a graph in the plane without crossing edges**? *linear-time DFS-based planarity algorithm discovered by Tarjan in 1970s (too complicated for most practitioners)* [3]



<br/>
<div align="right">
    <b><a href="#top">↥ back to top</a></b>
</div>
<br/>


## 2. Directed Graph

### 2.1. Introduction

#### 2.1.1. Definition

A directed graph (or digraph) is a set of vertices and a collection of directed edges. Each directed edge connects an ordered pair of vertices.

#### 2.1.2. Digraph applications

| digraph | vertex | directed edge | 
|:--:|:--:|:--:|
| transportation | street intersection | one-way street |
| web | web page | hyperlink |
| food web | species | predator-prey relationship |
| WordNet | synset | hypernym |
| scheduling | task | precedence constraint |
| financial | bank | transaction |
| cell phone | person | placed call |
| infectious disease | person | infection |
| game | board position | legal move |
| citation | journal article | citation |
| object graph | object | pointer |
| inheritance hierarchy | class | inherits from |
| control flow | code block | jump |

#### 2.1.3. Some digraph problems

- **Path**. Is there a directed path from `s` to `t`?
- **Shortest path**. What is the shortest directed path from `s` to `t`?
- **Topological sort**. Can you draw a digraph so that all edges point upwards?
- **Strong connectivity**. Is there a directed path between all pairs of vertices?
- **Transitive closure**. For which vertices v and w is there a path from `v` to `w`?
- **PageRank**. What is the importance of a web page?

### 2.2. Digraph API

| `public class Digraph` | |
|:--:|:--:|
| `Digraph(int V)` | *create an empty digraph with V vertices* |
| `Digraph(In in)` | *create a digraph from input stream* |
| `void addEdge(int v, int w)` | *add a directed edge `v→w`* |
| `Iterable<Integer> adj(int v)` | *vertices pointing from `v`* |
| `int V()` | *number of vertices* |
| `int E()` | *number of edges* |
| `Digraph reverse()` | *reverse of this digraph* |
| `String toString()` | *string representation* |

#### 2.2.1. Adjacency-lists digraph representation

<img src="res/adjacency-lists-digraph-representation.png" alt="Adjacency-lists digraph representation" width="550"></img>

Adjacency-lists digraph representation: Java implementation

```java
public class Digraph {
    private final int V;
    private int E;
    private Bag<Integer>[] adj;

    public Digraph(int V) {
        this.V = V;
        this.E = 0;
        adj = (Bag<Integer>[]) new Bag[V];
        for (int v = 0; v < V; v++)
            adj[v] = new Bag<Integer>();
    }

    public int V() {
        return V;
    }

    public int E() {
        return E;
    }

    public void addEdge(int v, int w) {
        adj[v].add(w);
        E++;
    }

    public Iterable<Integer> adj(int v) {
        return adj[v];
    }

    public Digraph reverse() {
        Digraph R = new Digraph(V);
        for (int v = 0; v < V; v++)
            for (int w : adj(v))
                R.addEdge(w, v);
        return R;
    }
}
```


In practice. Use adjacency-lists representation.
- Algorithms based on iterating over vertices pointing from `v`.
- Real-world graphs tend to be sparse. (huge number of vertices, small average vertex degree)


| representation | space | add edge | edge between `v` and `w`? | iterate over vertices pointing from `v`? |
| :--: | :--: | :--: | :--: | :--: |
| list of edges | E | 1 | E | E |
| adjacency matrix | V<sup>2</sup> | 1 | 1 | V |
| adjacency lists | E+V| 1 | outdegree(v) | outdegree(v) |

### 2.3. Digraph search

#### 2.3.1. Reachability in digraphs

- ***Single-source reachability***. Given a digraph and a source vertex `s`, support queries of the form *Is there a directed path from `s` to a given target vertex `v`*?
- ***Multiple-source reachability***. Given a digraph and a set of source vertices, support queries of the form *Is there a directed path from any vertex in the set to a given target vertex `v`*?

API for reachability in digraphs:

| `public class DirectedDFS` | |
| :--: | :--: |
| `DirectedDFS(Digraph G, int s)` | *find vertices in G that are reachable from `s`* |
| `DirectedDFS(Digraph G, Iterable<Integer> sources)` | *find vertices in G that are reachable from sources* |
| `boolean marked(int v)` | *is `v` reachable?* |


#### 2.3.2. Finding paths in digraphs

*DepthFirstPaths* (Algorithm 4.1) and *BreadthFirstPaths* (Algorithm 4.2) are also fundamentally digraph-processing algorithms. 

Again, the identical APIs and code (with Graph changed to Digraph) effectively solve the following problems: 
- **Single-source directed paths**. Given a digraph and a source vertex `s`, support queries of the form *Is there a directed path from `s` to a given target vertex `v`?* If so, find such a path. 
- **Single-source shortest directed paths**. Given a digraph and a source vertex `s`, support queries of the form *Is there a directed path from `s` to a given target vertex `v`?* If so, find a shortest such path (one with a minimal number of edges).


#### 2.3.3. Depth-first search in digraphs

Same method as for undirected graphs.
- Every undirected graph is a digraph (with edges in both directions).
- DFS is a digraph algorithm.

**Proposition D**. DFS marks all the vertices in a digraph reachable from a given set of sources in time proportional to the sum of the outdegrees of the vertices marked.

```java
public class DirectedDFS {
    private boolean[] marked;

    public DirectedDFS(Digraph G, int s) {
        marked = new boolean[G.V()];
        dfs(G, s);
    }

    public DirectedDFS(Digraph G, Iterable<Integer> sources) {
        marked = new boolean[G.V()];
        for (int s : sources)
            if (!marked[s])
                dfs(G, s);
    }

    private void dfs(Digraph G, int v) {
        marked[v] = true;
        for (int w : G.adj(v))
            if (!marked[w])
                dfs(G, w);
    }

    public boolean marked(int v) {
        return marked[v];
    }

    public static void main(String[] args) {
        Digraph G = new Digraph(new In(args[0]));
        Bag<Integer> sources = new Bag<Integer>();
        for (int i = 1; i < args.length; i++)
            sources.add(Integer.parseInt(args[i]));
        DirectedDFS reachable = new DirectedDFS(G, sources);
        for (int v = 0; v < G.V(); v++)
            if (reachable.marked(v))
                StdOut.print(v + " ");
        StdOut.println();
    }
}
```

##### 2.3.3.1. Mark-and-sweep garbage collection

A mark-and-sweep garbage collection strategy reserves one bit per object for the purpose of garbage collection, then periodically marks the set of potentially accessible objects by running a digraph reachability algorithm like DirectedDFS and sweeps through all objects, collecting the unmarked ones for use for new objects.

#### 2.3.4. Breadth-first search in digraphs

Same method as for undirected graphs.
- Every undirected graph is a digraph (with edges in both directions).
- BFS is a digraph algorithm.

**Proposition**. BFS computes shortest paths (fewest number of edges) from `s` to all other vertices in a digraph in time proportional to `E + V`.

*Multiple-source shortest paths*.  
- Given a digraph and a set of source vertices, find shortest path from any vertex in the set to each other vertex.
  - Use BFS, but initialize by enqueuing all source vertices.

##### 2.3.4.1. Breadth-first search in digraphs application: web crawler

```java
Queue<String> queue = new Queue<String>();
SET<String> marked = new SET<String>();

String root = "http://www.princeton.edu";
queue.enqueue(root);
marked.add(root);

while (!queue.isEmpty())
{
    String v = queue.dequeue();
    StdOut.println(v);
    In in = new In(v);
    String input = in.readAll();

    String regexp = "http://(\\w+\\.)*(\\w+)";
    Pattern pattern = Pattern.compile(regexp);
    Matcher matcher = pattern.matcher(input);
    while (matcher.find())
    {
        String w = matcher.group();
        if (!marked.contains(w))
        {
            marked.add(w);
            queue.enqueue(w);
        }
    }
}
```

### 2.4. Topological sort

**Precedence-constrained scheduling**. Given a set of jobs to be completed, with precedence constraints that specify that certain jobs have to be completed before certain other jobs are begun, how can we schedule the jobs such that they are all completed while still respecting the constraints?

**Goal**. Given a set of tasks to be completed with precedence constraints, in which order should we schedule the tasks?

**Digraph model**. vertex = task; edge = precedence constraint.

**[Topological sort](https://en.wikipedia.org/wiki/Topological_sorting)**. Given a digraph, put the vertices in order such that all its directed edges point from a vertex earlier in the order to a vertex later in the order (or report that doing so is not possible).

#### 2.4.1. Typical topological-sort applications

| application | vertex | edge |
| :--: | :--: | :--: |
| job schedule | job | precedence constraint |
| course schedule | course | prerequisite |
| inheritance | Java class | extends |
| spreadsheet | cell | formula |
| symbolic links | file name | link |

#### 2.4.2. DAG (directed acyclic graph)

Definition. A directed acyclic graph (DAG) is a digraph with no directed cycles.

Finding a directed cycle:

```java
public class DirectedCycle {
    private boolean[] marked;
    private int[] edgeTo;
    private Stack<Integer> cycle; // vertices on a cycle (if one exists)
    private boolean[] onStack; // vertices on recursive call stack

    public DirectedCycle(Digraph G) {
        onStack = new boolean[G.V()];
        edgeTo = new int[G.V()];
        marked = new boolean[G.V()];
        for (int v = 0; v < G.V(); v++)
            if (!marked[v])
                dfs(G, v);
    }

    private void dfs(Digraph G, int v) {
        onStack[v] = true;
        marked[v] = true;
        for (int w : G.adj(v))
            if (this.hasCycle())
                return;
            else if (!marked[w]) {
                edgeTo[w] = v;
                dfs(G, w);
            } else if (onStack[w]) {
                cycle = new Stack<Integer>();
                for (int x = v; x != w; x = edgeTo[x])
                    cycle.push(x);
                cycle.push(w);
                cycle.push(v);
            }
        onStack[v] = false;
    }

    public boolean hasCycle() {
        return cycle != null;
    }

    public Iterable<Integer> cycle() {
        return cycle;
    }
}
```

**Proposition E**. A digraph has a topological order if and only if it is a DAG.

**Proposition F**. Reverse DFS postorder of a DAG is a topological order.

Depth-first search vertex ordering in a digraph:

```java
public class DepthFirstOrder {
    private boolean[] marked;
    private Queue<Integer> pre;         // vertices in preorder
    private Queue<Integer> post;        // vertices in postorder
    private Stack<Integer> reversePost; // vertices in reverse postorder

    public DepthFirstOrder(Digraph G) {
        pre = new Queue<Integer>();     // preorder is order of dfs() calls
        post = new Queue<Integer>();    // postorder is order in which vertices are done
        reversePost = new Stack<Integer>();
        marked = new boolean[G.V()];
        for (int v = 0; v < G.V(); v++)
            if (!marked[v])
                dfs(G, v);
    }

    private void dfs(Digraph G, int v) {
        pre.enqueue(v);
        marked[v] = true;
        for (int w : G.adj(v))
            if (!marked[w])
                dfs(G, w);
        post.enqueue(v);
        reversePost.push(v);
    }

    public Iterable<Integer> pre() {
        return pre;
    }

    public Iterable<Integer> post() {
        return post;
    }

    public Iterable<Integer> reversePost() {
        return reversePost;
    }
}
```

Topological sort (ALGORITHM 4.5)

```java
public class Topological {
    private Iterable<Integer> order; // topological order

    public Topological(Digraph G) {
        DirectedCycle cyclefinder = new DirectedCycle(G);
        if (!cyclefinder.hasCycle()) {
            DepthFirstOrder dfs = new DepthFirstOrder(G);
            order = dfs.reversePost();
        }
    }

    public Iterable<Integer> order() {
        return order;
    }

    public boolean isDAG() {
        return order == null;
    }

    public static void main(String[] args) {
        String filename = args[0];
        String separator = args[1];
        SymbolDigraph sg = new SymbolDigraph(filename, separator);
        Topological top = new Topological(sg.G());
        for (int v : top.order())
            StdOut.println(sg.name(v));
    }
}
```

**Proposition G**. With DFS, we can topologically sort a DAG in time proportional to `V + E`.

In practice, topological sorting and cycle detection go hand in hand, with cycle detection playing the role of a debugging tool. For example, in a job-scheduling application, a directed cycle in the underlying digraph represents a mistake that must be corrected, no matter how the schedule was formulated. Thus, a job-scheduling application is typically a three-step process: 

1. Specify the tasks and precedence constraints. 
2. Make sure that a feasible solution exists, by detecting and removing cycles in the underlying digraph until none exist. 
3. Solve the scheduling problem, using topological sort. Similarly, any changes in the schedule can be checked for cycles (using DirectedCycle), then a new schedule computed (using Topological).

### 2.5. Strongly-connected components

*Def*. Vertices `v` and `w` are strongly connected if there is both a directed path from `v` to `w` and a directed path from `w` to `v`.

*Key property*. Strong connectivity is an equivalence relation:
- `v` is strongly connected to `v`.
- If `v` is strongly connected to `w`, then `w` is strongly connected to `v`.
- If `v` is strongly connected to `w` and `w` to `x`, then `v` is strongly connected to `x`.

*Def*. A *strong component* is a maximal subset of strongly-connected vertices.

#### 2.5.1. Strong component application

Typical strong-component applications

| application | vertex | edge | 
| :--: | :--: | :--: |
| web | page | hyperlink | 
| textbook | topic | reference | 
| software | module | call | 
| food web | organism | predator-prey relationship | 

#### 2.5.2. API for strong components

| `public class SCC` ||
|:--:|:--:|
| `SCC(Digraph G)` | *preprocessing constructor* |
| `boolean stronglyConnected(int v, int w)` | *are `v` and `w` strongly connected?* |
| `int count()` | *number of strong components* |
| `int id(int v)` | *component identifier for `v` (between `0` and `count()-1`)* |

#### 2.5.3. Kosaraju’s algorithm

**Proposition H**. In a DFS of a digraph G where marked vertices are considered in reverse postorder given by a DFS of the digraph’s reverse G<sup>R</sup> (Kosaraju’s algorithm), the vertices reached in each call of the recursive method from the constructor are in a strong component. 

<details>
<summary>Proof.</summary>

> First, we prove by contradiction that every vertex `v` that is strongly connected to `s` is reached by the call `dfs(G, s)` in the constructor. Suppose a vertex `v` that is strongly connected to `s` is not reached by `dfs(G, s)`. Since there is a path from `s` to `v`, `v` must have been previously marked. But then, since there is a path from `v` to `s`, `s` would have been marked during the call `dfs(G, v)` and the constructor would not call `dfs(G, s)`, a contradiction.   
> 
> Second, we prove that every vertex `v` reached by the call `dfs(G, s)` in the constructor is strongly connected to `s`. Let v be a vertex reached by the call `dfs(G, s)`. Then, there is a path from `s` to `v` in G, so it remains only to prove that there is a path from `v` to `s` in G. This statement is equivalent to saying that there is a path from `s` to `v` in G<sup>R</sup>, so it remains only to prove that there is a path from `s` to `v` in G<sup>R</sup>.   
> 
> The crux of the proof is that the reverse postorder construction implies that `dfs(G, v)` must have been done before `dfs(G, s)` during the DFS of G<sup>R</sup>, leaving just two cases to consider for `dfs(G, v)`: it might have been called 
> - before `dfs(G, s)` was called (and also done before `dfs(G, s)` was called) 
> - after `dfs(G, s)` was called (and done before `dfs(G, s)` was done) 
> 
> The first of these is not possible because there is a path from `v` to `s` in G<sup>R</sup>; the second implies that there is a path from `s` to `v` in G<sup>R</sup>, completing the proof.

</details>


Kosaraju’s algorithm for computing strong components (ALGORITHM 4.6). To find strong components, it does a depth-first search in the reverse digraph to produce a vertex order (reverse postorder of that search) for use in a depth-first search of the given digraph.

```java
public class KosarajuSCC {
    private boolean[] marked;       // reached vertices
    private int[] id;               // component identifiers
    private int count;              // number of strong components

    public KosarajuSCC(Digraph G) {
        marked = new boolean[G.V()];
        id = new int[G.V()];
        DepthFirstOrder order = new DepthFirstOrder(G.reverse());
        for (int s : order.reversePost())
            if (!marked[s]) {
                dfs(G, s);
                count++;
            }
    }

    private void dfs(Digraph G, int v) {
        marked[v] = true;
        id[v] = count;
        for (int w : G.adj(v))
            if (!marked[w])
                dfs(G, w);
    }

    public boolean stronglyConnected(int v, int w) {
        return id[v] == id[w];
    }

    public int id(int v) {
        return id[v];
    }

    public int count() {
        return count;
    }
}
```

**Proposition I**. Kosaraju’s algorithm uses preprocessing time and space proportional to `V + E` to support constant-time strong connectivity queries in a digraph.


<br/>
<div align="right">
    <b><a href="#top">↥ back to top</a></b>
</div>
<br/>


## 3. Minimum spanning trees

Given an undirected graph G with positive edge weights (connected), A *spanning tree* of G is a subgraph T that is both a *tree* (connected and acyclic) and *spanning* (includes all of the vertices). A **minimum spanning tree (MST)** of an edge-weighted graph is a spanning tree whose weight (the sum of the weights of its edges) is no larger than the weight of any other spanning tree.

[**MST applications**](https://www.ics.uci.edu/~eppstein/gina/mst.html)
MST is fundamental problem with diverse applications.
- [Dithering](https://en.wikipedia.org/wiki/Dither).
- Cluster analysis.
- Max bottleneck paths.
- Real-time face verification.
- LDPC codes for error correction.
- Image registration with Renyi entropy.
- Find road networks in satellite and aerial imagery.
- Reducing data storage in sequencing amino acids in a protein.
- Model locality of particle interactions in turbulent fluid flows.
- Autoconfig protocol for Ethernet bridging to avoid cycles in a network.
- Approximation algorithms for NP-hard problems (e.g., TSP, Steiner tree).
- Network design (communication, electrical, hydraulic, computer, road).

### 3.1. Greedy algorithm

With the following simplified assumptions, **MST exists and is unique**.
- Edge weights are distinct. (with equals weights, MST may not be unique, but algorithm still works.)
- Graph is connected.



Recall in section [Graph terminology](#113-graph-terminology), two of the defining properties of a tree:
- Adding an edge that connects two vertices in a tree creates a unique cycle.
- Removing an edge from a tree breaks it into two separate subtrees.


**Definition**. A *cut* of a graph is a partition of its vertices into two nonempty disjoint sets. A *crossing edge* of a cut is an edge that connects a vertex in one set with a vertex in the other.

**Proposition J**. (**Cut property**) Given any cut, the crossing edge of min weight is in the MST.


<img src="res/cut-property.png" alt="cut property" width="180"></img>


**Proposition K**. (**Greedy MST algorithm**) The following method colors *black* all edges in the the MST of any connected edgeweighted graph with V vertices: starting with all edges colored gray, find a cut with no black edges, color its minimum-weight edge black, and continue until `V - 1` edges have been colored black.


### 3.2. Edge-weighted graph API

Edge abstraction needed for weighted edges.

| `public class Edge implements Comparable<Edge>` | |
| :--: | :--: |
| `Edge(int v, int w, double weight)` | initializing constructor | 
| `double weight()` | weight of this edge | 
| `int either()` | either of this edge’s vertices | 
| `int other(int v)` | the other vertex | 
| `int compareTo(Edge that)` | compare this edge to `e` | 
| `String toString()` | string representation | 


```java
public class Edge implements Comparable<Edge>
{
    private final int v, w;
    private final double weight;
    public Edge(int v, int w, double weight)
    {
        this.v = v;
        this.w = w;
        this.weight = weight;
    }
    public int either()
    { return v; }
    public int other(int vertex)
    {
        if (vertex == v) return w;
        else return v;
    }
    public int compareTo(Edge that)
    {
        if (this.weight < that.weight) return -1;
        else if (this.weight > that.weight) return +1;
        else return 0;
    }
}
```

Edge-weighted graph API.

| `public class EdgeWeightedGraph` | | 
| :--: | :--: |
| `EdgeWeightedGraph(int V) `| create an empty graph with `V` vertices |
| `EdgeWeightedGraph(In in)` | create a graph from input stream |
| `void addEdge(Edge e)` | add weighted edge `e` to this graph |
| `Iterable<Edge> adj(int v)` | edges incident to `v` |
| `Iterable<Edge> edges()` | all edges in this graph |
| `int V()` | number of vertices |
| `int E()` | number of edges |
| `String toString()` | string representation |

This API is very similar to the [API for Graph](#12-graph-api).

#### 3.2.1. Edge-weighted graph: adjacency-lists representation



<img src="res/edge-weighted-graph-adjacency-lists-representation.png" alt="edge-weighted-graph-adjacency-lists-representation" width="550"></img>



```java
public class EdgeWeightedGraph
{
    private final int V;
    private final Bag<Edge>[] adj;
    public EdgeWeightedGraph(int V)
    {
        this.V = V;
        adj = (Bag<Edge>[]) new Bag[V];
        for (int v = 0; v < V; v++)
            adj[v] = new Bag<Edge>();
    }
    public void addEdge(Edge e)
    {
        int v = e.either(), w = e.other(v);
        adj[v].add(e);
        adj[w].add(e);
    }
    public Iterable<Edge> adj(int v)
    { return adj[v]; }
}
```


### 3.3. Minimum spanning tree API

As usual, for graph processing, define an API where the constructor takes an edge-weighted graph as argument and supports client query methods that return the MST and its weight. The *MST* of a graph G is a subgraph of G that is also a tree.

| `public class MST` | | 
| :--: | :--: |
| `MST(EdgeWeightedGraph G) `| constructor | 
| `Iterable<Edge> edges()` | all of the MST edges | 
| `double weight()` | weight of MST | 


Test client.

```java
public static void main(String[] args)
{
    In in = new In(args[0]);
    EdgeWeightedGraph G = new EdgeWeightedGraph(in);
    MST mst = new MST(G);

    for (Edge e : mst.edges())
        StdOut.println(e);
    StdOut.printf("%.2f\n", mst.weight());
}
```

### 3.4. Kruskal's algorithm

Consider edges in ascending order of weight.
- Add next edge to tree T unless doing so would create a cycle.

**Proposition**. [Kruskal 1956] Kruskal's algorithm computes the MST.   
*Pf*. (Kruskal's algorithm is a special case of the greedy MST algorithm.)

*Challenge*. Would adding edge v–w to tree T create a cycle? If not, add it.

*Efficient solution*. Use the **union-find** data structure.
- Maintain a set for each connected component in `T`.
- If v and w are in same set, then adding `v–w` would create a cycle.
- To add `v–w` to `T`, merge sets containing `v` and `w`.


```java
public class KruskalMST
{
    private Queue<Edge> mst = new Queue<Edge>();
    public KruskalMST(EdgeWeightedGraph G)
    {
        // build priority queue
        MinPQ<Edge> pq = new MinPQ<Edge>();
        for (Edge e : G.edges())
            pq.insert(e);

        UF uf = new UF(G.V());
        while (!pq.isEmpty() && mst.size() < G.V()-1)
        {
            // greedily add edges to MST
            Edge e = pq.delMin();
            int v = e.either(), w = e.other(v);
            
            // edge v–w does not create cycle
            if (!uf.connected(v, w))
            {
                uf.union(v, w);     // merge sets
                mst.enqueue(e);     // add edge to MST
            }
        }
    }

    public Iterable<Edge> edges()
    { return mst; }
}
```

**Proposition**. Kruskal's algorithm computes MST in time proportional to `E log E` (in the worst case).

| operation | frequency | time per op |
|:--:|:--:|:--:|
| build pq | 1 | E log E| 
| delete-min | E | log E| 
| union | V | log* V †| 
| connected | E | log* V †| 

- † amortized bound using weighted quick union with path compression
- log* V ≤ 5 in this universe. see [Iterated logarithm](https://en.wikipedia.org/wiki/Iterated_logarithm).

Remark. If edges are already sorted, order of growth is `E log* V`.

Actually we don't have to always sort them. In real life situations, we can stop when we get the `V - 1` edges in the MST.


### 3.5. Prim's algorithm

Attach a new edge to a single growing tree at each step. 

Start with any vertex as a single-vertex tree; then add `V - 1` edges to it, always taking next (coloring black) the minimum-weight edge that connects a vertex on the tree to a vertex not yet on the tree (a crossing edge for the cut defined by tree vertices).

- Start with vertex 0 and greedily grow tree T.
- Add to T the min weight edge with exactly one endpoint in T.
- Repeat until `V - 1` edges.


<img src="res/prim-algorithm.png" alt="Prim's algorithm" width="180"></img>



**Proposition**. [Jarník 1930, Dijkstra 1957, Prim 1959] Prim's algorithm computes the MST.  
*Pf*. (Prim's algorithm is a special case of the greedy MST algorithm.)

***Challenge***. **Find the min weight edge with exactly one endpoint in T.**

#### 3.5.1. Prim's algorithm: lazy implementation

*Lazy solution*. Maintain a PQ of edges with (at least) one endpoint in T.
- Key = edge; priority = weight of edge.
- Delete-min to determine next edge `e = v–w` to add to T.
- Disregard if both endpoints `v` and `w` are marked (both in T).
- Otherwise, let `w` be the unmarked vertex (not in T):
  - add to PQ any edge incident to `w` (assuming other endpoint not in T)
  - add `e` to T and mark `w`


```java
public class LazyPrimMST
{
    private boolean[] marked;   // MST vertices
    private Queue<Edge> mst;    // MST edges
    private MinPQ<Edge> pq;     // PQ of edges

    public LazyPrimMST(WeightedGraph G)
    {
        pq = new MinPQ<Edge>();
        mst = new Queue<Edge>();
        marked = new boolean[G.V()];
        visit(G, 0);

        while (!pq.isEmpty() && mst.size() < G.V() - 1)
        {
            Edge e = pq.delMin();
            int v = e.either(), w = e.other(v);
            if (marked[v] && marked[w]) continue;
            mst.enqueue(e);
            if (!marked[v]) visit(G, v);
            if (!marked[w]) visit(G, w);
        }
    }

    private void visit(WeightedGraph G, int v)
    {
        marked[v] = true;
        for (Edge e : G.adj(v))
            if (!marked[e.other(v)])
                pq.insert(e);
    }

    public Iterable<Edge> mst()
    { return mst; }
}
```

This implementation of Prim’s algorithm uses a priority queue to hold crossing edges, a vertex-indexed arrays to mark tree vertices, and a queue to hold MST edges. This implementation is a lazy approach where we leave *ineligible* edges in the priority queue.


**Proposition**. Lazy Prim's algorithm computes the MST in time proportional to `E log E` and extra space proportional to `E` (in the worst case).  
Pf.
| operation | frequency | binary heap |
|:--:|:--:|:--:|
| delete min | E | log E | 
| insert | E | log E | 

The bottleneck in the algorithm is the number of edge-weight comparisons in the priority-queue methods `insert()` and `delMin()`. The number of edges on the priority queue is at most `E`, which gives the space bound. 

In practice, the upper bound on the running time is a bit conservative because the number of edges on the priority queue is typically much less than `E`.


#### 3.5.2. Indexed priority queue

Associate an index between `0` and `N - 1` with each key in a priority queue.
- Client can insert and delete-the-minimum.
- Client can change the key by specifying the index.


| `public class IndexMinPQ<Key extends Comparable<Key>>`| | 
|:--:|:--:|
| `IndexMinPQ(int N)` | create indexed priority queue with indices `0, 1, …, N-1` | 
| `void insert(int i, Key key)` | associate key with index `i` | 
| `void decreaseKey(int i, Key key)` | decrease the key associated with index `i`| 
| `boolean contains(int i)` | is `i` an index on the priority queue?| 
| `int delMin()`| remove a minimal key and return its associated index| 
| `boolean isEmpty()` | is the priority queue empty?| 
| `int size()` | number of entries in the priority queue| 


Implementation.
- Start with same code as `MinPQ`.
- Maintain parallel arrays `keys[]`, `pq[]`, and `qp[]` so that:
  - `keys[i]` is the priority of `i`
  - `pq[i]` is the index of the key in heap position `i`
  - `qp[i]` is the heap position of the key with index `i`
- Use `swim(qp[i])` implement `decreaseKey(i, key)`.


#### 3.5.3. Prim's algorithm: eager implementation


*Eager solution*. Maintain a PQ of **vertices** connected by an edge to T, where *priority of vertex v* = weight of shortest edge connecting v to T.
- Delete min vertex `v` and add its associated edge `e = v–w` to T.
- Update PQ by considering all edges `e = v–x` incident to v
  - ignore if `x` is already in T
  - add `x` to PQ if not already on it
  - **decrease priority** of `x` if `v–x` becomes shortest edge connecting `x` to T

*note: pq has at most one entry per vertex*


<img src="res/prim-algorithm-eager.png" alt="Prim's algorithm eager implementation" width="250"></img>


- `edgeTo[v]` is the shortest edge connecting v to the tree, and `distTo[v]` is the weight of that edge, if `v` is not on the tree but has at least one edge connecting it to the tree.
- All such vertices `v` are maintained on the index priority queue, as an index `v` associated with the weight of `edgeTo[v]`.



```java
public class PrimMST
{
    private Edge[] edgeTo;          // shortest edge from tree vertex
    private double[] distTo;        // distTo[w] = edgeTo[w].weight()
    private boolean[] marked;       // true if v on tree
    private IndexMinPQ<Double> pq;  // eligible crossing edges

    public PrimMST(EdgeWeightedGraph G)
    {
        edgeTo = new Edge[G.V()];
        distTo = new double[G.V()];
        marked = new boolean[G.V()];
        for (int v = 0; v < G.V(); v++)
            distTo[v] = Double.POSITIVE_INFINITY;
        pq = new IndexMinPQ<Double>(G.V());

        distTo[0] = 0.0;
        pq.insert(0, 0.0);          // Initialize pq with 0, weight 0.
        while (!pq.isEmpty())
            visit(G, pq.delMin());  // Add closest vertex to tree.
    }

    private void visit(EdgeWeightedGraph G, int v)
    { // Add v to tree; update data structures.
        marked[v] = true;
        for (Edge e : G.adj(v))
        {
            int w = e.other(v);
            if (marked[w]) continue; // v-w is ineligible.
            if (e.weight() < distTo[w])
            { // Edge e is new best connection from tree to w.
                edgeTo[w] = e;
                distTo[w] = e.weight();
                if (pq.contains(w)) pq.change(w, distTo[w]);
                else pq.insert(w, distTo[w]);
            }
        }
    }

    public Iterable<Edge> edges()   // See Exercise 4.3.21.
    public double weight()          // See Exercise 4.3.31.
}
```


#### 3.5.4. Prim's algorithm: running time

Prim's algorithm: running time depends on PQ implementation: V insert, V delete-min, E decrease-key.

| PQ implementation |insert |delete-min |decrease-key |total|
|:--:|:--:|:--:|:--:|:--:|
| array | 1 | V | 1 | V<sup>2</sup>| 
| binary heap | log V | log V | log V | E log V| 
| d-way heap (Johnson 1975) | log<sub>d</sub> V | d log<sub>d</sub> V | log<sub>d</sub> V | E log<sub>E/V</sub> V| 
| Fibonacci heap (Fredman-Tarjan 1984) | 1 † | log V † | 1 † | E + V log V | 

† amortized

*Bottom line.*
- Array implementation optimal for *dense* graphs.
- Binary heap much faster for *sparse* graphs.
- 4-way heap worth the trouble in performance-critical situations.
- Fibonacci heap best in theory, but not worth implementing.

### 3.6. context

#### 3.6.1. Euclidean MST

Given N points in the plane, find MST connecting them, where the distances between point pairs are their Euclidean distances.

*Brute force*. Compute ~ *N<sup>2</sup> / 2* distances and run Prim's algorithm.  

*Ingenuity*. Exploit geometry and do it in ~ *c N log N*.
- [Voronoi diagram](https://en.wikipedia.org/wiki/Voronoi_diagram)
- [Delaunay triangulation](https://en.wikipedia.org/wiki/Delaunay_triangulation)

#### 3.6.2. Scientific application: clustering

**k-clustering**. Divide a set of objects classify into k coherent groups.

*Distance function*. Numeric value specifying "closeness" of two objects.

*Goal*. Divide into clusters so that objects in different clusters are far apart.

*Applications*:
- Routing in mobile ad hoc networks.
- Document categorization for web search.
- Similarity searching in medical image databases.
- Skycat: cluster 109 sky objects into stars, quasars, galaxies.


##### 3.6.2.1. Single-link clustering

*Single link*. Distance between two clusters equals the distance between the two closest objects (one in each cluster).

*Single-link clustering*. Given an integer k, find a k-clustering that maximizes the distance between two closest clusters.

“Well-known” algorithm in science literature for single-link clustering:
- Form V clusters of one object each.
- Find the closest pair of objects such that each object is in a different cluster, and merge the two clusters.
- Repeat until there are exactly k clusters.

NOTE: This is Kruskal's algorithm (stop when k connected components).  
Alternate solution. Run Prim's algorithm and delete k–1 max weight edges.


<br/>
<div align="right">
    <b><a href="#top">↥ back to top</a></b>
</div>
<br/>


## 4. Shortest Paths

Given an edge-weighted digraph, find the shortest path from `s` to `t`.

Typical shortest-paths applications:

| application | vertex | edge | 
| :--: | :--: | :--: | 
| map | intersection | road | 
| network | router | connection| 
| schedule | job | precedence constraint| 
| arbitrage | currency | exchange rate| 

<br />

- [PERT/CPM](https://www.youtube.com/watch?v=-TDh-5n90vk).
  - Project Evaluation Review and Technique
  - Critical Path Method
- Map routing.
- [Seam carving](https://en.wikipedia.org/wiki/Seam_carving).
- Robot navigation.
- Texture mapping.
- Typesetting in TeX.
- Urban traffic planning.
- Optimal pipelining of VLSI chip.
- Telemarketer operator scheduling.
- Routing of telecommunications messages.
- Network routing protocols (OSPF, BGP, RIP).
- Exploiting arbitrage opportunities in currency exchange.
- Optimal truck routing through given traffic congestion pattern.


### 4.1. Shortest path variants

Which vertices?
- Single source: from one vertex `s` to every other vertex.
- Source-sink: from one vertex `s` to another `t`.
- All pairs: between all pairs of vertices.

Restrictions on edge weights?
- Nonnegative weights.
- Euclidean weights.
- Arbitrary weights.

Cycles?
- No directed cycles.
- No "negative cycles."

Simplifying assumption. Shortest paths from `s` to each vertex `v` exist.


### 4.2. Weighted directed edge API

| `public class DirectedEdge` | | 
| :---: | :---: | 
| `DirectedEdge(int v, int w, double weight)` | weighted edge `v→w`| 
| `int from()` | vertex `v`| 
| `int to()` | vertex `w`| 
| `double weight()` | weight of this edge| 
| `String toString()` | string representation| 

Implementation in Java: Similar to Edge for undirected graphs, but a bit simpler.

```java
public class DirectedEdge
{
    private final int v, w;
    private final double weight;

    public DirectedEdge(int v, int w, double weight)
    {
        this.v = v;
        this.w = w;
        this.weight = weight;
    }

    // from() and to() replace either() and other()
    public int from()
    { return v; }

    public int to()
    { return w; }

    public int weight()
    { return weight; }
}
```

#### 4.2.1. Edge-weighted digraph: adjacency-lists implementation in Java

Same as EdgeWeightedGraph except replace Graph with Digraph.

```java
public class EdgeWeightedDigraph
{
    private final int V;
    private final Bag<DirectedEdge>[] adj;
    public EdgeWeightedDigraph(int V)
    {
        this.V = V;
        adj = (Bag<DirectedEdge>[]) new Bag[V];
        for (int v = 0; v < V; v++)
            adj[v] = new Bag<DirectedEdge>();
    }
    public void addEdge(DirectedEdge e)
    {
        int v = e.from();
        adj[v].add(e);
    }
    public Iterable<DirectedEdge> adj(int v)
    { return adj[v]; }
}
```

#### 4.2.2. Single-source shortest paths API

Goal. Find the shortest path from `s` to every other vertex.

| `public class SP` | |
| :--: | :--: |
| `SP(EdgeWeightedDigraph G, int s)` | shortest paths from `s` in graph G |
| `double distTo(int v)` | length of shortest path from `s` to `v` | 
| `Iterable <DirectedEdge> pathTo(int v)` | shortest path from `s` to `v` | 
| `boolean hasPathTo(int v)` | is there a path from `s` to `v`? | 

### 4.3. Shortest-paths properties

#### 4.3.1. Data structures for single-source shortest paths

Can represent the shortest-paths tree (SPT) with two vertex-indexed arrays:
- `distTo[v]` is length of shortest path from `s` to `v`.
- `edgeTo[v]` is last edge on shortest path from `s` to `v`.

```java
public double distTo(int v)
{ return distTo[v]; }

public Iterable<DirectedEdge> pathTo(int v)
{
    Stack<DirectedEdge> path = new Stack<DirectedEdge>();
    for (DirectedEdge e = edgeTo[v]; e != null; e = edgeTo[e.from()])
        path.push(e);
    return path;
}
```

#### 4.3.2. Edge relaxation

Relax edge `e = v→w`.
- `distTo[v]` is length of shortest known path from `s` to `v`.
- `distTo[w]` is length of shortest known path from `s` to `w`.
- `edgeTo[w]` is last edge on shortest known path from `s` to `w`.
- If `e = v→w` gives shorter path to `w` through `v`, update both `distTo[w]` and `edgeTo[w]`.

```java
private void relax(DirectedEdge e)
{
    int v = e.from(), w = e.to();
    if (distTo[w] > distTo[v] + e.weight())
    {
        distTo[w] = distTo[v] + e.weight();
        edgeTo[w] = e;
    }
}
```


<img src="res/edge-relaxation.png" alt="Edge relaxation (two cases)" width="550"></img>



The term **relaxation** follows from the idea of a rubber band stretched tight on a path connecting two vertices: relaxing an edge is akin to relaxing the tension on the rubber band along a shorter path, if possible. We say that an edge `e` can be successfully relaxed if `relax()` would change the values of `distTo[e.to()]` and `edgeTo[e.to()]`.

#### 4.3.3. Shortest-paths optimality conditions

**Proposition**. Let G be an edge-weighted digraph.
Then `distTo[]` are the shortest path distances from `s` iff:
- `distTo[s] = 0`.
- For each vertex `v`, `distTo[v]` is the length of some path from `s` to `v`.
- For each edge `e = v→w`, `distTo[w] ≤ distTo[v] + e.weight()`.

<details>
<summary>Proof.</summary>

> ⇐ [ necessary ]
> - Suppose that `distTo[w] > distTo[v] + e.weight()` for some edge `e = v→w`.
> - Then, `e` gives a path from `s` to `w` (through `v`) of length less than `distTo[w]`.
> 
> ⇒ [ sufficient ]
> - Suppose that s = v<sub>0</sub> → v<sub>1</sub> → v<sub>2</sub> → … → v<sub>k</sub> = w is a shortest path from `s` to `w`.
> - Then,  
>   distTo[v<sub>1</sub>] ≤ distTo[v<sub>0</sub>] + e<sub>1</sub>.weight()  
>   distTo[v<sub>2</sub>] ≤ distTo[v<sub>1</sub>] + e<sub>2</sub>.weight()  
>   ...  
>   distTo[v<sub>k</sub>] ≤ distTo[v<sub>k-1</sub>] + e<sub>k</sub>.weight()  
> - Add inequalities; simplify; and substitute distTo[v<sub>0</sub>] = distTo[s] = 0:
> distTo[w] = distTo[v<sub>k</sub>] ≤ e<sub>1</sub>.weight() + e<sub>2</sub>.weight() + … + e<sub>k</sub>.weight()
> - Thus, `distTo[w]` is the weight of shortest path to `w`.

</details>


### 4.4. Generic shortest-paths algorithm

**Generic algorithm (to compute SPT from s)**
- Initialize `distTo[s] = 0` and `distTo[v] = ∞` for all other vertices. 
- Repeat until optimality conditions are satisfied:
  - Relax any edge.

**Proposition**. Generic algorithm computes SPT (if it exists) from `s`.

<details>
<summary>Proof sketch.</summary>

> - Throughout algorithm, `distTo[v]` is the length of a simple path from `s` to `v` (and `edgeTo[v]` is last edge on path).
> - Each successful relaxation decreases `distTo[v]` for some `v`.
> - The entry `distTo[v]` can decrease at most a finite number of times.

</details>


**Efficient implementations**. How to choose which edge to relax?
- Ex 1. Dijkstra's algorithm (nonnegative weights).
- Ex 2. Topological sort algorithm (no directed cycles).
- Ex 3. Bellman-Ford algorithm (no negative cycles).

### 4.5. Dijkstra's algorithm

> "The tools we use have a profound and devious influence on our thinking habits, and therefore on our thinking abilities." — Edsger W. Dijkstra

<img src="res/Dijkstra_Animation.gif" alt="Dijkstra's algorithm animation" width="220"></img>

Wikipedia: [Dijkstra's algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm)

- Consider vertices in increasing order of distance from `s`
(non-tree vertex with the lowest `distTo[]` value).
- Add vertex to tree and relax all edges pointing from that vertex.

**Proposition**. Dijkstra’s algorithm solves the single-source shortest-paths problem in edge-weighted digraphs with **nonnegative** weights.

**Proposition**. Dijkstra’s algorithm uses extra space proportional to `V` and time proportional to `E log V` (in the worst case) to compute the SPT rooted at a given source in an edge-weighted digraph with E edges and V vertices.

<img src="res/dijkstra-algorithm.png" alt="Dijkstra's algorithm" width="250">

```java
public class DijkstraSP
{
    private DirectedEdge[] edgeTo;
    private double[] distTo;
    private IndexMinPQ<Double> pq;

    public DijkstraSP(EdgeWeightedDigraph G, int s)
    {
        edgeTo = new DirectedEdge[G.V()];
        distTo = new double[G.V()];
        pq = new IndexMinPQ<Double>(G.V());
        for (int v = 0; v < G.V(); v++)
            distTo[v] = Double.POSITIVE_INFINITY;
        distTo[s] = 0.0;
        pq.insert(s, 0.0);
        while (!pq.isEmpty())
            relax(G, pq.delMin())
    }

    private void relax(EdgeWeightedDigraph G, int v)
    {
        for(DirectedEdge e : G.adj(v))
        {
            int w = e.to();
            if (distTo[w] > distTo[v] + e.weight())
            {
                distTo[w] = distTo[v] + e.weight();
                edgeTo[w] = e;
                if (pq.contains(w)) pq.change(w, distTo[w]);
                else pq.insert(w, distTo[w]);
            }
        }
    }

    public double distTo(int v)
    { return distTo[v]; }

    public boolean hasPathTo(int v)
    { return distTo[v] < Double.POSITIVE_INFINITY; }

    public Iterable<DirectedEdge> pathTo(int v)
    {
        if (!hasPathTo(v)) return null;
        Stack<DirectedEdge> path = new Stack<DirectedEdge>();
        for (DirectedEdge e = edgeTo[v]; e != null; e = edgeTo[e.from()])
            path.push(e);
        return path;
    }
}
```

This implementation of Dijkstra’s algorithm grows the SPT by adding an edge at a time, always choosing the edge from a tree vertex to a non-tree vertex whose destination `w` is closest to `s`.

**Dijkstra’s algorithm vs. Prim's algorithm?**
- Prim’s algorithm is essentially the same algorithm.
- Both are in a family of algorithms that compute a graph’s spanning tree.

Note: DFS and BFS are also in this family of algorithms.

Main distinction: Rule used to choose next vertex for the tree.
| algorithms | distinction |
|:--:|:--:|
| Prim’s | Closest vertex to the **tree** (via an undirected edge). |
| Dijkstra’s | Closest vertex to the **source** (via a directed path). |


**Dijkstra's algorithm: which priority queue?**

Depends on PQ implementation: V insert, V delete-min, E decrease-key. See section [Prim's algorithm runtime](#354-prims-algorithm-running-time).

#### 4.5.1. Dijkstra’s algorithm variants

- **Single-source shortest paths in undirected graphs**. Given an edge-weighted undirected graph and a source vertex `s`, support queries of the form *Is there a path from `s` to a given target vertex `v`?* If so, find a shortest such path (one whose total weight is minimal).

    <details>
    <summary>Solution. </summary>

    > View the undirected graph as a digraph. Build an edge-weighted digraph with the same vertices and with two directed edges. Solve the shortest-paths problems.

    </details>

- **Source-sink shortest paths**. Given an edge-weighted digraph, a source vertex `s`, and a target vertex `t`, find the shortest path from `s` to `t`.

    <details>
    <summary>Solution. </summary>

    > To solve this problem, use Dijkstra’s algorithm, but terminate the search as soon as `t` comes off the priority queue.

    </details>

- **All-pairs shortest paths**. Given an edge-weighted digraph, support queries of the form *Given a source vertex `s` and a target vertex `t`, is there a path from s to t?* If so, find a shortest such path (one whose total weight is minimal).

    ```java
    public class DijkstraAllPairsSP
    {
        private DijkstraSP[] all;
        DijkstraAllPairsSP(EdgeWeightedDigraph G)
        {
            all = new DijkstraSP[G.V()]
            for (int v = 0; v < G.V(); v++)
                all[v] = new DijkstraSP(G, v);
        }
        Iterable<Edge> path(int s, int t)
        { return all[s].pathTo(t); }
        double dist(int s, int t)
        { return all[s].distTo(t); }
    }
    ```

    <details>
    <summary>Solution. </summary>

    > The compact implementation above solves the all-pairs shortest paths problem, using time and space proportional to *EVlogV*. It builds an array of DijkstraSP objects, one for each vertex as the source. To answer a client query, it uses the source to access the corresponding single-source shortest-paths object and then passes the target as argument to the query.

    </details>

- **Shortest paths in Euclidean graphs**. Solve the single-source, source-sink, and all-pairs shortest-paths problems in graphs where vertices are points in the plane and edge weights are proportional to Euclidean distances between vertices.



### 4.6. Edge-weighted DAGs (acyclic edge-weighted digraph)

It is easier to find shortest paths in an edge-weighted DAG than in a general digraph.

Initialize `distTo[s]` to 0 and all other `distTo[]` values to infinity, then relax the vertices, one by one, taking the vertices in topological order.

- Consider vertices in topological order (see section [topological sort](#24-topological-sort)).
- Relax all edges pointing from that vertex.

**Proposition**. Topological sort algorithm computes SPT in any edge-weighted DAG in time proportional to `E + V`.

<details>
<summary>Proof.</summary>

> - Each edge `e = v→w` is relaxed exactly once (when `v` is relaxed), leaving `distTo[w] ≤ distTo[v] + e.weight()`.
> - Inequality holds until algorithm terminates because:
>   - `distTo[w]` cannot increase (`distTo[]` values are monotone decreasing)
>   - `distTo[v]` will not change (because of topological order, no edge pointing to v will be relaxed after `v` is relaxed)
> - Thus, upon termination, shortest-paths optimality conditions hold.
> 
> NOTE: proof does not depend on the edge weights being nonnegative, so we can remove that restriction for edge-weighted DAGs. 

</details>

ALGORITHM: Shortest paths in edge-weighted DAGs

```java
public class AcyclicSP
{
    private DirectedEdge[] edgeTo;
    private double[] distTo;
    public AcyclicSP(EdgeWeightedDigraph G, int s)
    {
        edgeTo = new DirectedEdge[G.V()];
        distTo = new double[G.V()];
        for (int v = 0; v < G.V(); v++)
            distTo[v] = Double.POSITIVE_INFINITY;
        distTo[s] = 0.0;
        Topological top = new Topological(G);
        for (int v : top.order())
            relax(G, v);
    }

    private void relax(EdgeWeightedDigraph G, int v)
    {
        for(DirectedEdge e : G.adj(v))
        {
            int w = e.to();
            if (distTo[w] > distTo[v] + e.weight())
            {
                distTo[w] = distTo[v] + e.weight();
                edgeTo[w] = e;
            }
        }
    }

    public double distTo(int v)
    { return distTo[v]; }

    public boolean hasPathTo(int v)
    { return distTo[v] < Double.POSITIVE_INFINITY; }

    public Iterable<DirectedEdge> pathTo(int v)
    {
        if (!hasPathTo(v)) return null;
        Stack<DirectedEdge> path = new Stack<DirectedEdge>();
        for (DirectedEdge e = edgeTo[v]; e != null; e = edgeTo[e.from()])
            path.push(e);
        return path;
    }
}
```

Note that `marked[]` is not needed in this implementation: since vertices is processed in an acyclic digraph in topological order, a vertex that is already relaxed will not be re-encountered. 

For shortest paths, the topological-sort-based method is faster than Dijkstra’s algorithm by a factor proportional to the cost of the **priority-queue** operations in Dijkstra’s algorithm. 


#### 4.6.1. Application: content-aware resizing

[**Seam carving**](https://www.youtube.com/watch?v=6NcIJXTlugc). [Avidan and Shamir] Resize an image without distortion for display on cell phones and web browsers.

To find vertical seam:
- Grid DAG: vertex = pixel; edge = from pixel to 3 downward neighbors.
- Weight of pixel = energy function of 8 neighboring pixels.
- Seam = shortest path (sum of vertex weights) from top to bottom.


#### 4.6.2. Longest paths in edge-weighted DAGs

Key point. Topological sort algorithm works even with *negative* weights.

**Single-source longest paths in edge-weighted DAGs**. Given an edge-weighted DAG (with negative weights allowed) and a source vertex `s`, support queries of the form: *Is there a directed path from s to a given target vertex v?* If so, find a longest such path (one whose total weight is maximal).

<details>
<summary>Solution.</summary>

> Can solve the longest-paths problem in edge-weighted DAGs in time proportional to E + V. Negate the edge weights.

</details>

#### 4.6.3. Longest paths in edge-weighted DAGs: application

##### 4.6.3.1. Parallel job scheduling

**Parallel precedence-constrained scheduling**. Given a set of jobs of specified duration to be completed, with precedence constraints that specify that certain jobs have to be completed before certain other jobs are begun, how can we schedule the jobs on identical processors (as many as needed) such that they are all completed in the minimum amount of time while still respecting the constraints?

Solution. The problem is equivalent to a longest-paths problem in an edge-weighted DAG. Use critical path method (a linear-time algorithm).

<img src="res/critical-path-method.png" alt="critical path method" width="500"></img>

**CPM**. To solve a parallel job-scheduling problem, create edge-weighted DAG:
- Source and sink vertices.
- Two vertices (begin and end) for each job.
- Three edges for each job.
  - begin to end (weighted by duration)
  - source to begin (0 weight)
  - end to sink (0 weight)
- One edge for each precedence constraint (0 weight).
- Use longest path from the source to schedule each job.

Critical path method for parallel precedence-constrained job scheduling

```java
public class CPM
{
    public static void main(String[] args)
    {
        int N = StdIn.readInt(); StdIn.readLine();
        EdgeWeightedDigraph G;
        G = new EdgeWeightedDigraph(2*N+2);
        int s = 2*N, t = 2*N+1;
        for (int i = 0; i < N; i++)
        {
            String[] a = StdIn.readLine().split("\\s+");
            double duration = Double.parseDouble(a[0]);
            G.addEdge(new DirectedEdge(i, i+N, duration));
            G.addEdge(new DirectedEdge(s, i, 0.0));
            G.addEdge(new DirectedEdge(i+N, t, 0.0));
            for (int j = 1; j < a.length; j++)
            {
                int successor = Integer.parseInt(a[j]);
                G.addEdge(new DirectedEdge(i+N, successor, 0.0));
            }
        }
        AcyclicLP lp = new AcyclicLP(G, s);
        StdOut.println("Start times:");
        for (int i = 0; i < N; i++)
            StdOut.printf("%4d: %5.1f\n", i, lp.distTo(i));
        StdOut.printf("Finish time: %5.1f\n", lp.distTo(t));
    }
}
```

### 4.7. Negative weights

Shortest paths with negative weights: failed attempts

Dijkstra. Doesn’t work with negative edge weights. Re-weighting by add a constant to every edge weight doesn’t work.

Def. A **negative cycle** is a directed cycle whose sum of edge weights is negative.

**Proposition**. A SPT exists iff no negative cycles.

#### 4.7.1. Bellman-Ford algorithm


**Proposition**. (**Bellman-Ford algorithm**) The following method solves the singlesource shortest-paths problem from a given source `s` for any edge-weighted digraph with V vertices and no negative cycles reachable from s: Initialize `distTo[s]` to `0` and all other `distTo[]` values to infinity. Then, considering the digraph’s edges in any order, relax all edges. Make `V` such passes. 

<details>
<summary>Proof.</summary>

> For any vertex `t` that is reachable from `s` consider a specific shortest path from s to t: v<sub>0</sub>->v<sub>1</sub>->...->v<sub>k</sub>, where v<sub>0</sub> is s and v<sub>k</sub> is t. Since there are no negative cycles, such a path exists and `k` can be no larger than `V-1`. 
> 
> We show by induction on `i` that after the ith pass the algorithm computes a shortest path from s to v<sub>i</sub>. The base case (i = 0) is trivial. Assuming the claim to be true for `i`, v<sub>0</sub>->v<sub>1</sub>->...->v<sub>i</sub> is a shortest path from `s` to v<sub>i</sub>, and distTo[v<sub>i</sub>] is its length. Now, we relax every vertex in the ith pass, including v<sub>i</sub>, so distTo[v<sub>i+1</sub>] is no greater than distTo[v<sub>i</sub>] plus the weight of v<sub>i</sub>->v<sub>i+1</sub>. Now, after the ith pass, distTo[v<sub>i+1</sub>] must be equal to distTo[v<sub>i</sub>] plus the weight of v<sub>i</sub>->v<sub>i+1</sub>. It cannot be greater because we relax every vertex in the ith pass, in particular v<sub>i</sub>, and it cannot be less because that is the length of v<sub>0</sub>->v<sub>1</sub>->...->v<sub>i+1</sub>, a shortest path. Thus the algorithm computes a shortest path from s to v<sub>i+1</sub> after the (i+1)st pass.

</details>


Initialize `distTo[s] = 0` and `distTo[v] = ∞` for all other vertices.  
Repeat V times:
- Relax each edge.

```java
for (int i = 0; i < G.V(); i++)
    for (int v = 0; v < G.V(); v++)
        for (DirectedEdge e : G.adj(v))
            relax(e);
```

**Proposition**. The Bellman-Ford algorithm takes time proportional to `EV` and extra space proportional to `V`.

ALGORITHM: Bellman-Ford algorithm (queue-based)

```java
public class BellmanFordSP
{
    private double[] distTo;                // length of path to v
    private DirectedEdge[] edgeTo;          // last edge on path to v
    private boolean[] onQ;                  // Is this vertex on the queue?
    private Queue<Integer> queue;           // vertices being relaxed
    private int cost;                       // number of calls to relax()
    private Iterable<DirectedEdge> cycle;   // negative cycle in edgeTo[]?

    public BellmanFordSP(EdgeWeightedDigraph G, int s)
    {
        distTo = new double[G.V()];
        edgeTo = new DirectedEdge[G.V()];
        onQ = new boolean[G.V()];
        queue = new Queue<Integer>();
        for (int v = 0; v < G.V(); v++)
            distTo[v] = Double.POSITIVE_INFINITY;
        distTo[s] = 0.0;
        queue.enqueue(s);
        onQ[s] = true;
        while (!queue.isEmpty() && !this.hasNegativeCycle())
        {
            int v = queue.dequeue();
            onQ[v] = false;
            relax(v);
        }
    }

    private void relax(EdgeWeightedDigraph G, int v)
    {
        for (DirectedEdge e : G.adj(v))
        {
            int w = e.to();
            if (distTo[w] > distTo[v] + e.weight())
            {
                distTo[w] = distTo[v] + e.weight();
                edgeTo[w] = e;
                if (!onQ[w])
                {
                    q.enqueue(w);
                    onQ[w] = true;
                }
            }
            if (cost++ % G.V() == 0)
                findNegativeCycle();
        }
    }

    public double distTo(int v)         // standard client query methods
    public boolean hasPathTo(int v)     // for SPT implementatations
    public Iterable<Edge> pathTo(int v) // as above

    private void findNegativeCycle()
    {
        int V = edgeTo.length;
        EdgeWeightedDigraph spt;
        spt = new EdgeWeightedDigraph(V);
        for (int v = 0; v < V; v++)
            if (edgeTo[v] != null)
                spt.addEdge(edgeTo[v]);
        EdgeWeightedCycleFinder cf;
        cf = new EdgeWeightedCycleFinder(spt);
        cycle = cf.cycle();
    }

    public boolean hasNegativeCycle()
    { return cycle != null; }

    public Iterable<Edge> negativeCycle()
    { return cycle; }
}
```

The algorithm is based on two additional data structures:
- A queue `q` of vertices to be relaxed
- A vertex-indexed boolean array `onQ[]` that indicates which vertices are on the queue, to avoid duplicates


The data structures ensure that
- Only one copy of each vertex appears on the queue
- Every vertex whose `edgeTo[]` and `distTo[]` values change in some pass is processed in the next pass


**Observation**. If `distTo[v]` does not change during pass `i`, no need to relax any edge pointing from `v` in pass `i+1`.

**FIFO implementation**. Maintain queue of vertices whose `distTo[]` changed.

*Note*: be careful to keep at most one copy of each vertex on queue (why?)

#### 4.7.2. Finding a negative cycle

**Observation**. If there is a negative cycle, Bellman-Ford gets stuck in loop, updating `distTo[]` and `edgeTo[]` entries of vertices in the cycle.

**Proposition**. If any vertex `v` is updated in phase `V`, there exists a negative cycle (and can trace back `edgeTo[v]` entries to find it).

*In practice*. Check for negative cycles more frequently.


#### 4.7.3. Negative cycle application: arbitrage detection

Currency exchange graph.
- Vertex = currency.
- Edge = transaction, with weight equal to exchange rate.
- Find a directed cycle whose product of edge weights is > 1.


Model as a negative cycle detection problem by taking logs.
- Let weight of edge `v→w` be **- ln (exchange rate from currency `v` to `w`)**.
- Multiplication turns to addition; `> 1` turns to `< 0`.
- Find a directed cycle whose sum of edge weights is `< 0` (negative cycle).

Arbitrage in currency exchange

```java
public class Arbitrage
{
    public static void main(String[] args)
    {
        int V = StdIn.readInt();
        String[] name = new String[V];
        EdgeWeightedDigraph G = new EdgeWeightedDigraph(V);
        for (int v = 0; v < V; v++)
        {
            name[v] = StdIn.readString();
            for (int w = 0; w < V; w++)
            {
                double rate = StdIn.readDouble();
                DirectedEdge e = new DirectedEdge(v, w, -Math.log(rate));
                G.addEdge(e);
            }
        }
        BellmanFordSP spt = new BellmanFordSP(G, 0);
        if (spt.hasNegativeCycle())
        {
            double stake = 1000.0;
            for (DirectedEdge e : spt.negativeCycle())
            {
                StdOut.printf("%10.5f %s ", stake, name[e.from()]);
                stake *= Math.exp(-e.weight());
                StdOut.printf("= %10.5f %s\n", stake, name[e.to()]);
            }
        }
        else StdOut.println("No arbitrage opportunity");
    }
}
```


### 4.8. Single source shortest-paths implementation: summary

***Cost:***

| algorithm | restriction | typical case | worst case | extra space | 
| :--: | :--: | :--: | :--: | :--: |
| topological sort | no directed cycles | E + V | E + V | V | 
| Dijkstra (binary heap) | no negative weights | E log V | E log V | V | 
| Bellman-Ford | no negative cycles | E V | E V | V | 
| Bellman-Ford (queue-based) | no negative cycles | E + V | E V | V | 

Remarks:
1. Directed cycles make the problem harder.
2. Negative weights make the problem harder.
3. Negative cycles makes the problem intractable.

**Summary:**

| topic | remark |
| :-------: | :------- |
| Dijkstra’s algorithm | Nearly linear-time when weights are nonnegative. <br/>Generalization encompasses DFS, BFS, and Prim. |
| Acyclic edge-weighted digraphs | Arise in applications.<br/>Faster than Dijkstra’s algorithm. <br/>Negative weights are no problem. |
| Negative weights and negative cycles | Arise in applications. <br/>If no negative cycles, can find shortest paths via Bellman-Ford. <br/>If negative cycles, can find one via Bellman-Ford. |

Shortest-paths is a broadly useful problem-solving model.



<br/>
<div align="right">
    <b><a href="#top">↥ back to top</a></b>
</div>
<br/>


## 5. Maximum Flow and Minimum Cut

### Mincut problem

*Input*. An edge-weighted digraph, source vertex s, and target vertex t.

*Def*. A **st-cut (cut)** is a partition of the vertices into two disjoint sets, with `s` in one set A and `t` in the other set B.

*Def*. Its **capacity** is the sum of the capacities of the edges from A to B.

**Minimum st-cut (mincut) problem**. Find a cut of minimum capacity.

### Maxflow problem

*Input*. An edge-weighted digraph, source vertex s, and target vertex t. (each edge has a positive capacity)

*Def*. An **st-flow (flow)** is an assignment of values to the edges such that:
- Capacity constraint: `0 ≤ edge's flow ≤ edge's capacity`.
- Local equilibrium: `inflow` = `outflow` at every vertex (except `s` and `t`).

*Def*. The **value** of a flow is the `inflow` at `t`. (assume no edge points to s or from t)

**Maximum st-flow (maxflow) problem**. Find a flow of maximum value.

<img src="res/maxflow-mincut.png" alt="Maxflow Mincut" width="500"></img>

*Remarkable fact*. These two problems are dual.

### Ford-Fulkerson algorithm

It is a generic method for increasing flows incrementally along paths from source to sink that serves as the basis for a family of algorithms. It is known as the Ford-Fulkerson algorithm in the classical literature; the more descriptive term augmenting-path algorithm is also widely used.

*Initialization*. Start with 0 flow.

*Augmenting path*. Find an undirected path from s to t such that:
- Can increase flow on forward edges (not full).
- Can decrease flow on backward edge (not empty).

*Termination*. All paths from `s` to `t` are blocked by either a
- Full forward edge.
- Empty backward edge.

**Ford-Fulkerson algorithm**
> Start with 0 flow.
> While there exists an augmenting path:
> - find an augmenting path
> - compute bottleneck capacity
> - increase flow on that path by bottleneck capacity

### Maxflow-mincut theorem

*Def*. The **net flow across** a cut (A, B) is the sum of the flows on its edges from A to B minus the sum of the flows on its edges from from B to A.

**Flow-value lemma**. Let f be any flow and let (A, B) be any cut. Then, the net flow across (A, B) equals the value of f.  
Pf. 
> By induction on the size of B.
> - Base case: `B = { t }`.
> - Induction step: remains true by local equilibrium when moving any vertex from A to B.

*Corollary*. `Outflow from s` = `inflow to t` = `value of flow`.

*Weak duality*. Let f be any flow and let (A, B) be any cut. Then, the value of the flow ≤ the capacity of the cut.  
Pf. 
> Value of flow f = net flow across cut (A, B) ≤ capacity of cut (A, B).

**Augmenting path theorem**. A flow `f` is a maxflow iff no augmenting paths.

**Maxflow-mincut theorem**. Value of the maxflow = capacity of mincut.

Pf. The following three conditions are equivalent for any flow `f`:
- i. There exists a cut whose capacity equals the value of the flow `f`.
- ii. `f` is a maxflow.
- iii. There is no augmenting path with respect to `f`.

<details>
<summary>detail: </summary>

[ i ⇒ ii ]  
- Suppose that (A, B) is a cut with capacity equal to the value of f.
- Then, the value of any flow f ' ≤ capacity of (A, B) = value of f.
- Thus, f is a maxflow.

[ ii ⇒ iii ] To prove contrapositive: `~iii ⇒ ~ii`.
- Suppose that there is an augmenting path with respect to f.
- Can improve flow f by sending flow along this path.
- Thus, f is not a maxflow.

[ iii ⇒ i ]  
Suppose that there is no augmenting path with respect to f.
- Let `(A, B)` be a cut where A is the set of vertices connected to s by an undirected path with no full forward or empty backward edges.
- By definition, s is in A; since no augmenting path, t is in B.
- Capacity of cut = net flow across cut (forward edges full; backward edges empty)  
  = value of flow f. (flow-value lemma)

</details>

#### Computing a mincut from a maxflow

To compute mincut (A, B) from maxflow f :
- By augmenting path theorem, no augmenting paths with respect to f.
- Compute A = set of vertices connected to s by an undirected path with no full forward or empty backward edges.


<img src="res/compute-mincut.png" alt="Computing a mincut from a maxflow" width="500"></img>

***Questions***.
- How to compute a mincut? 
  - Easy. ✔
- How to find an augmenting path? 
  - BFS works well.
- If FF terminates, does it always compute a maxflow? 
  - Yes. ✔
- Does FF always terminate? If so, after how many augmentations?
  - yes, provided edge capacities are integers (or augmenting paths are chosen carefully)
  - requires clever analysis


#### Ford-Fulkerson algorithm with integer capacities

*Important special case*. Edge capacities are integers between 1 and U.

**Invariant**. The flow is **integer-valued** throughout Ford-Fulkerson.  
Pf. *[by induction]* 
- Bottleneck capacity is an integer.
- Flow on an edge increases/decreases by bottleneck capacity.

**Proposition**. Number of augmentations ≤ the value of the maxflow.  
Pf. Each augmentation increases the value by at least 1.

**Integrality theorem**. There exists an integer-valued maxflow.  
Pf. Ford-Fulkerson terminates and maxflow that it finds is integer-valued.

*Bad news*. Even when edge capacities are integers, number of augmenting paths could be equal to the value of the maxflow.

*Good news*. This case is easily avoided. *[use shortest/fattest path]*


#### How to choose augmenting paths?

FF performance depends on choice of augmenting paths.

digraph with V vertices, E edges, and integer capacities between 1 and U
| augmenting path | number of paths | implementation | 
| :--: | :--: | :--: | 
| shortest path | ≤ ½ E V | queue (BFS) |
| fattest path | ≤ E ln(E U) | priority queue |
| random path | ≤ E U | randomized queue |
| DFS path | ≤ E U | stack (DFS) |

- shortest path: augmenting path with fewest number of edges
- fattest path: augmenting path with maximum bottleneck capacity

### Ford-Fulkerson: Java implementation

*Flow edge data type*. Associate flow f<sub>e</sub> and capacity c<sub>e</sub> with edge `e = v→w`.

*Flow network data type*. Need to process edge `e = v→w` in either direction:  
Include `e` in both `v` and `w`'s adjacency lists.

*Residual capacity*.
- Forward edge: residual capacity = c<sub>e</sub> - f<sub>e</sub>.
- Backward edge: residual capacity = f<sub>e</sub>.

*Augment flow*.
- Forward edge: add Δ.
- Backward edge: subtract Δ.

**Residual network**. A useful view of a flow network.

<img src="res/residual-network.png" alt="Residual network" width="500"></img>

*Key point*. Augmenting path in original network is equivalent to directed path in residual network.


<img src="res/residual-network-.png" alt="Residual network" width="500"></img>

**Flow edge: Java implementation**

```java
public class FlowEdge
{
    private final int v;            // edge source
    private final int w;            // edge target
    private final double capacity;  // capacity
    private double flow;            // flow

    public FlowEdge(int v, int w, double capacity)
    {
        this.v = v;
        this.w = w;
        this.capacity = capacity;
        this.flow = 0.0;
    }

    public int from() { return v; }
    public int to() { return w; }
    public double capacity() { return capacity; }
    public double flow() { return flow; }

    public int other(int vertex)
    // same as for Edge

    public double residualCapacityTo(int vertex)
    {
        if (vertex == v) return flow;
        else if (vertex == w) return cap - flow;
        else throw new RuntimeException("Inconsistent edge");
    }

    public void addResidualFlowTo(int vertex, double delta)
    {
        if (vertex == v) flow -= delta;
        else if (vertex == w) flow += delta;
        else throw new RuntimeException("Inconsistent edge");
    }

    public String toString()
    { return String.format("%d->%d %.2f %.2f", v, w, capacity, flow); }
}
```

**Flow network: Java implementation**

Same as `EdgeWeightedGraph`, but adjacency lists of `FlowEdges` instead of `Edges`.

```java
public class FlowNetwork
{
    private final int V;
    private Bag<FlowEdge>[] adj;
    public FlowNetwork(int V)
    {
        this.V = V;
        adj = (Bag<FlowEdge>[]) new Bag[V];
        for (int v = 0; v < V; v++)
            adj[v] = new Bag<FlowEdge>();
    }
    public void addEdge(FlowEdge e)
    {
        int v = e.from();
        int w = e.to();
        adj[v].add(e);      // add forward edge
        adj[w].add(e);      // add backward edge
    }
    public Iterable<FlowEdge> adj(int v)
    { return adj[v]; }
}
```

<img src="res/flow-network.png" alt="Flow network" width="500"></img>

**Ford-Fulkerson: Java implementation**

ALGORITHM: Ford-Fulkerson shortest-augmenting path maxflow algorithm

```java
public class FordFulkerson
{
    private boolean[] marked;   // Is s->v path in residual graph?
    private FlowEdge[] edgeTo;  // last edge on shortest s->v path
    private double value;       // current value of maxflow

    public FordFulkerson(FlowNetwork G, int s, int t)
    { // Find maxflow in flow network G from s to t.

        while (hasAugmentingPath(G, s, t))
        { // While there exists an augmenting path, use it.

            // Compute bottleneck capacity.
            double bottle = Double.POSITIVE_INFINITY;
            for (int v = t; v != s; v = edgeTo[v].other(v))
                bottle = Math.min(bottle, edgeTo[v].residualCapacityTo(v));

            // Augment flow.
            for (int v = t; v != s; v = edgeTo[v].other(v))
                edgeTo[v].addResidualFlowTo(v, bottle);
            value += bottle;
        }
    }

    private boolean hasAugmentingPath(FlowNetwork G, int s, int t)
    {
        marked = new boolean[G.V()];        // Is path to this vertex known?
        edgeTo = new FlowEdge[G.V()];       // last edge on path
        Queue<Integer> q = new Queue<Integer>();

        marked[s] = true;                   // Mark the source
        q.enqueue(s);                       // and put it on the queue.
        while (!q.isEmpty())
        {
            int v = q.dequeue();
            for (FlowEdge e : G.adj(v))
            {
                int w = e.other(v);
                if (e.residualCapacityTo(w) > 0 && !marked[w])
                { // For every edge to an unmarked vertex (in residual)
                    edgeTo[w] = e;          // Save the last edge on a path.
                    marked[w] = true;       // Mark w because a path is known
                    q.enqueue(w);           // and add it to the queue.
                }
            }
        }
        return marked[t];
    }

    public double value() { return value; }
    public boolean inCut(int v) { return marked[v]; }

    public static void main(String[] args)
    {
        FlowNetwork G = new FlowNetwork(new In(args[0]));
        int s = 0, t = G.V() - 1;
        FordFulkerson maxflow = new FordFulkerson(G, s, t);

        StdOut.println("Max flow from " + s + " to " + t);
        for (int v = 0; v < G.V(); v++)
            for (FlowEdge e : G.adj(v))
                if ((v == e.from()) && e.flow() > 0)
                    StdOut.println(" " + e);
        StdOut.println("Max flow value = " + maxflow.value());
    }
}
```

### Maxflow and mincut applications

Maxflow/mincut is a widely applicable problem-solving model.
- Data mining.
- Open-pit mining.
- **Bipartite matching**.
- Network reliability.
- **Baseball elimination**.
- Image segmentation.
- Network connectivity.
- Distributed computing.
- Security of statistical data.
- Egalitarian stable matching.
- Multi-camera scene reconstruction.
- Sensor placement for homeland security.
- Many, many, more.


**Network flow formulation of bipartite matching**  

Create s, t, one vertex for each student, and one vertex for each job.
- Add edge from s to each student (capacity 1).
- Add edge from each job to t (capacity 1).
- Add edge from student to each job offered (infinite capacity).

1-1 correspondence between perfect matchings in bipartite graph and integer-valued maxflows of value N.

*When no perfect matching, mincut explains why.*

Mincut. Consider mincut (A, B).
- Let S = students on s side of cut.
- Let T = companies on s side of cut.
- Fact: | S | > | T |; students in S can be matched only to companies in T.

**Maximum flow algorithms: theory**

(Yet another) holy grail for theoretical computer scientists.

Maxflow algorithms for sparse digraphs with E edges, integer capacities between 1 and U
| year | method | worst case | discovered by | 
| :--: | :--: | :--: | :--: | 
| 1951 | simplex | E<sup>3</sup> U | Dantzig |
| 1955 | augmenting path | E<sup>2</sup> U | Ford-Fulkerson |
| 1970 | shortest augmenting path | E<sup>3</sup> | Dinitz, Edmonds-Karp |
| 1970 | fattest augmenting path | E<sup>2</sup> log E log( E U ) | Dinitz, Edmonds-Karp |
| 1977 | blocking flow | E <sup>5/2</sup> | Cherkasky |
| 1978 | blocking flow | E <sup>7/3</sup> | Galil |
| 1983 | dynamic trees | E<sup>2</sup> log E | Sleator-Tarjan |
| 1985 | capacity scaling | E<sup>2</sup> log U | Gabow |
| 1997 | length function | E<sup>3/2</sup> log E log U | Goldberg-Rao |
| 2012 | compact network | E<sup>2</sup> / log E | Orlin |
| ? | ? | E | ? | 


<br/>
<div align="right">
    <b><a href="#top">↥ back to top</a></b>
</div>
<br/>


## 6. Radix Sorts