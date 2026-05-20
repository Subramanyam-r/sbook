---
layout: default
title: Rod Cutting
parent: Dynamic Programming
nav_order: 1
---

# **Rod Cutting Problem** <span class="label label-green fw-500">Easy</span>

## Problem Statement
We have a rod of a given length m, And an array `prices` where each `price[i]` determines the cost of rod with length i. The aim is to find the maxmimum cost that can be earned from the given rod by cutting it and selling it as pieces. (The rod can also not be cut and sold entirely if that's more profitable.)

![Image]({{ site.baseurl }}/assets/images/dynamic-programming/fig1.png){: width="400" .d-block .mx-auto }

*Fig 1. Problem Visualization*{: .d-block .text-center }

## Approach

* This is a classical Dynamic programming problem.

* In dynamic programming, the aim is to divide the problem into smaller subproblems, and ultimately achieve the solution for bigger problem by utilizing the solutions of the smaller problems.

* Let's consider we had the same prices array but a rod of length 1.

![Image]({{ site.baseurl }}/assets/images/dynamic-programming/fig2.png){: width="400" .d-block .mx-auto }

*Fig 1. Sub Problem Visualization*{: .d-block .text-center } 