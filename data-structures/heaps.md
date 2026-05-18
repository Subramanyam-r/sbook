---
layout: default
title: Heaps
parent: Data Structures
nav_order: 1
---

# **Heaps** <span class="label label-blue fw-500">Concept</span>

## Description

* Heap is a data structure built on top of a binary tree. It is a complete binary tree.  
* The main property of heap is that each node should be greater than all the children nodes under them (in case of a Max Heap).  
* There are 2 types of heaps → Min Heap, Max Heap.  
* In case of Min Heap, each node should be less than all the children nodes under them.  
* Heaps are mainly used to fetch the largest / smallest element efficiently while not sacrificing too much time in adding new elements.  
* Examples:

![Image]({{ site.baseurl }}/assets/images/heaps/image25.png){: width="1000" }

## Why Heap?

* What makes heap different from arrays is the time taken for insertion and **Removal of elements** from the array.

### Problem Statement

* Let’s consider the case where we have a set of elements.   
* I want to remove the largest element from the set, one or more than once.   
* There’s also a possibility that new elements might get added in between the removals, so it is important to be time efficient in both insertion and deletion of elements.  
* Let's consider the following set of elements and look at examples of different approaches to achieve the above task.

![Image]({{ site.baseurl }}/assets/images/heaps/image18.png){: width="350" }

### Approach 1: Plain Arrays

The first naive approach is to use a plain array, insert the elements to the end of the array and during removal, we have to traverse through the entire array and fetch the largest element.

#### **Insertion of elements**

Elements can be directly inserted into the array, the time complexity will be **O(1)** for each insertion.  

![Image]({{ site.baseurl }}/assets/images/heaps/image21.png){: width="300" }

#### **Removal of elements**

In order to remove an element, we'll need to find the largest element within the array and remove it. For this, we have to traverse through the entire array to have a track of the largest element and update it if we encounter an element that is greater than the current largest element. This would take **O(n)** time, given n is the length of the array.

Let’s start building a time complexity table to analyze the times in different approaches  

| Approach | Insertion | Deletion |
| :---: | :---: | :---: |
| Plain Arrays | O(1) | O(n) |

### Approach 2: Sorted Array

Another way to have a sorted array, that way we can get the largest element from the end of the array.

#### **Insertion of elements**

Elements need to be inserted in the correct position so that the sort of the array is maintained. In order to achieve this, we have to traverse through the entire array and place the new element in the right position, this would take **O(n)** time in the worst case, where n is the length of the array.

#### **Removal of elements**

The largest element can be accessed and removed from the end of the array using the index of the last element (length \- 1). This is straight forward and takes **O(1)** time.  

| Approach | Insertion | Deletion |
| :---: | :---: | :---: |
| Plain Arrays | O(1) | O(n) |
| Sorted Array | O(n) | O(1) |

Both of the above approaches take O(n) time either during insertion or deletion, O(n) is a bit large and we need a more optimized solution.

### Approach 3: Max Heap {#approach-3:-max-heap}

A Heap basically stores the largest element at the node of the tree, making it easily accessible.

#### **Removal of elements**

Let’s consider the following heap for demonstration:  

![Image]({{ site.baseurl }}/assets/images/heaps/image23.png){: width="350" }

* The largest element is at the root of the tree, easily accessible.  
* In a binary tree, removal can only be done from the right most child in the last level (last row).  
* So firstly, we need to swap the root element (9) with the last element of the binary tree (2).

![Image]({{ site.baseurl }}/assets/images/heaps/image15.png){: width="1000" }

* Now, element (9) can be removed from the heap. O(1) time  
* But since we replaced the root of the tree, we have to make sure the heap is maintained. (Heapify: Down-Heap)  
* For this, we compare the new root (2) with its children to see which element is greater among the root, left and right children.

![Image]({{ site.baseurl }}/assets/images/heaps/image24.png){: width="350" }

* If the root is the greatest element among the three, then the heap is maintained already, if not, we swap the root element with the greatest among left and right children, in our case, we swap the root (2) with the right child (7).

![Image]({{ site.baseurl }}/assets/images/heaps/image14.png){: width="1000" }

* Now, we repeat the process until the newly swapped element reaches its correct position.

![Image]({{ site.baseurl }}/assets/images/heaps/image19.png){: width="1000" }

* Now, the binary tree is heapified. This method of heapifying the root element to its correct position (downwards) is called heap down.  
* So, in a heap, the time taken for removal of element is O(1) \[For element removal\] plus O(log n) \[For Heapifying\], hence **O(log n)**

#### **Insertion of elements**

* In a binary tree, elements can only be inserted to the right most available position in the last level, or the first position in the next new level if the last level is full.  
* Let’s consider the same heap above and try inserting 9 back to the heap.

![Image]({{ site.baseurl }}/assets/images/heaps/image22.png){: width="1000" }

* Now, we have to heapify the heap upwards.  
* Compare the newly added element with its parent to see if the new element is greater than its parent, if so, swap the new element with its parent, if not, the heap is already heapified.

![Image]({{ site.baseurl }}/assets/images/heaps/image17.png){: width="1000" }

* Repeat the process until the newly added element reaches its correct position.

![Image]({{ site.baseurl }}/assets/images/heaps/image12.png){: width="1000" }

* The newly added element (9) has reached the root, its final position.  
* Hence, time taken for adding a new element is **O(log n)** in the worst case.

Coming back to the comparison:  

