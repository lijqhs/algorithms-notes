# Assignment Note

>[Implement the Burrows–Wheeler data compression algorithm](https://coursera.cs.princeton.edu/algs4/assignments/burrows/specification.php). This revolutionary algorithm outcompresses gzip and PKZIP, is relatively easy to implement, and is not protected by any patents. It forms the basis of the Unix compression utility bzip2.
>
>The Burrows–Wheeler data compression algorithm consists of three algorithmic components, which are applied in succession:
>- Burrows–Wheeler transform. Given a typical English text file, transform it into a text file in which sequences of the same character occur near each other many times.
>- Move-to-front encoding. Given a text file in which sequences of the same character occur near each other many times, convert it into a text file in which certain characters appear much more frequently than others.
>- Huffman compression. Given a text file in which certain characters appear much more frequently than others, compress it by encoding frequently occurring characters with short codewords and infrequently occurring characters with long codewords.
>
>Step 3 is the only one that compresses the message: it is particularly effective because Steps 1 and 2 produce a text file in which certain characters appear much more frequently than others. To expand a message, apply the inverse operations in reverse order: first apply the Huffman expansion, then the move-to-front decoding, and finally the inverse Burrows–Wheeler transform. Your task is to implement the **Burrows–Wheeler** and [**move-to-front**](https://en.wikipedia.org/wiki/Move-to-front_transform#:~:text=An%20important%20use,entropy%2Dencoding%20step.) components.

```
ASSESSMENT SUMMARY

Compilation:  PASSED
API:          PASSED

SpotBugs:     PASSED
PMD:          PASSED
Checkstyle:   PASSED

Correctness:  73/73 tests passed
Memory:       10/10 tests passed
Timing:       163/163 tests passed

Aggregate score: 100.00%
[ Compilation: 5%, API: 5%, Style: 0%, Correctness: 60%, Timing: 10%, Memory: 20% ]

```

The difficult part of this assignment is to satisfy the performance requirement of `CircularSuffixArray`, which necessitates efficient [suffix sorting algorithms](https://en.wikipedia.org/wiki/Suffix_array#:~:text=suffix%20trees.-,Suffix%20sorting%20algorithms%20can%20be%20used%20to%20compute%20the%20Burrows%E2%80%93Wheeler,.,-Suffix%20arrays%20can).

> Suffix sorting algorithms can be used to compute the [Burrows–Wheeler transform (BWT)](https://en.wikipedia.org/wiki/Burrows%E2%80%93Wheeler_transform). The BWT requires sorting of all cyclic permutations of a string. If this string ends in a special end-of-string character that is lexicographically smaller than all other character (i.e., $), then the order of the sorted rotated BWT matrix corresponds to the order of suffixes in a suffix array. The BWT can therefore be computed in linear time by first constructing a suffix array of the text and then deducing the BWT string: `BWT[i]=S[A[i]-1]`.

A good way to solve suffix sorting is to use [3-way String Quicksort](https://github.com/lijqhs/algorithms-princeton/tree/main/part-II#651-3-way-string-quicksort-java-implementation).

For `MoveToFront`, first I used `ArrayList` in `decode`, but the auto grader showed that it did not reach perfect performance (failed one timing test). I tried fixed-sized array and used `System.arraycopy` instead to move character, then it passed all tests. Someone else used Linked list which was possibly also a good idea. A mentor [explained the difference](https://www.coursera.org/learn/algorithms-part2/discussions/forums/ujwo1LPrEeaDjQrM8JcKQg/threads/78xezPReEeaIjwovgVtlYg) in the discussion forum, which was helpful.

>Arrays use less memory than linked lists as a rule, because node objects and pointers overhead, and in situations with a lot of traversal, arrays are faster than lists.
>
>That's so because lists use dynamic memory, which is not sequential access and also uses dynamic memory alocation for every node, while arrays use blocks of memory. The second allows for two things - sequential access and using the faster memory of the CPU.
>
>In combination with moving whole blocks of memory with System.arraycopy, there's no way to perform faster.
>
>With system.arraycopy you avoid the index logic as well. Even more - it works faster than moving the elements one by one. Just traverse the array to find the element you're looking for.