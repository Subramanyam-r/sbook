---
layout: default
title: Bubble Sort
parent: Sorting Algorithms
nav_order: 3
---

# **Bubble Sort**

### Description

* Bubble Sort is a straight forward approach using brute force.  
* It uses 2 for loops and loops through the given array and finds the least element each time and places it in the right position during each iteration.

### Algorithm

* Let us consider the following array:

	![Image]({{ site.baseurl }}/assets/images/bubble-sort/image19.png){: width="300" }

* We assign 2 pointers, i and j. Initially, pointer i starts and stays at 0 and pointer j starts at the element next to pointer i and moves to the right until it finds an element lesser than the element at i (Ei). Our aim is to detect the smallest element to the right of Element i and place it at position i. This way the least elements are accumulated at the start of the array and hence sorting the array.

* Ei \= 6	Ej \= 7	Ej \> Ei	Continue

	![Image]({{ site.baseurl }}/assets/images/bubble-sort/image28.png){: width="300" }

* Ei \= 6	Ej \= 3	Ej \< Ei	Swap i and j

![Image]({{ site.baseurl }}/assets/images/bubble-sort/image21.png){: width="650" }

* Ei \= 3	Ej \= 4	Ej \> Ei	Continue

![Image]({{ site.baseurl }}/assets/images/bubble-sort/image29.png){: width="350" }
   

* Ei \= 3	Ej \= 2	Ej \< Ei	Swap i and j

![Image]({{ site.baseurl }}/assets/images/bubble-sort/image27.png){: width="650" }

* Ei \= 2	Ej \= 9	Ej \> Ei	Continue

![Image]({{ site.baseurl }}/assets/images/bubble-sort/image17.png){: width="350" }

* Ei \= 2	Ej \= 0	Ej \< Ei	Swap i and j

![Image]({{ site.baseurl }}/assets/images/bubble-sort/image25.png){: width="650" }

* Ei \= 2	Ej \= 9	Ej \> Ei	Continue

![Image]({{ site.baseurl }}/assets/images/bubble-sort/image23.png){: width="350" }

	

* By the end of the first iteration, the element at i becomes the least number. So we increment pointer i to repeat the same process for the rest of the elements. Let’s have a look at the next iteration.

* Ei \= 7	Ej \= 6	Ej \< Ei	Swap i and j	

![Image]({{ site.baseurl }}/assets/images/bubble-sort/image20.png){: width="650" }

* Ei \= 6	Ej \= 4	Ej \< Ei	Swap i and j	

![Image]({{ site.baseurl }}/assets/images/bubble-sort/image30.png){: width="650" }

* Ei \= 4	Ej \= 3	Ej \< Ei	Swap i and j	

![Image]({{ site.baseurl }}/assets/images/bubble-sort/image18.png){: width="650" }

* Ei \= 3	Ej \= 2	Ej \< Ei	Swap i and j

![Image]({{ site.baseurl }}/assets/images/bubble-sort/image26.png){: width="650" }

* Ei \= 2	Ej \= 1	Ej \< Ei	Swap i and j	

![Image]({{ site.baseurl }}/assets/images/bubble-sort/image22.png){: width="650" }

* Now we have the second smaller number in the right position (index 1). Similarly repeating the process further until pointer i reaches the last but one element would give us the final sorted array.

![Image]({{ site.baseurl }}/assets/images/bubble-sort/image24.png){: width="300" }

### Code

```java
package com.softwarebook.sorting;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class BubbleSort {

    public static void main(String[] args) {
        int[] numbers = new int[] { 6, 0, 3, 4, 2, 9, 1, 7 };
        sort(numbers);
        log.info("Sorted Array: {}", numbers);
    }

    /**
     * This function swaps the elements in the given indices of a given array.
     *
     * @param numbers
     * @param a
     * @param b
     */
    public static void swap(int[] numbers, int a, int b) {
        log.info("Swapping numbers: {} and {} in array: {}", numbers[a], numbers[b], numbers);
        int temp = numbers[a];
        numbers[a] = numbers[b];
        numbers[b] = temp;
    }

    public static void sort(int[] numbers) {
        for (int i = 0; i < numbers.length; i++) {
            for (int j = i + 1; j < numbers.length; j++) {
                if (numbers[j] < numbers[i]) {
                    swap(numbers, i, j);
                }
            }
        }
    }

}
```