| Approach | Insertion | Deletion |
| :---: | :---: | :---: |
| Plain Arrays | O(1) | O(n) |
| Sorted Array | O(n) | O(1) |
| Max Heap | O(log n) | O(log n) |

* Max heap is efficient in both insertion and **Removal of elements** for our use case, hence we use heaps in similar situations where we need to remove the greatest or least elements when **Insertion of elements** also happens in between.


## Heap Representation

* We’ll look at how heap data structure can be implemented via code.  
* Heaps are usually represented as Arrays in the following way:

![Image]({{ site.baseurl }}/assets/images/heaps/image20.png){: width="1000" }

* Max Heap doesn’t necessarily mean that the array will be sorted in descending order and vice versa.


## Formulas

### Child of a given node

* Let’s consider the element at index 0, the children for them are elements at index 1 and 2\.  
* For elements at index 1, the children are 3 and 4\.  
* Extrapolating this:  
  * *Children of 0 → 1, 2		Children →	0 \+ 1 	       0 \+ 2*  
  * *Children of 1 → 3, 4		Children →	2(1) \+ 1      2(1) \+ 2*  
  * *Children of 2 → 5, 6		Children →	2(2) \+ 1      2(2) \+ 2*  
  * *Children of 3 → 7, 8		etc.*  
  * *Children of 4 → 9, 10*  
* We can observe a pattern here, the left child of all the nodes are a series of odd numbers and the right child are even numbers.  
* Deriving a relation with i (node’s index), the children will be   
  * Left Child	2i \+ 1  
  * Right Child	2i \+ 2

### Parent of a given node

* Let the given node be i, let the parent of the node i be p.  
* We know that the child of p is 2p+1

  ⇒ i \= 2p+1

  ⇒ p=(i-1)/2

* Hence, parent of a given node at index i is (i-1)/2

**Note:** The reason we used left child is because, when a number is divided by 2, it gets stepped down to the previous integer. If we use the right child’s index (2i \+ 2), we will have to explicitly step up the resulting parent index and that doesn’t happen by default, to avoid this extra work, we choose the left child’s index. 

For eg.   
Parent of index 1 is (1-1)/2 \= 0/2 \= 0,   
Parent of index 2 is (2-1)/2 \= 1/2 \= 0.5 ≃ 0, 

If we use Right child’s formula, the Parent’s formula becomes (i-2)/2  
Parent of index 1 is (1-2)/2 \= \-1/2 \= \-0.5   \[This has to be stepped up to 0 explicitly\]  
Parent of index 2 is (2-2)/2 \= 0/2 \= 0\.


## Heap Implementation

### [Approach 3: Max Heap](#approach-3:-max-heap)

### Code

```java
package com.softwarebook.datastructures;

import lombok.extern.slf4j.Slf4j;

import java.util.ArrayList;
import java.lang.Integer;
import java.util.Arrays;

@Slf4j
public class MaxHeap {

    ArrayList<Integer> elements;

    public static void main(String[] args) {
        MaxHeap maxHeap = new MaxHeap();
        maxHeap.enqueue(4);
        maxHeap.enqueue(10);
        maxHeap.enqueue(2);
        maxHeap.enqueue(25);
        maxHeap.enqueue(3);
        maxHeap.enqueue(17);
        maxHeap.enqueue(7);
        maxHeap.enqueue(9);

        maxHeap.dequeue();
        maxHeap.printHeapAsArray();
    }

    MaxHeap() {
        elements = new ArrayList<>();
    }

    void printHeapAsArray() {
        log.info("Heap: {}", elements);
    }

    int getLeftChildIndex(int elementIndex) {
        return (2 * elementIndex) + 1;
    }

    int getRightChildIndex(int elementIndex) {
        return (2 * elementIndex) + 2;
    }

    int getParentIndex(int elementIndex) {
        return (elementIndex - 1) / 2;
    }

    void swap(int index1, int index2) {
        int temp = elements.get(index1);
        elements.set(index1, elements.get(index2));
        elements.set(index2, temp);
    }

    void enqueue(Integer elementToEnqueue) {
        int newElementIndex = elements.size();
        elements.add(elementToEnqueue);

        while (newElementIndex > 0) {
            int parentIndex = getParentIndex(newElementIndex);
            Integer parent = elements.get(parentIndex);

            if (elementToEnqueue > parent) {
                swap(parentIndex, newElementIndex);
                newElementIndex = parentIndex;
            } else {
                break;
            }
        }
    }

    Integer dequeue() {
        int newRootIndex = elements.size() - 1;
        swap(0, newRootIndex);
        newRootIndex = 0;
        Integer elementToDequeue = elements.removeLast();

        while (getLeftChildIndex(newRootIndex) < elements.size()) {
            int leftChildIndex = getLeftChildIndex(newRootIndex);
            int rightChildIndex = getRightChildIndex(newRootIndex);
            int currentElement = elements.get(newRootIndex);
            int leftChild = elements.get(leftChildIndex);
            int rightChild = rightChildIndex < elements.size() ? elements.get(rightChildIndex) : Integer.MIN_VALUE;

            if (currentElement > leftChild && currentElement > rightChild) {
                break;
            }

            if (leftChild > rightChild) {
                swap(newRootIndex, leftChildIndex);
                newRootIndex = leftChildIndex;
            } else {
                swap(newRootIndex, rightChildIndex);
                newRootIndex = rightChildIndex;
            }
        }

        return elementToDequeue;
    }

}
```