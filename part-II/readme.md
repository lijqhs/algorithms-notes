# Notes of Algorithms, Part II <!-- omit in toc -->



- [Undirected Graph](#undirected-graph)
  - [Introduction](#introduction)
    - [Graph applications](#graph-applications)
    - [Graph terminology](#graph-terminology)
    - [Some graph-processing problems](#some-graph-processing-problems)
  - [Graph API](#graph-api)
  - [Depth-first search](#depth-first-search)
  - [Breadth-first search](#breadth-first-search)
  - [Connected components](#connected-components)
  - [Cycle detection](#cycle-detection)
  - [Two-colorability](#two-colorability)
  - [Symbol graphs](#symbol-graphs)
  - [Challenges](#challenges)
- [Directed Graph](#directed-graph)
  - [Introduction](#introduction-1)
    - [Definition](#definition)
    - [Digraph applications](#digraph-applications)
    - [Some digraph problems](#some-digraph-problems)
  - [Digraph API](#digraph-api)
    - [Adjacency-lists digraph representation](#adjacency-lists-digraph-representation)
  - [Digraph search](#digraph-search)
    - [Reachability in digraphs](#reachability-in-digraphs)
    - [Finding paths in digraphs](#finding-paths-in-digraphs)
    - [Depth-first search in digraphs](#depth-first-search-in-digraphs)
      - [Mark-and-sweep garbage collection](#mark-and-sweep-garbage-collection)
    - [Breadth-first search in digraphs](#breadth-first-search-in-digraphs)
      - [Breadth-first search in digraphs application: web crawler](#breadth-first-search-in-digraphs-application-web-crawler)
  - [Topological sort](#topological-sort)
    - [Typical topological-sort applications](#typical-topological-sort-applications)
    - [DAG (directed acyclic graph)](#dag-directed-acyclic-graph)
  - [Strongly-connected components](#strongly-connected-components)
    - [Strong component application](#strong-component-application)
    - [API for strong components](#api-for-strong-components)
    - [Kosaraju’s algorithm](#kosarajus-algorithm)


## Undirected Graph

### Introduction

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

#### Graph applications

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

#### Graph terminology

- **Path**. Sequence of vertices connected by edges.
- **Cycle**. Path whose first and last vertices are the same.

Two vertices are connected if there is a path between them.

#### Some graph-processing problems

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


### Graph API


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

    <img src="res/adjacency-list-graph-representation.png" alt="adjacency-list-graph-representation" width="550">


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

### Depth-first search

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


### Breadth-first search

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

### Connected components

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

### Cycle detection 

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

### Two-colorability 

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

### Symbol graphs

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


<img src="res/symbol-graph-data-structures.png" alt="symbol-graph-data-structures" width="550">

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

### Challenges

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

## Directed Graph

### Introduction

#### Definition

A directed graph (or digraph) is a set of vertices and a collection of directed edges. Each directed edge connects an ordered pair of vertices.

#### Digraph applications

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

#### Some digraph problems

- **Path**. Is there a directed path from `s` to `t`?
- **Shortest path**. What is the shortest directed path from `s` to `t`?
- **Topological sort**. Can you draw a digraph so that all edges point upwards?
- **Strong connectivity**. Is there a directed path between all pairs of vertices?
- **Transitive closure**. For which vertices v and w is there a path from `v` to `w`?
- **PageRank**. What is the importance of a web page?

### Digraph API

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

#### Adjacency-lists digraph representation

<img src="res/adjacency-lists-digraph-representation.png" alt="Adjacency-lists digraph representation" width="550">

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

### Digraph search

#### Reachability in digraphs

- ***Single-source reachability***. Given a digraph and a source vertex `s`, support queries of the form *Is there a directed path from `s` to a given target vertex `v`*?
- ***Multiple-source reachability***. Given a digraph and a set of source vertices, support queries of the form *Is there a directed path from any vertex in the set to a given target vertex `v`*?

API for reachability in digraphs:

| `public class DirectedDFS` | |
| :--: | :--: |
| `DirectedDFS(Digraph G, int s)` | *find vertices in G that are reachable from `s`* |
| `DirectedDFS(Digraph G, Iterable<Integer> sources)` | *find vertices in G that are reachable from sources* |
| `boolean marked(int v)` | *is `v` reachable?* |


#### Finding paths in digraphs

*DepthFirstPaths* (Algorithm 4.1) and *BreadthFirstPaths* (Algorithm 4.2) are also fundamentally digraph-processing algorithms. 

Again, the identical APIs and code (with Graph changed to Digraph) effectively solve the following problems: 
- **Single-source directed paths**. Given a digraph and a source vertex `s`, support queries of the form *Is there a directed path from `s` to a given target vertex `v`?* If so, find such a path. 
- **Single-source shortest directed paths**. Given a digraph and a source vertex `s`, support queries of the form *Is there a directed path from `s` to a given target vertex `v`?* If so, find a shortest such path (one with a minimal number of edges).


#### Depth-first search in digraphs

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

##### Mark-and-sweep garbage collection

A mark-and-sweep garbage collection strategy reserves one bit per object for the purpose of garbage collection, then periodically marks the set of potentially accessible objects by running a digraph reachability algorithm like DirectedDFS and sweeps through all objects, collecting the unmarked ones for use for new objects.

#### Breadth-first search in digraphs

Same method as for undirected graphs.
- Every undirected graph is a digraph (with edges in both directions).
- BFS is a digraph algorithm.

**Proposition**. BFS computes shortest paths (fewest number of edges) from `s` to all other vertices in a digraph in time proportional to `E + V`.

*Multiple-source shortest paths*.  
- Given a digraph and a set of source vertices, find shortest path from any vertex in the set to each other vertex.
  - Use BFS, but initialize by enqueuing all source vertices.

##### Breadth-first search in digraphs application: web crawler

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

### Topological sort

**Precedence-constrained scheduling**. Given a set of jobs to be completed, with precedence constraints that specify that certain jobs have to be completed before certain other jobs are begun, how can we schedule the jobs such that they are all completed while still respecting the constraints?

**Goal**. Given a set of tasks to be completed with precedence constraints, in which order should we schedule the tasks?

**Digraph model**. vertex = task; edge = precedence constraint.

**[Topological sort](https://en.wikipedia.org/wiki/Topological_sorting)**. Given a digraph, put the vertices in order such that all its directed edges point from a vertex earlier in the order to a vertex later in the order (or report that doing so is not possible).

#### Typical topological-sort applications

| application | vertex | edge |
| :--: | :--: | :--: |
| job schedule | job | precedence constraint |
| course schedule | course | prerequisite |
| inheritance | Java class | extends |
| spreadsheet | cell | formula |
| symbolic links | file name | link |

#### DAG (directed acyclic graph)

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

### Strongly-connected components

*Def*. Vertices `v` and `w` are strongly connected if there is both a directed path from `v` to `w` and a directed path from `w` to `v`.

*Key property*. Strong connectivity is an equivalence relation:
- `v` is strongly connected to `v`.
- If `v` is strongly connected to `w`, then `w` is strongly connected to `v`.
- If `v` is strongly connected to `w` and `w` to `x`, then `v` is strongly connected to `x`.

*Def*. A *strong component* is a maximal subset of strongly-connected vertices.

#### Strong component application

Typical strong-component applications

| application | vertex | edge | 
| :--: | :--: | :--: |
| web | page | hyperlink | 
| textbook | topic | reference | 
| software | module | call | 
| food web | organism | predator-prey relationship | 

#### API for strong components

| `public class SCC` ||
|:--:|:--:|
| `SCC(Digraph G)` | *preprocessing constructor* |
| `boolean stronglyConnected(int v, int w)` | *are `v` and `w` strongly connected?* |
| `int count()` | *number of strong components* |
| `int id(int v)` | *component identifier for `v` (between `0` and `count()-1`)* |

#### Kosaraju’s algorithm

**Proposition H**. In a DFS of a digraph G where marked vertices are considered in reverse postorder given by a DFS of the digraph’s reverse G<sup>R</sup> (Kosaraju’s algorithm), the vertices reached in each call of the recursive method from the constructor are in a strong component. 

> Proof: First, we prove by contradiction that every vertex `v` that is strongly connected to `s` is reached by the call `dfs(G, s)` in the constructor. Suppose a vertex `v` that is strongly connected to `s` is not reached by `dfs(G, s)`. Since there is a path from `s` to `v`, `v` must have been previously marked. But then, since there is a path from `v` to `s`, `s` would have been marked during the call `dfs(G, v)` and the constructor would not call `dfs(G, s)`, a contradiction.   
> 
> Second, we prove that every vertex `v` reached by the call `dfs(G, s)` in the constructor is strongly connected to `s`. Let v be a vertex reached by the call `dfs(G, s)`. Then, there is a path from `s` to `v` in G, so it remains only to prove that there is a path from `v` to `s` in G. This statement is equivalent to saying that there is a path from `s` to `v` in G<sup>R</sup>, so it remains only to prove that there is a path from `s` to `v` in G<sup>R</sup>.   
> 
> The crux of the proof is that the reverse postorder construction implies that `dfs(G, v)` must have been done before `dfs(G, s)` during the DFS of G<sup>R</sup>, leaving just two cases to consider for `dfs(G, v)`: it might have been called 
> - before `dfs(G, s)` was called (and also done before `dfs(G, s)` was called) 
> - after `dfs(G, s)` was called (and done before `dfs(G, s)` was done) 
> 
> The first of these is not possible because there is a path from `v` to `s` in G<sup>R</sup>; the second implies that there is a path from `s` to `v` in G<sup>R</sup>, completing the proof.


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