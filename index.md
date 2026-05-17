---
layout: home
title: Home
nav_order: 1
---

# Welcome to DSA Docs
{: .fs-9 }

A Comprehensive Notes of my DSA Learnings.
{: .fs-6 .fw-300 }

[View on GitHub](https://github.com/Subramanyam-r/dsa-docs){: .btn .fs-5 .mb-4 .mb-md-0 }

---

## Table of Contents

{% assign parent_pages = site.html_pages | where_exp: "item", "item.has_children == true" | sort: "nav_order" %}

{% assign parent_pages = site.html_pages | where_exp: "item", "item.has_children == true" | sort: "nav_order" %}
{% for parent in parent_pages %}

### [{{ parent.title }}]({{ parent.url | relative_url }})

{% assign child_pages = site.html_pages | where: "parent", parent.title | sort: "nav_order" %}
{% for child in child_pages %}
* [{{ child.title }}]({{ child.url | relative_url }})
{% endfor %}

{% endfor %}

---

## How to Contribute or Edit

Spot a typo or want to add a better code example? 
Every page on this site has an **"Edit this page on GitHub"** link at the bottom. Feel free to click it, make your changes in the GitHub web editor, and submit a pull request!