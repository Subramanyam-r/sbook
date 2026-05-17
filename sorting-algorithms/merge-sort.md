---
layout: default
title: Merge Sort
parent: Sorting Algorithms
nav_order: 2
---

# **Merge Sort**

### Description

* Before we understand Merge sort, it relies on one basic foundation \- **Merge**: Creating a sorted array from 2 given pre-sorted arrays.  
* So if we can create a logic for merging 2 pre-sorted arrays to create a final sorted array, we can recurse the array by splitting it in half and reach to the point where the array becomes empty or has one element, in which case it’s sorted and we merge the arrays from that point.  
* Let’s have a look at an example to understand this more.

### Merge Algorithm

* Before we discuss the sorting of a given array, let's understand the concept of **Merge**.  
* Let’s consider that we have 2 pre-sorted arrays and our aim here is to create one final **sorted** array by using the elements of the given pre-sorted arrays.

	![Image]({{ site.baseurl }}/assets/images/merge-sort/image16.png){: width="310" }

* Let’s declare 2 pointers, i and j, which shall traverse through Array 1 and Array 2 respectively.  
  ![Image]({{ site.baseurl }}/assets/images/merge-sort/image17.png){: width="600" }
* Now, for each iteration, we check which pointer among i and j holds the least value. In our case, pointer i holds the least value (1 \< 2), So we add element at i to the sorted array and increment pointer i.  
* We continue this process until one of i and j has reached the end of the array.  
  ![Image]({{ site.baseurl }}/assets/images/merge-sort/image9.png){: width="600" }
    
* Now, Element at j is lesser than the element at i, so we add Element at j to sorted array and increment j.

  ![Image]({{ site.baseurl }}/assets/images/merge-sort/image10.png){: width="600" }


* Ei \= 3	Ej \= 5	Ei \< Ej	Add 3 to Sorted Array		Increment i

  ![Image]({{ site.baseurl }}/assets/images/merge-sort/image12.png){: width="600" }


* Ei \= 4	Ej \= 5	Ei \< Ej	Add 4 to Sorted Array		Increment i

  ![Image]({{ site.baseurl }}/assets/images/merge-sort/image11.png){: width="600" }

* Ei \= 7	Ej \= 5	Ej \< Ei	Add 5 to Sorted Array		Increment j

  ![Image]({{ site.baseurl }}/assets/images/merge-sort/image15.png){: width="600" }


* Ei \= 7	Ej \= 6	Ej \< Ei	Add 6 to Sorted Array		Increment j

  ![Image]({{ site.baseurl }}/assets/images/merge-sort/image13.png){: width="600" }

* Now, j has reached the end of the array and gone out of array’s bound. Now we stop the iteration, and all elements remaining in the Array 1 shall be added directly to the Sorted array as they are already sorted and are greater than all the existing elements in the sorted array.  

  ![Image]({{ site.baseurl }}/assets/images/merge-sort/image8.png){: width="600" }

* In the above scenario, Array 1 only had 1 element (7) pending to be added to the Sorted array. In case there were multiple elements (Say 8, 13), they also have to be added to the final sorted array.  
* Now that both i and j have gone out of bound and we have a sorted array created with all the elements from the given pre-sorted arrays.


### Merge Sort Algorithm

* Let’s consider the following array for this example:

	![Image]({{ site.baseurl }}/assets/images/merge-sort/image19.png){: width="310" }

* Now we split that array into 2 halves:

	![Image]({{ site.baseurl }}/assets/images/merge-sort/image14.png){: width="400" }

* Using Recursion we keep splitting the subarrays into halves until we reach the length of the subarrays reaches 1 or 0, this is done so that we have 2 arrays which are sorted (arrays with 0 and 1 elements are sorted), then we start merging the arrays recursively to finally sort the entire given array.

![Image]({{ site.baseurl }}/assets/images/merge-sort/image18.png){: width="1500" }

### Code

```java
package com.softwarebook.sorting;

import lombok.extern.slf4j.Slf4j;

import java.util.Arrays;

@Slf4j
public class MergeSort {

    public static void main(String[] args) {
        int[] numbers = new int[] { 6, 3, 8, 4, 2, 9, 1, 7, 5 };
        int[] sortedArray = sort(numbers);
        log.info("Sorted Array: {}", sortedArray);
    }

    public static int[] sort(int[] numbers) {
        if (numbers.length < 2) {
            return numbers;
        }

        log.info("Merge sort for array: {}", numbers);
        int splitIndex = numbers.length / 2;

        int[] numbers1 = Arrays.copyOfRange(numbers, 0, splitIndex);
        int[] numbers2 = Arrays.copyOfRange(numbers, splitIndex, numbers.length);
        return merge(sort(numbers1), sort(numbers2));
    }

    public static int[] merge(int[] numbers1, int[] numbers2) {
        log.info("Merging sorted arrays: {} and {}", numbers1, numbers2);
        int i = 0;
        int j = 0;
        int finalArrayLength = numbers1.length + numbers2.length;
        int[] sortedArray = new int[finalArrayLength];

        while(i < numbers1.length && j < numbers2.length) {
            if (numbers1[i] < numbers2[j]) {
                sortedArray[i+j] = numbers1[i];
                i++;
            } else {
                sortedArray[i+j] = numbers2[j];
                j++;
            }
        }

        while(i < numbers1.length) {
            sortedArray[i+j] = numbers1[i];
            i++;
        }

        while(j < numbers2.length) {
            sortedArray[i+j] = numbers2[j];
            j++;
        }

        log.info("Merged Sorted array: {}", sortedArray);
        return sortedArray;
    }
}
```