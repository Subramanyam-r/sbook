---
layout: default
title: Longest Consecutive Subsequence
parent: Arrays
nav_order: 3
---

# **\[LCS\] Longest Consecutive Subsequence** <span class="label label-yellow fw-500">Medium</span>

## Problem Statement

* Given an array, the aim is to find the longest consecutive subsequence.  
* For eg. In \[1, 3, 4, 5, 8, 0, 2\], LCS is 0, 1, 2, 3, 4, 5 ⇒ LCS is 5\.

## Algorithm

* Let us consider the following example

    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image6.png){: width="300" }

* In order to get the LCS, let's visualize the elements in an imaginary line.  
  ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image11.png){: width="450" }
    
* Here, we can observe that there are 3 possible sub sequences.  
* In order to start a new subsequence, a number should not have its previous number in the array, Eg. 2 does not have 1 in the array but 3 has 2 in the array.  
  ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image19.png){: width="450" }
* So, the aim here is to find the start of the subsequence in each iteration, and then find its length

* To achieve this, we first need to iterate through all the elements of the array and store the elements in a hashmap so that it would be easier to fetch the previous / next elements of the sequence in O(1) time.  
* Next, we iterate

    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image2.png){: width="450" }

* Here, element at i is 2, We check from the map if its previous number 1 is present or not.

    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image5.png){: width="450" }

* 1 is not present, which makes 2 as one of the start of a subsequence. Now, we check how long the subsequence goes by searching for the next elements of the sequence in the map.  
    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image14.png){: width="450" }

    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image10.png){: width="450" }
    
    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image20.png){: width="450" }
    
    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image7.png){: width="450" }
    
    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image3.png){: width="450" }
* Now we reached a point where one of the numbers in the sequence is not present in the array, so we end the iteration here, update the max lcs with current lcs, and increment i.

    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image8.png){: width="450" }

* 9 is another start of a subsequence as 8 was not present. So we check its length.  
      ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image12.png){: width="450" }
* Here, 10 is not present, which makes the length of subsequence as 1\. This is less than our current max lcs (5). We increment index i and proceed.  
    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image21.png){: width="450" }
* Element 6 cannot be the start of a sequence because its previous element 5 is present in the array. We increment index i and proceed.  

    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image4.png){: width="450" }
    
* 7 is not present, making 8 as the start of a sequence.

    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image18.png){: width="450" }

* 9 is present, making the current sequence length as 2\.  
    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image9.png){: width="450" }
* The next element of the sequence (10) is not present, hence the sequence ends with length 2\. This is still less than our current max lcs (5). We increment i and proceed.  
    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image13.png){: width="450" }
    
* 3 is present making the element 4 a part of another subsequence. We increment index i and proceed.  
    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image16.png){: width="450" }
    
* 2 is present making the element 3 a part of another subsequence. We increment index i and proceed.  
    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image1.png){: width="450" }

* 4 is present making the element 5 a part of another subsequence. We increment index i and proceed.  
    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image15.png){: width="450" }
* \-1 is not present, meaning 0 is the start of a new subsequence.  
    ![Image]({{ site.baseurl }}/assets/images/longest-consecutive-subsequence/image17.png){: width="450" }
* The next subsequence element is not present for 0, hence the length of subsequence starting with 0 is 1, which is still less than the current max lcs (5).  
* We have now reached the end of iteration, and the max lcs is 5\.

## Code

```java
class Solution {
    public int maxSubArray(int[] nums) {
        int sum = Integer.MIN_VALUE;
        int currentSum = 0;
        
        for(int i = 0; i < nums.length; i++) {
            int num = nums[i];
            currentSum += num;

            sum = Math.max(currentSum, sum);

            if (currentSum < 0) {
                currentSum = 0;
                continue;
            }
        }

        return sum;
    }
}
```