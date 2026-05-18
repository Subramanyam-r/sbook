---
layout: default
title: Linked List
nav_order: 6
has_children: true
---

# **Linked List** <span class="label label-blue fw-500">Concept</span>

* Linked List is a linear data structure. Unlike an array which stores its elements in a contiguous block of memory, Linked list stores its elements in different locations in the memory.

* Each element of a Linked List is stored in a Node. A Node has 2 fields in it. One field for storing the value of the element, and the next field for storing the address of the next element in the Linked List.

* One advantage of Linked List is that the size of it can be larger when compared to arrays as we don't need a contiguous block of memory and elements are stored in random addresses and we just store those addresses along with the value of the elements.

	![Image]({{ site.baseurl }}/assets/images/linked-list/fig1.png){: width="600" }

*Fig 1. Pictorial Representation of a Linked List*{: .d-block .text-center }

### Code Representation of a Node:

```java
public class Node {
    private int value;
    private Node next;
}
```

* Here `value` field holds the actual value of the element, eg. 1 and `next` field points to the next node. 

* In order to have a linked list inside a variable, we just need to have the address of the starting element (usually called as head). By having the address of head, we can traverse and reach any element within the list by going to the next address of each node.

* The `next` field for the last element in the linked list will be `null`. This marks the end of the linked list.

	![Image]({{ site.baseurl }}/assets/images/linked-list/fig2.png){: width="600" }

*Fig 2. Linked List Representation with nodes*{: .d-block .text-center }

### Time Complexity Analysis


