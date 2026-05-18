---
layout: default
title: 3 Sum
parent: Two Pointers
nav_order: 1
---

# **3 Sum** <span class="label label-yellow fw-500">Medium</span>

## Problem Statement

* Given a array of positive and negative integers  
* We have to return the list all possible 3 numbers whose sum adds up to 0\.  
* Eg. For array \[-1, 0, \-2, 2, 1\] the result is \[ \[-1, 0, 1\], \[ \-2, 0, 2 \] \]  
* Expected **Time Complexity**: **O(n2)**, Expected **Space Complexity**: **O(1)**

## Algorithm Overview

* First we need to sort the given array in ascending order.  
* Once the array is sorted, we can iterate through the array with Pointer i.  
* For each i, we declare 2 more pointers L and R  
  * Pointer L \= i \+ 1  
  * Pointer R \= arrayLength \- 1  
* For each i, we check if the sum of elements at pointer i, L and R becomes zero.  
* If yes, we got a result.  
* If not:  
  * If Sum \> 0, reduce pointer R by 1, this would reduce the sum (Sorted Array)  
  * If Sum \< 0, increase pointer L by 1, this would increase the sum (Sorted Array).  
* This process is repeated for each iteration until L crosses R (L \> R).

## Example

Let us consider the following array as an example.

![Image]({{ site.baseurl }}/assets/images/3-sum/image7.png){: width="300" }

### Step 1

Firstly, we need to sort the array in ascending order.   
This would take **O(log n) or O(n2)** by using even the worst algorithm. 

* \[[Sorting Algorithms](/sorting-algorithms)\]

![Image]({{ site.baseurl }}/assets/images/3-sum/image4.png){: width="300" }

### Step 2

Iterate through the array and for each element, we need to find the combination of 2 elements that adds up to 0\.

![Image]({{ site.baseurl }}/assets/images/3-sum/image8.png){: width="450" }

We start with index i, for each i, we declare pointers L and R which move towards right and left respectively. 

* We check if the sum of elements at indices i, L, R add up to 0\. If yes, we add the elements to the result.  
* If **sum \< 0**, we **increment pointer L**, Increasing L will **increase the sum** since the array is sorted.  
* If the **sum \> 0**, we **decrement pointer R**, Decreasing R will **reduce the sum** value.

We repeat this loop for each i until pointer L crosses the pointer R.  
![Image]({{ site.baseurl }}/assets/images/3-sum/image2.png){: width="450" }

Sum is still negative, we move the pointer L towards the right to increase the sum.  
![Image]({{ site.baseurl }}/assets/images/3-sum/image10.png){: width="450" }

Sum is still negative, Moving pointer L to the right.

![Image]({{ site.baseurl }}/assets/images/3-sum/image1.png){: width="450" }

Sum is still negative, Moving pointer L to the right.

![Image]({{ site.baseurl }}/assets/images/3-sum/image12.png){: width="450" }

Here, the sum has reached 0, but Pointer L has reached Pointer R, so we can’t use this result. The result comprises 2 numbers but from the same index.

Hence we move to the next iteration by incrementing Pointer i.  
![Image]({{ site.baseurl }}/assets/images/3-sum/image6.png){: width="450" }

Here, we hit a sum of 0, so we can now add the found numbers into the result set and proceed by incrementing both pointers (L and R).

![Image]({{ site.baseurl }}/assets/images/3-sum/image11.png){: width="450" }

We have found another result, adding them to the result set.   
Incrementing both pointers (L and R).  

![Image]({{ site.baseurl }}/assets/images/3-sum/image13.png){: width="450" }

Here, L has crossed R, hence we go to the next iteration by incrementing pointer i.

![Image]({{ site.baseurl }}/assets/images/3-sum/image9.png){: width="450" }

Here, the element at i is the same as the element at i-1.  
Proceeding with this iteration will result in a duplicate result as we have already run the iteration for element at i being \-1. Hence we skip the iteration in this case.

* **Skip the iteration if arr\[i\] \== arr\[i-1\]**

![Image]({{ site.baseurl }}/assets/images/3-sum/image3.png){: width="450" }

Here, the element at i has become positive, we need at least one negative element to derive a 0 sum. It is not possible now as the element at i has become positive and also the elements after i shall also be positive (Sorted Array). So we end the iteration and return the result set at this point.

![Image]({{ site.baseurl }}/assets/images/3-sum/image5.png){: width="150" }

## Code

```java
class Solution {
    public List<List<Integer>> threeSum(int[] nums) {
        Arrays.sort(nums);

        List<List<Integer>> result = new ArrayList<>();

        for(int i = 0; i < nums.length; i++) {
            if (nums[i] > 0) break;
            if (i > 0 && nums[i] == nums[i-1]) continue;

            int l = i + 1;
            int r = nums.length - 1;

            while (l < r) {
                int sum = nums[l] + nums[r] + nums[i];
                if (sum == 0) {
                    result.add(Arrays.asList(nums[i], nums[l], nums[r]));
                    l++;
                    r--;
                    while (l < r && nums[l] == nums[l - 1]) l++;

                } else if (sum > 0) {
                    r--;
                } else if (sum < 0) {
                    l++;
                }
            }
        }

        return result;
    }
}
```