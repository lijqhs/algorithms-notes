# Assignment Note

>Write a program to play the word game Boggle®.
>
> [The Boggle game](https://coursera.cs.princeton.edu/algs4/assignments/boggle/specification.php). Boggle is a word game designed by Allan Turoff and distributed by Hasbro. It involves a board made up of 16 cubic dice, where each die has a letter printed on each of its 6 sides. At the beginning of the game, the 16 dice are shaken and randomly distributed into a 4-by-4 tray, with only the top sides of the dice visible. The players compete to accumulate points by building valid words from the dice, according to these rules:
> - A valid word must be composed by following a sequence of adjacent dice—two dice are adjacent if they are horizontal, vertical, or diagonal neighbors.
> - A valid word can use each die at most once.
> - A valid word must contain at least 3 letters.
> - A valid word must be in the dictionary (which typically does not contain proper nouns).

see also: [Nifty Boggle](https://www-cs-faculty.stanford.edu/~zelenski/boggle/)

```
ASSESSMENT SUMMARY

Compilation:  PASSED
API:          PASSED

SpotBugs:     PASSED
PMD:          PASSED
Checkstyle:   PASSED

Correctness:  13/13 tests passed
Memory:       3/3 tests passed
Timing:       9/9 tests passed

Aggregate score: 100.00%
[ Compilation: 5%, API: 5%, Style: 0%, Correctness: 60%, Timing: 10%, Memory: 20% ]
```

From FAQ: [Possible Optimizations](https://coursera.cs.princeton.edu/algs4/assignments/boggle/faq.php)

> You will likely need to optimize some aspects of your program to pass all of the performance points (which are, intentionally, more challenging on this assignment). Here are a few ideas:
>
> - Make sure that you have implemented the critical backtracking optimization described above. This is, by far, the most important step—several orders of magnitude!
> - Think about whether you can implement the dictionary in a more efficient manner. Recall that the alphabet consists of only the 26 letters A through Z.
> - Exploit that fact that when you perform a prefix query operation, it is usually almost identical to the previous prefix query, except that it is one letter longer.
> - Consider a nonrecursive implementation of the prefix query operation.
> - Precompute the Boggle graph, i.e., the set of cubes adjacent to each cube. But don't necessarily use a heavyweight Graph object.


**Key points**:
- DFS
- Trie (26-way vs. TST)
- Prefix search (Recursive vs. Non-recursive)
- Reuse Trie search node to reduce duplicate search cost

With Modified TST and non-recursive prefix search, I still only get 98/100. May be recursive dfs can be optimized, will find out later.

```
Test 2: timing getAllValidWords() for 5.0 seconds using dictionary-yawl.txt
        (must be <= 2x reference solution)
    - reference solution calls per second: 8541.72
    - student   solution calls per second: 4007.69
    - reference / student ratio:           2.13

=> passed    student <= 10000x reference
=> passed    student <=    25x reference
=> passed    student <=    10x reference
=> passed    student <=     5x reference
=> FAILED    student <=     2x reference

Total: 8/9 tests passed!
```

With 26-way Trie, easily got 100/100.

Note: when using 26-way Trie, one should transform index of letters to be in the range of R, and remember to convert them back to letters when iterating all keys of Trie, otherwise your words would be *eaten*, lol.

```
Test 2: timing getAllValidWords() for 5.0 seconds using dictionary-yawl.txt
        (must be <= 2x reference solution)
    - reference solution calls per second: 8085.84
    - student   solution calls per second: 4446.44
    - reference / student ratio:           1.82

=> passed    student <= 10000x reference
=> passed    student <=    25x reference
=> passed    student <=    10x reference
=> passed    student <=     5x reference
=> passed    student <=     2x reference

Total: 9/9 tests passed!
```