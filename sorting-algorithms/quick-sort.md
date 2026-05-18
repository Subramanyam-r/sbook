---
layout: default
title: Quick Sort
parent: Sorting Algorithms
nav_order: 1
---

# **Quick Sort** <span class="label label-blue fw-500">Concept</span>

### Description

* Quick Sort Algorithm involves choosing a random element within a given array, which is referred to as the “Pivot” element.  
* Quick sort algorithm uses recursion, The aim of each iteration is to position the pivot element in a position in such a way that, all the elements to the left of the pivot element are smaller than the pivot and all the elements to the right of the pivot element are greater than the pivot element.  
* The recursion then continues to the left and right sub arrays of the pivot.

### Algorithm Explanation

* Let’s consider the following array as an example:   
  ![Image]({{ site.baseurl }}/assets/images/quick-sort/image19.png){: width="300" }
* Formula to determine the pivot index: **arrayLength / 2** \=\> (8 \+ 1\) / 2=4

	Pivot Element \= 5  
![Image]({{ site.baseurl }}/assets/images/quick-sort/image4.png){: width="300" }

* Swap the pivot element with the last element, this is done as a way of separating the pivot element from the rest of the elements.  
  ![Image]({{ site.baseurl }}/assets/images/quick-sort/image3.png){: width="300" }
* Array after Swap:  
  ![Image]({{ site.baseurl }}/assets/images/quick-sort/image20.png){: width="300" }

* Now, lets declare 2 pointers \=\> i, j in the following places:  
  ![Image]({{ site.baseurl }}/assets/images/quick-sort/image10.png){: width="300" }
    
* **Pointer i** moves **forwards** until it finds an element which is **greater than the pivot** (5)  
* **Pointer j** moves **backwards** until it finds an element which is **lesser than the pivot** (5)  
* **In each iteration** we **check if both i and j have found its target** as mentioned above, if not we wait until both the targets for i and j are achieved. If one target is achieved, say i, i shall wait until j achieves its target.  
* Once both **i and j have their targets, we swap these numbers.**  
* This pushes the element greater than the pivot towards the end of the array and the element lesser than the pivot towards the start of the array.  
* We keep **repeating this process until i crosses j** (Hard cross, no same position)  
* Let’s implement this on our example array.  
  ![Image]({{ site.baseurl }}/assets/images/quick-sort/image10.png){: width="300" }

* Element at i \=\> 6	Greater than Pivot (5)		Target achieved	Maintain i

* Element at j => 7	Greater than Pivot (5)		Target not achieved	Decrement j  
  ![Image]({{ site.baseurl }}/assets/images/quick-sort/image7.png){: width="300" }

* Element at i \=\> 6	Greater than Pivot (5)		Target achieved	Swap with j
* Element at j => 4	Lesser than Pivot (5)		Target achieved	Swap with i  
Now both i and j have achieved their targets, so we swap i and j.  
![Image]({{ site.baseurl }}/assets/images/quick-sort/image22.png){: width="300" }    ![Image]({{ site.baseurl }}/assets/images/quick-sort/image8.png){: width="300" }

* After Swapping, increment i, decrement j and continue the process.  
  ![Image]({{ site.baseurl }}/assets/images/quick-sort/image11.png){: width="300" }
    
    
* Element at i \=\> 1;   Lesser than Pivot (5)		Target not achieved	Increment i

* Element at j => 2;   Lesser than Pivot (5)		Target achieved	Maintain j  
	![Image]({{ site.baseurl }}/assets/images/quick-sort/image9.png){: width="300" }

* Element at i \=\> 0;   Lesser than Pivot (5)		Target not achieved	Increment i

* Element at j => 2;   Lesser than Pivot (5)		Target achieved	Maintain j  
	![Image]({{ site.baseurl }}/assets/images/quick-sort/image12.png){: width="300" }

* Element at i \=\> 9;   Greater than Pivot (5)		Target achieved	Swap with j

* Element at j => 2;   Lesser than Pivot (5)		Target achieved	Swap with i  
![Image]({{ site.baseurl }}/assets/images/quick-sort/image6.png){: width="300" }    ![Image]({{ site.baseurl }}/assets/images/quick-sort/image18.png){: width="300" }

* After swapping, increment i and decrement j.

	![Image]({{ site.baseurl }}/assets/images/quick-sort/image18.png){: width="300" }

* At this point, i has crossed j, now we know that all elements to the left of i are lesser than the pivot (5) and all elements to the right of i (inclusive of i) is greater than the pivot. So if we swap the pivot and i, we will achieve the goal of our first iteration.

![Image]({{ site.baseurl }}/assets/images/quick-sort/image17.png){: width="300" }   ![Image]({{ site.baseurl }}/assets/images/quick-sort/image13.png){: width="300" }

* From the above final array, we can observe that the elements to the left of the pivot (5) are less than the pivot and the elements to the right of the pivot are greater than the pivot. We have achieved the correct position for element 5\.  
* Now, all we need to do is perform the same operations for the left and right subarrays of the pivot using recursion.  
  ![Image]({{ site.baseurl }}/assets/images/quick-sort/image24.png){: width="300" }

* Here’s a fast forward diagram series without instructions this time:  
* Sorting of Left & Right Subarrays:

	![Image]({{ site.baseurl }}/assets/images/quick-sort/image16.png){: width="500" }

