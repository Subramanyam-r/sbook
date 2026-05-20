---
layout: minimal
title: Blog
nav_exclude: true
search_enabled: false
---

# Blogs

<div class="blog-timeline" style="position: relative; margin: 3rem 0; padding-left: 2rem; border-left: 2px solid var(--border-color);">
  {% for post in site.posts %}
    <!-- Calculate Reading Time -->
    {% assign words = post.content | strip_html | number_of_words %}
    {% if words < 180 %}
      {% assign read_time = "1 min" %}
    {% else %}
      {% assign minutes = words | divided_by: 180 %}
      {% assign read_time = minutes | plus: 1 | append: " mins" %}
    {% endif %}

    <div style="position: relative; margin-bottom: 2.5rem;">

      <!-- Timeline Node Dot -->
      <div style="
        position: absolute;
        left: calc(-2rem - 7px);
        top: 18px;
        width: 12px;
        height: 12px;
        border-radius: 50%;
        background-color: var(--link-color);
        border: 2px solid var(--body-background-color);
        z-index: 2;
      "></div>

      <!-- Content Container with Click Listener & Hover Highlight -->
      <div
        onclick="window.location='{{ post.url | relative_url }}';"
        style="
          display: flex;
          justify-content: space-between;
          align-items: flex-start;
          gap: 1.5rem;
          cursor: pointer;
          padding: 0.75rem 1rem;
          margin: -0.75rem -1rem;
          border-radius: 6px;
          transition: background-color 0.2s ease, box-shadow 0.2s ease;
          flex-wrap: wrap-reverse;
        "
        onmouseover="
          this.style.backgroundColor='var(--feedback-info-background-color, rgba(0, 0, 0, 0.02))';
          this.querySelector('h3 a').style.textDecoration='underline';
        "
        onmouseout="
          this.style.backgroundColor='transparent';
          this.querySelector('h3 a').style.textDecoration='none';
        "
      >
        <!-- Left Side: Text Details -->
        <div style="flex: 1; min-width: 280px; display: flex; flex-direction: column; gap: 0.25rem;">

          <!-- Metadata Row (Date & Reading Time) -->
          <div style="display: flex; gap: 1rem; align-items: center; color: var(--text-color-light); font-size: 0.85rem; font-weight: bold; letter-spacing: 0.5px; text-transform: uppercase;">
            <span>{{ post.date | date: "%B %d, %Y" }}</span>
            <span style="color: var(--border-color);">|</span>
            <span style="font-weight: normal; text-transform: none; color: var(--text-color-light); display: inline-flex; align-items: center; gap: 0.35rem;">
              <img src="/assets/images/root/clock-regular-full.svg" style="width: 1rem; height: auto; transform: translateY(-1px);">
              {{ read_time }} read
            </span>
          </div>

          <h3 style="margin: 0.25rem 0 0 0;">
            <a href="{{ post.url | relative_url }}" style="text-decoration: none; font-size: 1.3rem;">
              {{ post.title }}
            </a>
          </h3>

          <!-- Description / Excerpt Block -->
          {% if post.description %}
            <p style="margin: 0.5rem 0 0 0; color: var(--text-color-light); font-size: 0.95rem; max-width: 800px; line-height: 1.5;">
              {{ post.description }}
            </p>
          {% elsif post.excerpt %}
            <p style="margin: 0.5rem 0 0 0; color: var(--text-color-light); font-size: 0.95rem; max-width: 800px; line-height: 1.5;">
              {{ post.excerpt | strip_html | truncatewords: 20 }}
            </p>
          {% endif %}
        </div>

        <!-- Right Side: Cover Image Thumbnail -->
        {% if post.cover_image %}
        <div style="width: 140px; height: 90px; flex-shrink: 0; border-radius: 4px; overflow: hidden; border: 1px solid var(--border-color);">
          <img src="{{ post.cover_image | relative_url }}" alt="{{ post.title }}" style="width: 100%; height: 100%; object-fit: cover;">
        </div>
        {% endif %}

      </div>

    </div>

{% endfor %}

</div>
