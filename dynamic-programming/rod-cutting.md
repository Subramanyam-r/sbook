---
layout: default
title: Rod Cutting
parent: Dynamic Programming
nav_order: 1
---

# **Rod Cutting Problem** <span class="label label-green fw-500">Easy</span>

## Problem Statement

We have a rod of a given length m, And an array `prices` where each `price[i]` determines the cost of rod with length i. The aim is to find the maxmimum cost that can be earned from the given rod by cutting it and selling it as pieces. (The rod can also not be cut and sold entirely if that's more profitable.)

![Image]({{ site.baseurl }}/assets/images/rod-cutting-dp/fig1.png){: width="400" .d-block .mx-auto }

_Fig 1. Problem Visualization_{: .d-block .text-center }

## Approach

- This is a classical Dynamic programming problem.

- In dynamic programming, the aim is to divide the problem into smaller subproblems, and ultimately achieve the solution for bigger problem by utilizing the solutions of the smaller problems.

## Run-Through / Explanation

- Let's consider we had the same prices array but a rod of length 1.

![Image]({{ site.baseurl }}/assets/images/rod-cutting-dp/fig2.png){: width="400" .d-block .mx-auto }

_Fig 2. Sub Problem 1 Visualization_{: .d-block .text-center }

- Here, The obvious and only answer would be to sell the one rod as a while for `price[1]` = `1`.

- Similarly for rod of length 2,

![Image]({{ site.baseurl }}/assets/images/rod-cutting-dp/fig3.png){: width="1000" .d-block .mx-auto }

_Fig 3. Sub Problem 2 Visualization_{: .d-block .text-center }

- The possibilities are:
    - Sell it as 2 rods each of length 1 for 2 x `price[1]` = `2` OR
    - Sell it as a whole for `price[2]` = `5`

- The best case is selling the entire rod for price 5 as it's more profitable.

- Now, for rod of length 3,

![Image]({{ site.baseurl }}/assets/images/rod-cutting-dp/fig4.png){: width="1000" .d-block .mx-auto }

_Fig 4. Sub Problem 3 Visualization_{: .d-block .text-center }

- The possibilities are,
    - Sell the rod as 3 parts, each of length 1. So 3 x `price[1]` = 3
    - Sell the rod as 2 parts, one of length 2 and other of length 1 for `price[2]` + `price[1]` = 6
    - Sell the whole rod of length 3 for `price[3]` = 8

- Here, the more profitable case would be to sell the entire rod for price 8.

So the pattern here is, for a give rod of length m, we have to find all possible ways to split the rod and calculate the cost for each possibility, and choose the highest amongst them all.

But guess what?

We are not doing that because we already are calculating the answers for the sub problems along the way when we start from length m = 1.

Let's try maintaining the results of the sub problems in an array, This process is call tabulation. Storing the results of smaller sub problems in a array.

![Image]({{ site.baseurl }}/assets/images/rod-cutting-dp/fig5.png){: width="400" .d-block .mx-auto }

_Fig 5. Tabulation Array_{: .d-block .text-center }

Now for the rod of length m = 3, Let's think a bit differently.

- I can sell the rod entirely, or I can split the rod as 1/2. I don't have to consider the possibility of splitting it into 1/1/1 because I have already calculated the optimum solution (max profit) for rod of length 2. So, I can re-use that solution.

- So now, Let's do the possibilities once again:
    - Sell rod entirely of length 3: Cost is 8.
    - Split the rod as 1/2, Cost is 1 + 5(from tabulation array) = 6.

- I'll choose `8` as the solution for length m = 3.

![Image]({{ site.baseurl }}/assets/images/rod-cutting-dp/fig6.png){: width="400" .d-block .mx-auto }

_Fig 6. Tabulation Array_{: .d-block .text-center }

- Now to get a better idea, let's try for length m = 4.
    - Sell the rod as length 4: Cost is 9
    - Sell the rod as 1/3: Cost is 1 + 8 (optimum solution for 3 calculated above) = 9.
    - Sell the rod as 2/2: Cost is 5 + 5 = 10. (5 is the optimum solution for 2)

- Here, the optimal solution for 4 is to sell as 2/2 with cost of 10.

![Image]({{ site.baseurl }}/assets/images/rod-cutting-dp/fig7.png){: width="400" .d-block .mx-auto }

_Fig 7. Tabulation Array_{: .d-block .text-center }

See how it goes? We start from 1, calculate the optimum solution for each length until we reach our final length. Along the way we store the result for each length to be re-used for the calculation of solution for the higher numbers.

For a given length m, we need to calculate the possibilites: m, 1/m-1, 2/m-2, 3/m-3.....

- Let's visualize for 5 now:

![Image]({{ site.baseurl }}/assets/images/rod-cutting-dp/fig8.png){: width="400" .d-block .mx-auto }

_Fig 8. Visualization of Bigger Problems_{: .d-block .text-center }

- For length 6:

![Image]({{ site.baseurl }}/assets/images/rod-cutting-dp/fig9.png){: width="400" .d-block .mx-auto }

_Fig 9. Visualization of Bigger Problems_{: .d-block .text-center }

- For length 7:

![Image]({{ site.baseurl }}/assets/images/rod-cutting-dp/fig10.png){: width="400" .d-block .mx-auto }

_Fig 10. Visualization of Bigger Problems_{: .d-block .text-center }

- Finally, For length 8:

![Image]({{ site.baseurl }}/assets/images/rod-cutting-dp/fig11.png){: width="400" .d-block .mx-auto }

_Fig 11. Visualization of Bigger Problems_{: .d-block .text-center }

The final tabulation array looks like this:

![Image]({{ site.baseurl }}/assets/images/rod-cutting-dp/fig12.png){: width="400" .d-block .mx-auto }

_Fig 12. Visualization of Bigger Problems_{: .d-block .text-center }

- Hence the optimum solution for selling a rod of length 8 is 22.

- Note here that our aim is to calculate the maximum profit and not the splitting mechanism that results in a maximum profit, So we totally ignore the splitting ways are we are only storing the maximum profit for each length in the tabulation array.

## Code

### Tabulation / Iterative Approach

```java
class Solution {
    public int cutRod(int[] price) {
        int[] dp = new int[price.length + 1];
        dp[0] = 0;

        for(int i = 1; i <= price.length; i++) {
            dp[i] = price[i-1];
            for(int j = 1; j <= i/2; j++) {
                dp[i] = Math.max(dp[i], dp[j] + dp[i-j]);
            }
        }

        return dp[price.length];
    }
}
```

### Memoization / Recursive Approach:

```java
class Solution {

    Map<Integer, Integer> memo = new HashMap<>();

    public int cutRod(int[] price) {
        return cutRod(price, price.length);
    }

    public int cutRod(int[] price, int length) {
        if (price.length == 1) return price[0];
        if (memo.get(length) != null) return memo.get(length);

        int res = price[length - 1];
        for(int j = 1; j <= length/2; j++) {
            res = Math.max(res, cutRod(price, j) + cutRod(price, length - j));
        }
        memo.put(length, res);
        return res;
    }
}
```
