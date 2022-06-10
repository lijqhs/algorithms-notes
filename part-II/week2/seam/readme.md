# ASSESSMENT SUMMARY

[Seam Carving](https://coursera.cs.princeton.edu/algs4/assignments/seam/specification.php)

> Seam-carving is a content-aware image resizing technique where the image is reduced in size by one pixel of height (or width) at a time. A vertical seam in an image is a path of pixels connected from the top to the bottom with one pixel in each row; a horizontal seam is a path of pixels connected from the left to the right with one pixel in each column. Below left is the original 505-by-287 pixel image; below right is the result after removing 150 vertical seams, resulting in a 30% narrower image. Unlike standard content-agnostic resizing techniques (such as cropping and scaling), seam carving preserves the most interest features (aspect ratio, set of objects present, etc.) of the image.
> 
> Although the [underlying algorithm](https://www.youtube.com/watch?v=6NcIJXTlugc) is simple and elegant, it was not discovered until 2007. Now, it is now a core feature in Adobe Photoshop and other computer graphics applications.


```
Compilation:  PASSED
API:          PASSED

SpotBugs:     PASSED
PMD:          PASSED
Checkstyle:   PASSED

Correctness:  34/34 tests passed
Memory:       6/6 tests passed
Timing:       18/17 tests passed

Aggregate score: 101.18%
[ Compilation: 5%, API: 5%, Style: 0%, Correctness: 60%, Timing: 10%, Memory: 20% ]
```

<details>
<summary>Basic solution idea.</summary>

- For horizontal case, add two virtual vertex in the left and right. Connect pixel from left to right.
- left vertex connected to every pixel in the column 0, energy as weights of edges; right vertex connected from every pixel in the column width-1, 0 as weights.
- every pixel point to three pixels in the next column, except topmost and bottommost which connect to two pixels, energy as weights of edges.
- find the shortest path from left to right vertex with `AcyclicSP`

</details>

NOTE: can be optimized without creating `EdgeWeightedDigraph` or `DirectedEdge` objects. use implicit digraph.

```
% custom checkstyle checks for SeamCarver.java
*-----------------------------------------------------------
[WARN] SeamCarver.java:157:9: Your program will likely be faster if you use an implicit digraph instead of creating an object of type 'EdgeWeightedDigraph'. [Performance]
[WARN] SeamCarver.java:225:9: Your program will likely be faster if you use an implicit digraph instead of creating an object of type 'EdgeWeightedDigraph'. [Performance]
Checkstyle ends with 0 errors and 2 warnings.
```

> Performance requirements. The width(), height(), and energy() methods should take constant time in the worst case. All other methods should run in time at most proportional to width × height in the worst case. **For faster performance, do not construct explicit DirectedEdge and EdgeWeightedDigraph objects.**


<details>
<summary>Optimized solution idea.</summary>

- do not create Digraph objects
- use implicit digraph
- use the topological sort
- the analogue idea with *AcyclicSP*

</details>


```
Tests 7a-7c: time findHorizontalSeam(), removeHorizontalSeam(), findVerticalSeam(),
             and removeVerticalSeam() for a given 736-by-584 picture
  * student   solution calls per second:       8.47
  * reference solution calls per second:       4.54
  * reference / student ratio:                 0.54

=> passed      student <= 150.0x reference
=> passed      student <=  15.0x reference
=> passed      student <=   1.5x reference
=> optimized   student <=   0.8x reference

Total: 18/17 tests passed!
```