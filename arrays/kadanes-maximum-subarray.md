---
layout: default
title: Kadane's Maximum Subarray
parent: Arrays
nav_order: 2
---


# **Kadane’s Maximum Subarray Algorithm** <span class="label label-yellow fw-500">Medium</span>

## Description

* Given an array of integers, This algorithm is used to find a subarray with the maximum sum.  
* The brute force approach to solve this problem requires O(n^2) time. Kedane’s algorithm only uses **O(n)** time, where n is the length of the array.  
* Technically, introduction of negative elements into an array is where we need this algorithm, if only positive elements are present, the maximum sub array would be the entire array.

## Algorithm

* Let’s consider the following array.  
  ![Image]({{ site.baseurl }}/assets/images/kadanes-maximum-subarray/image13.png){: width="300" }
* Let’s declare 2 pointers, i, j, which are initially at 0\.  
* Let’s also have a variable to track the current subArray sum.  
* Lets have another array with 3 elements, which holds the maximum subarray’s indices, followed by the sum of that maximum sub array. Initially, this array shall have the values \[0, 0, Integer.MINVALUE\]

    ![Image]({{ site.baseurl }}/assets/images/kadanes-maximum-subarray/image7.png){: width="400" }

* Now, we add the element at j to the current subarray sum, ⇒ current subarray sum \= 0 \+ 2 \= 2\. Now we compare the current subarray sum with maxSubarray sum, if the current subarray sum is greater than the max Subarray sum, we replace i, j, sum with the current values.  
  ![Image]({{ site.baseurl }}/assets/images/kadanes-maximum-subarray/image4.png){: width="400" }
* For the next iteration we increment j. The current subarray sum has become 2 \+ 3 \= 5, which is greater than the max subarray sum. So we replace i, j, sum with current values.  
  ![Image]({{ site.baseurl }}/assets/images/kadanes-maximum-subarray/image11.png){: width="400" }

* Now, we increment j.  
  ![Image]({{ site.baseurl }}/assets/images/kadanes-maximum-subarray/image5.png){: width="400" }
* Here, current sub array sum \= previous sum \+ element at  j \= 5 \+ (-6) \= \-1. The sub array sum has reached a negative value, which means that, if we try to include this subarray until now (index 0 to index 2\) in our final result, it’s just going to add a negative value and reduce the final sum, so we slice off this part by changing i to the index 3 (j \+ 1\)  
  ![Image]({{ site.baseurl }}/assets/images/kadanes-maximum-subarray/image8.png){: width="400" }
* Current sub array sum above is 1, which is less than our current max sub array sum, so we proceed by incrementing j.  
  ![Image]({{ site.baseurl }}/assets/images/kadanes-maximum-subarray/image10.png){: width="400" }
* Here, the current sub array sum becomes previous \+ element at j \= 1 \+ 5 \= 6, which is greater than the current maximum sub array sum, so we update i, j, sum with the current values, and proceed to increment j.  
  ![Image]({{ site.baseurl }}/assets/images/kadanes-maximum-subarray/image6.png){: width="400" }
* Here, current sub array sum once again beats max sub array sum, so we update the values of i, j, sum and proceed with the rest of the iteration.  
  ![Image]({{ site.baseurl }}/assets/images/kadanes-maximum-subarray/image9.png){: width="400" }
* The current subarray sum has become 14, which is less than the current max subarray sum, so we proceed without updating anything by incrementing j.  
  ![Image]({{ site.baseurl }}/assets/images/kadanes-maximum-subarray/image12.png){: width="400" }
* When j hits 7, the max sub array becomes 18, so we update the values, and the iteration ends here. The final maximum sum and the start and end indices of the max subarray can be found in the \[Max Subarray i, j, sum\] array in the above image.  
* The main logic here is to cut off the array if we encounter a negative sum as it wont do any good. And keep tracking the max sub array sum and the indices until we iterate through the entire array.  
* Time Complexity: **O(n)**

### Code

```java
package com.softwarebook.arrayalgorithms;

import lombok.extern.slf4j.Slf4j;

import java.util.Arrays;

@Slf4j
public class KadaneMaximumSubarray {

    public static void main(String[] args) {
        int[] numbers = new int[] {2, 3, -6, 1, 5, 9, -1, 4};
        int[] maxSubarrayIndicesAndSum = maximumSubarray(numbers);
        log.info("Max Sum: {}, Subarray Indices: {}, {}", maxSubarrayIndicesAndSum[2], maxSubarrayIndicesAndSum[0],
                maxSubarrayIndicesAndSum[1]);
    }

    public static int[] maximumSubarray(int[] numbers) {
        // Result: i, j, sum
        int[] maxSubarrayIndicesAndSum = new int[]{ 0, 0, Integer.MIN_VALUE };

        // Pointers
        int i = 0;
        int j = 0;

        // Sum to track in each iteration
        int currentSubarraySum = 0;

        while (j < numbers.length) {
            // update the current sub array sum.
            currentSubarraySum += numbers[j];
            log.info("Interation Log | currentSubarray: {}, currentSubArraySum: {}, maxSubarrayIndicesAndSum: {}",
                    Arrays.copyOfRange(numbers, i, j+1), currentSubarraySum, maxSubarrayIndicesAndSum);

            // If current sub array sum goes negative, slice off that bit and start a fresh array.
            if (currentSubarraySum < 0) {
                log.info("Current SubArray sum has gone negative: {}, incrementing i to {}", currentSubarraySum, j+1);
                i = ++j;
                currentSubarraySum = 0;
                continue;
            }

            // If a new max subarray sum is detected, update the result.
            if (currentSubarraySum > maxSubarrayIndicesAndSum[2]) {
                maxSubarrayIndicesAndSum[0] = i;
                maxSubarrayIndicesAndSum[1] = j;
                maxSubarrayIndicesAndSum[2] = currentSubarraySum;
                log.info("Max Subarray detected, updated result: {}", maxSubarrayIndicesAndSum);
            }

            // Increment j for the next iteration
            j++;
        }

        return maxSubarrayIndicesAndSum;
    }
}
```