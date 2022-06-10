# ASSESSMENT SUMMARY

[Collinear Points](https://coursera.cs.princeton.edu/algs4/assignments/collinear/specification.php)

> Write a program to recognize line patterns in a given set of points.

```
Compilation:  PASSED  
API:          PASSED  

SpotBugs:     PASSED  
PMD:          PASSED  
Checkstyle:   PASSED  

Correctness:  41/41 tests passed  
Memory:       1/1 tests passed  
Timing:       41/41 tests passed  

Aggregate score: 100.00%  
[ Compilation: 5%, API: 5%, Style: 0%, Correctness: 60%, Timing: 10%, Memory: 20% ]
```


There two problems which cost me a lot of time debugging.
## Problem 1: immutable

```
Test 10: check that data type is immutable by testing whether each method
         returns the same value, regardless of any intervening operations
  * input8.txt
    - failed after 10 operations involving BruteCollinearPoints
    - first and last call to segments() returned different arrays

    - sequence of operations was:
          BruteCollinearPoints collinear = new BruteCollinearPoints(points);
          collinear.numberOfSegments() -> 2
          mutate points[] array that was passed to constructor
          collinear.numberOfSegments() -> 2
          collinear.segments()
          mutate points[] array that was passed to constructor
          mutate points[] array that was passed to constructor
          mutate array returned by last call to segments()
          mutate array returned by last call to segments()
          collinear.segments()

    - failed on trial 1 of 100

  * equidistant.txt
    - failed after 6 operations involving BruteCollinearPoints
    - first and last call to segments() returned different arrays

    - sequence of operations was:
          BruteCollinearPoints collinear = new BruteCollinearPoints(points);
          collinear.segments()
          collinear.numberOfSegments() -> 4
          mutate array returned by last call to segments()
          collinear.numberOfSegments() -> 4
          collinear.segments()

    - failed on trial 1 of 100

==> FAILED
```

```
Test 13: check that data type is immutable by testing whether each method
         returns the same value, regardless of any intervening operations
  * input8.txt
    - failed after 4 operations involving FastCollinearPoints
    - first and last call to segments() returned different arrays
    - sequence of operations was:
          FastCollinearPoints collinear = new FastCollinearPoints(points);
          collinear.numberOfSegments() -> 2
          collinear.segments()
          collinear.segments()
    - failed on trial 1 of 100

  * equidistant.txt
    - failed after 25 operations involving FastCollinearPoints
    - first and last call to segments() returned different arrays
    - failed on trial 1 of 100

==> FAILED
```

<details>
<summary>Solution of problem 1</summary>

- make copy of input arguments in constructor
- make copy in segments before return LineSegments

</details>

## Problem 2: timing

```
Test 2a-2g: Find collinear points among the n points on an n-by-1 grid

                                                      slopeTo()
             n    time     slopeTo()   compare()  + 2*compare()        compareTo()
-----------------------------------------------------------------------------------------------
=> passed    64   0.00       15872        3968          23808                21506         
=> passed   128   0.01       64512       16128          96768               102548         
=> FAILED   256   0.01      260096       65024         390144               475849   (1.2x)
=> FAILED   512   0.06     1044480      261120        1566720              2165977   (1.5x)
=> FAILED  1024   0.34     4186112     1046528        6279168              9702565   (1.7x)
=> FAILED  2048   0.78    16760832     4190208       25141248             42999293   (2.0x)
=> FAILED  4096   2.49    67076096    16769024      100614144            189176774   (2.2x)
==> 2/7 tests passed

lg ratio(slopeTo() + 2*compare()) = lg (100614144 / 25141248) = 2.00
=> passed

==> 3/8 tests passed

Test 3a-3g: Find collinear points among the n points on an n/4-by-4 grid

                                                      slopeTo()
             n    time     slopeTo()   compare()  + 2*compare()        compareTo()
-----------------------------------------------------------------------------------------------
=> passed    64   0.00       15872       18865          53602                42684         
=> FAILED   128   0.01       64512       91492         247496               530222   (1.6x)
=> FAILED   256   0.07      260096      424573        1109242              7769725   (6.3x)
=> FAILED   512   0.60     1044480     1910779        4866038            120678887  (25.6x)
=> FAILED  1024   3.89     4186112     8498091       21182294           1916692090 (103.9x)
=> FAILED  2048  56.26    16760832    37275500       91311832          30589389601 (421.5x)
Aborting: time limit of 10 seconds exceeded

Test 4a-4g: Find collinear points among the n points on an n/8-by-8 grid

                                                      slopeTo()
             n    time     slopeTo()   compare()  + 2*compare()        compareTo()
-----------------------------------------------------------------------------------------------
=> passed    64   0.00       15872       18927          53726                34291         
=> passed   128   0.00       64512       92704         249920               383465         
=> FAILED   256   0.03      260096      436285        1132666              5343298   (3.1x)
=> FAILED   512   0.28     1044480     1990551        5025582             82416062  (12.3x)
=> FAILED  1024   3.50     4186112     8929259       22044630           1299474531  (48.9x)
=> FAILED  2048  47.51    16760832    39465490       95691812          20691603538 (195.4x)
Aborting: time limit of 10 seconds exceeded

```

<details>
<summary>Solution of problem 2</summary>

- Think about the line segment building process. The lowest end point of a line segment must be traversed in some step. So no need to add those line segment created by those point not in the end of this line segment, after sorting points on the line. So with this, no need to use loops to check duplicate, which will cost too much compareTo.
- Sort the points before process can help lower cost of compareTo with the n-by-1 grid case. Because sorted input can lower cost.

</details>


```    
Test 2a-2g: Find collinear points among the n points on an n-by-1 grid
                                                  slopeTo()
             n    time     slopeTo()   compare()  + 2*compare()        compareTo()
-----------------------------------------------------------------------------------------------
=> passed    64   0.00        4032        3968          11968                 9131         
=> passed   128   0.00       16256       16128          48512                31223         
=> passed   256   0.00       65280       65024         195328               112702         
=> passed   512   0.01      261632      261120         783872               423882         
=> passed  1024   0.05     1047552     1046528        3140608              1637706         
=> passed  2048   0.13     4192256     4190208       12572672              6427689         
=> passed  4096   0.37    16773120    16769024       50311168             25451098         
==> 7/7 tests passed

lg ratio(slopeTo() + 2*compare()) = lg (50311168 / 12572672) = 2.00
=> passed

==> 8/8 tests passed

Test 3a-3g: Find collinear points among the n points on an n/4-by-4 grid

                                                      slopeTo()
             n    time     slopeTo()   compare()  + 2*compare()        compareTo()
-----------------------------------------------------------------------------------------------
=> passed    64   0.00        4032       16222          36476                 7043         
=> passed   128   0.00       16256       58163         132582                25883         
=> passed   256   0.01       65280      152338         369956                94379         
=> passed   512   0.02      261632      546156        1353944               355311         
=> passed  1024   0.04     1047552     2080221        5207994              1370349         
=> passed  2048   0.17     4192256     8125112       20442480              5369710         
=> passed  4096   0.54    16773120    32104200       80981520             21239011         
==> 7/7 tests passed

lg ratio(slopeTo() + 2*compare()) = lg (80981520 / 20442480) = 1.99
=> passed

==> 8/8 tests passed

Test 4a-4g: Find collinear points among the n points on an n/8-by-8 grid

                                                      slopeTo()
             n    time     slopeTo()   compare()  + 2*compare()        compareTo()
-----------------------------------------------------------------------------------------------
=> passed    64   0.00        4032       17691          39414                 6363         
=> passed   128   0.00       16256       80299         176854                26112         
=> passed   256   0.00       65280      311802         688884                99427         
=> passed   512   0.02      261632      859701        1981034               378733         
=> passed  1024   0.06     1047552     3252409        7552370              1469264         
=> passed  2048   0.18     4192256    12677306       29546868              5773094         
=> passed  4096   0.70    16773120    50035440      116844000             22864641         
==> 7/7 tests passed

lg ratio(slopeTo() + 2*compare()) = lg (116844000 / 29546868) = 1.98
=> passed

==> 8/8 tests passed

Total: 31/31 tests passed!
```