* In the left sub array above, we can observe that i and j have met but not crossed each other, at this point we check if the met element is a target of i or j, here since it’s i’s target, i stays at 3 and j moves one step back to void (-1 index).  
* In case the element 3 was a target of j (being less than the pivot 5), then i would have moved one step forward and j would have stayed at index 0\.  
* This is done to make sure that the final position of i has its target (An element greater than the pivot), this way when we swap i and pivot, we are always sure that pivot is always swapped with an element greater than itself. (Coz that’s what we want to achieve right, elements higher than pivot to the right of the pivot and vice versa)  
* The sub arrays are now fully sorted.  
* The right part of the left sub array needs to be sorted yet. Let’s see that

	(Although it's coincidentally already sorted, let’s still apply our algorithm)  
![Image]({{ site.baseurl }}/assets/images/quick-sort/image21.png){: width="250" }

* Now we combine up the sorted subarrays:

![Image]({{ site.baseurl }}/assets/images/quick-sort/image15.png){: width="400" }

* And there we have the final sorted array.

### The Cinema

* I’d like to think of Quick Sort as a war between Russia and South Korea fighting for a piece of land.  
  ![Image]({{ site.baseurl }}/assets/images/quick-sort/image14.png){: width="450" }
* We don’t want a war to start for this piece of land.  
* The International No Dispute Organisation (NDO) has taken this problem in its hands and will try its best to avoid the provocation of war.  
* NDO comes up with a plan.  
* NDO wants run a check on the given piece of land to see how many people of each of the countries are present in each of these lands and wants to draw a border at a suitable place in such a way that the people to the left of the border shall only be South Koreans and the people to the right of the border shall only be Russians.  
* The Plan:

![Image]({{ site.baseurl }}/assets/images/quick-sort/image5.png){: width="450" }

* NDO appoints 2 officers Ivan (i) and Juan (j) to go to South Korea and Russia Respectively to execute the plan.  
* NDO has also provided a Pivot device, which helps in detecting nationalities of the people and also draws the border on the map by placing it at any point in the disputed land.  
* Ivan starts from the South Korean end of the disputed land and moves towards Juan, and looks for any Russians on the way.  
* Similarly, Juan starts from the Russian end, moves towards Ivan and looks for any South Koreans on the way.  
* Ivan and Juan use the pivot device to determine the nationality of the people.  
* The pivot device has a static number on it. (Think of this as the pivot element)  
* Ivan looks for people whose identification number is greater than the pivot reading. (Russians)  
* Juan looks for the people whose identification number is less than the pivot reading. (South Koreans)  
* Once either of Ivan and Juan find their targets, they wait for their colleague to find their target.  
* Once both of them have a target, they use the pivot device to open a teleporter and swap the caught targets. This way, Russians are sent towards the Russian border (towards the right) and South Koreans are sent towards the South Korean border (towards the left).  
* If only Ivan finds a target, Ivan waits for Juan to find the target and then they swap the targets. And similarly if Juan finds a target first, he waits for Ivan to find his target.  
* This process goes on until Ivan meets Juan.  
* Ivan here is cleaning up the land closer to South Korea making sure Russians are pushed towards the Russian border and Juan does the vice versa.  
* Ideally when Ivan and Juan meet, they can be sure that they are standing right at the place where they want to draw the border.  
* Ivan places the pivot device at the meeting point and draws the border.  
* Problem solved.

### Code

```java
package com.softwarebook.sorting;

import lombok.extern.slf4j.Slf4j;

import java.util.Arrays;

@Slf4j
public class QuickSort {

    public static void main(String[] args) {
        int[] numbers = new int[]{6, 1, 0, 9, 5, 3, 7, 2};
        quickSort(numbers, 0, numbers.length - 1);
        log.info("Sorted Array: {}", numbers);
    }

    /**
     * This function swaps the elements (in-place) in the given indices of a given array.
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

    public static void quickSort(int[] numbers, int startIndex, int endIndex) {
        // Guard Clause for Recursion
        int subArrayLength = endIndex - startIndex + 1;
        if (subArrayLength <= 1) {
            return;
        }

        log.info("Quick Sort for array: {}, Full Array: {}", Arrays.copyOfRange(numbers, startIndex, endIndex + 1), numbers);

        // Declaring pointers i and j
        int i = startIndex;
        int j = endIndex - 1;

        // Choosing the Pivot Element
        int pivotIndex = startIndex + subArrayLength / 2;
        int pivotElement = numbers[pivotIndex];
        log.info("Pivot element: {}", pivotElement);

        // Keep aside the pivot element at the end of the array
        swap(numbers, pivotIndex, endIndex);

        // Traverse the pointers i and j across the array, i towards right and j towards left, until i crosses j.
        while (i <= j) {
            log.info("i: {}, j: {}", i, j);
            // Check if i is greater than pivot and j is less than the pivot.
            boolean isITargetReached = numbers[i] > pivotElement;
            boolean isJTargetReached = numbers[j] < pivotElement;

            // Swap the numbers if i is greater than pivot and j is less than pivot,
            // if not wait for both to reach its target
            if (isITargetReached && isJTargetReached) {
                swap(numbers, i, j);
                i++;
                j--;
                continue;
            }

            // Flow comes here if either of i or j has reached target
            // or
            // none has reached its target.
            // hold the number if already reached, if not traverse the pointer.
            if (!isITargetReached) {
                i++;
            }

            if (!isJTargetReached) {
                j--;
            }
        }

        // Once i has crossed j, swap i with pivot element to bring pivot
        // to the correct position in the array.
        // At this point, numbers to left of i will be smaller than pivot and
        // numbers to the right of i (inclusive of i) will be larger than the pivot.
        swap(numbers, i, endIndex);
        pivotIndex = i;

        // Recurse and sort the subarrays to the left and right of the pivot.
        quickSort(numbers, startIndex, pivotIndex - 1);
        quickSort(numbers, pivotIndex + 1, endIndex);
    }
}
```