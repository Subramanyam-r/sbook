---
layout: default
title: Top K Frequent Elements
parent: Arrays
nav_order: 4
---

# **Top K Frequent Elements** <span class="label label-yellow fw-500">Medium</span>

## Problem Statement

* Given an array with integers that can repeat, the aim is to return the top k most frequent elements from the array  
* Eg. Given array: \[1, 1, 1, 3, 3, 2, 4, 5, 5, 6, 5, 7, 5\] and k \= 2\. We have to find 2 most repeated elements, which is \[5, 1\] because 5 repeats 4 times and 1 repeats 3 times. 1 and 5 are the top 2 frequent elements.

## Algorithm

* Let us consider following array as an example  
  ![Image]({{ site.baseurl }}/assets/images/top-k-frequent-elements/image2.png){: width="400" }

* Here, 1 repeats 3 times, 2 repeats 2 times and 3 repeats 2 times. So the desired result is an array containing elements \[ 1, 2, 3 \].   
* We have to write an algorithm to try and solve this in O(n) time and O(n) space.

### Step 1

* Firstly, we need to know the frequency of each element, for this, we create a HashMap, iterate through the given array and count the frequency of each element.  
    ![Image]({{ site.baseurl }}/assets/images/top-k-frequent-elements/image11.png){: width="400" }

* Here, the key of map is the element of the array and the value is the frequency of that element.

### Step 2

* Now, we need to create a frequency array of length \= length of given array  
This frequency array will hold the elements with corresponding frequencies, eg, 1 will go in place 3 as it has a frequency of 3\.  
    ![Image]({{ site.baseurl }}/assets/images/top-k-frequent-elements/image15.png){: width="400" }

### Step 3

* Iterate through the frequency map and populate the frequency array.  
    ![Image]({{ site.baseurl }}/assets/images/top-k-frequent-elements/image3.png){: width="550" }
* Element 1 goes to position 3 as it has a frequency of 3\.

    ![Image]({{ site.baseurl }}/assets/images/top-k-frequent-elements/image5.png){: width="550" }

* Element 2 goes to position 2 as it has a frequency of 2\.

    ![Image]({{ site.baseurl }}/assets/images/top-k-frequent-elements/image14.png){: width="550" }

* Element 3 goes to position 2 since it has a frequency of 2\.

    ![Image]({{ site.baseurl }}/assets/images/top-k-frequent-elements/image10.png){: width="550" }

* Element 5 goes to position 1 since it has a frequency of 1\.

### Step 4

* Now that we have populated the frequency array, we can iterate through the array from backwards until we find k elements (3 in our case) that are of high frequency.

    ![Image]({{ site.baseurl }}/assets/images/top-k-frequent-elements/image9.png){: width="600" }

* No elements available for frequency 8\.

    ![Image]({{ site.baseurl }}/assets/images/top-k-frequent-elements/image1.png){: width="600" }

* No elements available for frequency 7\.

    ![Image]({{ site.baseurl }}/assets/images/top-k-frequent-elements/image12.png){: width="600" }

* No elements available for frequency 6\.

    ![Image]({{ site.baseurl }}/assets/images/top-k-frequent-elements/image13.png){: width="600" }

* No elements available for frequency 5\.

    ![Image]({{ site.baseurl }}/assets/images/top-k-frequent-elements/image7.png){: width="600" }

* No elements found for frequency 4\.  

    ![Image]({{ site.baseurl }}/assets/images/top-k-frequent-elements/image8.png){: width="600" }

* Element 1 found at frequency 3 (Top frequency), We add it to the result array and proceed.  

    ![Image]({{ site.baseurl }}/assets/images/top-k-frequent-elements/image6.png){: width="600" }

* Element 2, 3 found at frequency 2, we add these to the result array.  
At this point, the result array has 3 elements (k \= 3), we have top 3 frequent elements already, we can stop here and return the result.

    ![Image]({{ site.baseurl }}/assets/images/top-k-frequent-elements/image4.png){: width="150" }

## Code

```java
class Solution {
    public int[] topKFrequent(int[] nums, int k) {
        int[] result = new int[k];

        Map<Integer, Integer> map = Arrays.stream(nums)
            .boxed()
            .collect(
                Collectors.toMap(
                    e -> e,
                    e -> 1,
                    (key, dup) -> key + 1
                )
            );

        List<List<Integer>> frequencyBucket = IntStream.range(0, nums.length + 1)
            .boxed()
            .map(i -> new ArrayList<Integer>())
            .collect(Collectors.toList());
        

        map.forEach((num, freq) -> frequencyBucket.get(freq).add(num));

        System.out.println(frequencyBucket);

        int j = 0;
        for(int i = frequencyBucket.size() - 1; i > -1; i--) {
            List<Integer> freqElem = frequencyBucket.get(i);
            if (freqElem.size() == 0) continue;

            if (j == k) break;

            for (int l = 0; l < freqElem.size(); l++) {
                result[j] = freqElem.get(l);
                j++;
            }
        }

        return result;
    }
}
```