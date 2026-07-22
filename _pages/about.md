---
permalink: /
title: "Xu Chen"
seo_title: "Xu Chen | Learning-based Autonomous Systems"
description: "Xu Chen researches learning-based autonomous systems, spanning learned query optimization, transferable data and system representations, and self-learning agents."
layout: homepage
author_profile: false
---

<section class="home-hero">
  <img class="home-hero__avatar" src="{{ '/images/xuchen_profile.jpg' | absolute_url }}" alt="Xu Chen">
  <div class="home-hero__body">
    <h1 class="home-hero__name">Xu Chen</h1>
    <p class="home-hero__tagline">Ph.D. student at UESTC working on learning-based autonomous systems.</p>
    <p class="home-hero__links">
      <a href="mailto:XUCHEN.2019@outlook.com">Email</a>
      <a href="https://scholar.google.com/citations?user=i6heNjgAAAAJ&hl">Google Scholar</a>
      <a href="https://dblp.org/pid/83/6331-23.html">DBLP</a>
      <a href="https://github.com/Thisislegit">GitHub</a>
    </p>
  </div>
</section>

<section class="home-research">
  <h2>Research</h2>
  <p>I am a Ph.D. student at UESTC, advised by Prof. <a href="https://zheng-kai.com/">Kai Zheng</a>. Prof. <a href="https://ydri.uestc.edu.cn/info/1049/1041.htm">Han Su</a> was my master's advisor.</p>
  <p>I study how AI systems acquire reusable knowledge from data and interaction, make reliable decisions under real-world constraints, and continually improve after deployment. Databases are my primary testbed. My research has progressed from learning individual system decisions to learning transferable system knowledge and, finally, to building agents that act on and continually update that knowledge.</p>
  <p class="home-credibility">My work has appeared at VLDB, SIGMOD, and ICDE, and in The VLDB Journal. DBAgent has been validated in production at Huawei Cloud DWS, and I have also worked with ByteDance AI Infra and Alibaba DAMO Academy.</p>
</section>

<section class="home-themes">
  <h2>Research Themes</h2>
  <article class="home-theme">
    <h3>Learning to optimize systems.</h3>
    <p>I develop learning-based methods for query optimization, cost and cardinality estimation, data layout, and resource management while preserving the structure and reliability of mature system components.</p>
  </article>
  <article class="home-theme">
    <h3>Learning transferable representations.</h3>
    <p>I study reusable representations of data distributions, workloads, and system states that can transfer across databases and reduce the need for retraining.</p>
  </article>
  <article class="home-theme">
    <h3>Learning to act and improve.</h3>
    <p>I study tool-using agents that learn from interaction trajectories, domain knowledge, and system feedback, with a focus on agentic reinforcement learning and continual self-improvement.</p>
  </article>
</section>

<section class="home-work">
  <h2>Selected Work</h2>
  <article class="work-item">
    <h3>DBAgent — Closed-loop autonomous database operations.</h3>
    <p>DBAgent is an RL-based, tool-using agent for multi-step database diagnosis and optimization, closing the loop between system signals, actions, and feedback. It has been validated in production at Huawei Cloud DWS.</p>
  </article>
  <article class="work-item">
    <h3>LEON / LEON+ — Learning inside a mature optimizer.</h3>
    <p>LEON and LEON+ embed learning into a mature optimizer's search process to improve plan selection while preserving the optimizer's established structure.</p>
    <p class="work-item__links"><a href="https://www.vldb.org/pvldb/vol16/p2261-chen.pdf">LEON</a> · <a href="https://rdcu.be/fbDAN">LEON+</a></p>
  </article>
  <article class="work-item">
    <h3>DACE / General Cardinality Estimation — Transferable system knowledge.</h3>
    <p>DACE learns database-agnostic cost representations. My ongoing cardinality-estimation research extends this direction by exploring reusable distribution representations across databases.</p>
    <p class="work-item__links"><a href="https://ieeexplore.ieee.org/document/10598079">DACE</a></p>
  </article>
  <article class="work-item">
    <h3>Self-learning Agents — Learning from interaction.</h3>
    <p>My ongoing research studies how self-learning agents extract reusable domain knowledge and implicit world models from interaction transitions and self-exploration. At ByteDance AI Infra, I worked on rollout infrastructure for multi-tool agentic reinforcement learning.</p>
  </article>
