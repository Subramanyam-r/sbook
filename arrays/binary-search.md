---
layout: default
title: Binary Search
parent: Arrays
nav_order: 1
---

# **Binary Search** <span class="label label-green fw-500">Easy</span>

## Description

* Binary search is used to efficiently find the index of an element in a given sorted array.  
* It involves splitting the array in half and find which half contains the needed element, This divides the effort by 2 each time, giving us a time complexity of O(log n)

## Algorithm

* Let’s consider the following sorted array as an example. Our aim is to search for element 2 in the array.  
  ![Image]({{ site.baseurl }}/assets/images/binary-search/image5.png){: width="300" }
* We split the array into 2 halves by selecting the middle element of the array. Next, we check if the middle element is equal to the target (2).  
* Middle element index \= length / 2 ⇒ 8 / 2 \=  4\.  
  ![Image]({{ site.baseurl }}/assets/images/binary-search/image3.png){: width="300" }
* Here, the middle element (6) is not equal to our target (2), but the target (2) is less than the middle element (6), which means that our target will be present to the left of 6 since it's a sorted array. So we can rule out the possibility of our target (2) being present to the right of 6\. Hence, we perform the same operation on the sub array to the left of 6\.  
  ![Image]({{ site.baseurl }}/assets/images/binary-search/image2.png){: width="170" }
* Here, the middle element (3) is greater than our target (2). Hence the target is present to the left of 3\. So we can rule out 3 and the sub array to the right of 3\.

    ![Image]({{ site.baseurl }}/assets/images/binary-search/image4.png){: width="100" }

* Here, Middle element (2) is our target, hence we achieved our target in the 3rd iteration.  
* The array had 8 elements, but we were able to reduce the complexity of the problem by half each time (splitting array into half).  
* Hence the time complexity of Binary Search is O(log n)

## Code

```java
package com.softwarebook.arrayalgorithms;

import lombok.extern.slf4j.Slf4j;

import java.util.Arrays;

@Slf4j
public class BinarySearch {

    public static void main(String[] args) {
        int[] numbers = new int[]{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
        int position = binarySearch(numbers, 0, numbers.length - 1, 200);
        log.info("Position: {}", position);
    }

    public static int binarySearch(int[] numbers, int i, int j, int target) {
        log.info("Binary Search for Array: {}", Arrays.copyOfRange(numbers, i, j+1));
        int arrayLength = j - i + 1;

        // If empty array is reached, return -1 as the element is not present in the array.
        if (arrayLength == 0) return -1;

        // Initial check to see if the given target is not within the array.
        if (target < numbers[i] || numbers[j] > j) {
            return -1;
        }

        int midElementIndex = i + arrayLength / 2;
        int midElement = numbers[midElementIndex];

        // Check if the middle element is the target. Return the indext in that case.
        if (midElement == target) {
            return midElementIndex;
        }

        // Choose which half of the array to proceed with for the search
        // in case the element was not found in this iteration
        if (target < midElement) {
            return binarySearch(numbers, i, midElementIndex - 1, target);
        } else {
            return binarySearch(numbers, midElementIndex + 1, j, target);
        }
    }
}

```