</section>

<section class="home-publications">
  <h2>Selected Publications</h2>
    <article class="publication">
      <p class="publication__title">
        <span class="publication__bullet" aria-hidden="true">•</span>
        <span class="publication__title-text">DBAgent: An RL-Based Agent for Autonomous Database Operations and Maintenance.</span>
      </p>
      <p class="publication__authors"><strong>Xu Chen*</strong>, Junmin Chen*, Shuncheng Liu, Yuyang Xia, Zibo Liang, Xiaoming Qin, Kai Zeng, Han Su, Kai Zheng</p>
      <p class="publication__venue"><em>VLDB</em>, 2026. <small>* means equal contribution.</small></p>
    </article>
    <article class="publication">
      <p class="publication__title">
        <span class="publication__bullet" aria-hidden="true">•</span>
        <span class="publication__title-text"><a href="https://rdcu.be/fbDAN">LEON+: Towards Robust ML-aided Query Optimization.</a></span>
      </p>
      <p class="publication__authors"><strong>Xu Chen*</strong>, Ximu Zeng*, Yuze Wang, Zibo Liang, Kai Zeng, Han Su, Kai Zheng</p>
      <p class="publication__venue"><em>VLDB Journal</em>, accepted in March 2026. <small>* means equal contribution.</small></p>
    </article>
    <article class="publication">
      <p class="publication__title">
        <span class="publication__bullet" aria-hidden="true">•</span>
        <span class="publication__title-text"><a href="https://dl.acm.org/doi/10.1145/3709710">Optimizing Block Skipping for High-Dimensional Data with Learned Adaptive Curve.</a></span>
      </p>
      <p class="publication__authors"><strong>Xu Chen</strong>, Shuncheng Liu, Tong Yuan, Tao Ye, Kai Zeng, Han Su, Kai Zheng</p>
      <p class="publication__venue"><em>SIGMOD</em>, 2025.</p>
    </article>
    <article class="publication">
      <p class="publication__title">
        <span class="publication__bullet" aria-hidden="true">•</span>
        <span class="publication__title-text"><a href="https://ieeexplore.ieee.org/document/10598079">DACE: A Database-Agnostic Cost Estimator.</a></span>
      </p>
      <p class="publication__authors">Zibo Liang, <strong>Xu Chen</strong>, Yuyang Xia, Runfan Ye, Haitian Chen, Jiandong Xie, Kai Zheng</p>
      <p class="publication__venue"><em>ICDE</em>, 2024.</p>
    </article>
    <article class="publication">
      <p class="publication__title">
        <span class="publication__bullet" aria-hidden="true">•</span>
        <span class="publication__title-text"><a href="https://www.vldb.org/pvldb/vol16/p2261-chen.pdf">LEON: A New Framework for ML-Aided Query Optimization.</a></span>
      </p>
      <p class="publication__authors"><strong>Xu Chen</strong>, Haitian Chen, Zibo Liang, Shuncheng Liu, Jinghong Wang, Kai Zeng, Han Su, Kai Zheng</p>
      <p class="publication__venue"><em>VLDB</em>, 2023.</p>
    </article>
    <article class="publication">
      <p class="publication__title">
        <span class="publication__bullet" aria-hidden="true">•</span>
        <span class="publication__title-text"><a href="https://www.vldb.org/pvldb/vol16/p1958-chen.pdf">BASE: Bridging the Gap between Cost and Latency for Query Optimization.</a></span>
      </p>
      <p class="publication__authors"><strong>Xu Chen</strong>, Zhen Wang, Shuncheng Liu, Yaliang Li, Kai Zeng, Bolin Ding, Jingren Zhou, Han Su, Kai Zheng</p>
      <p class="publication__venue"><em>VLDB</em>, 2023.</p>
    </article>
  <p class="home-publications__more">Full publication list: <a href="https://scholar.google.com/citations?user=i6heNjgAAAAJ&hl">Google Scholar</a> · <a href="https://dblp.org/pid/83/6331-23.html">DBLP</a></p>
</section>
