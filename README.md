# Monte Carlo simulation of interferometric measurement and wavefront shaping under influence of shot noise and camera noise 
# Abstract
Interferometry often serves as an essential building block of wavefront shaping systems to obtain optimal wavefront solutions. In this tutorial, we provide a Monte Carlo simulation tool to calculate the accuracy of interferometric measurement and its impact on wavefront shaping in the context of focusing through disordered media. In particular, we have focused on evaluating wavefront shaping fidelity under the influence of shot noise with practical considerations on the operation of digtial image sensors, including read-out and dark current noises, and digitization with finite bit-detph. Based on some exemplary simulation results, we provide practical guidance for setting up an interferometric measurement system for wavefront shaping applications.
# Overview
.
├── library                      # Function library
│   ├── Interferometry           # Interferometric wavefront measurement module
│   ├── Wavefront_shaping        # Wavefront shaping module
│   └── Make_figure              # Functions for draw each figure in paper
├── example_code                 # Example_code 
│   ├── Figure3.m                # Figure3
│   ├── Figure4.m                # Figure4
│   ├── Figure5a.m               # Figure5a
│   └── Figure5b.m               # Figure5b 
└── README.md
...
# Getting started 
## 1) Clone the repository
```
git clone https://github.com/MonteCarlo-tutorial/interferometic-measurement-wavefrontshaping-fidelity-under-noises

cd interferometic-measurement-wavefrontshaping-fidelity-under-noises
```
## 2) Run the scripts
Each matlab files reproduce the figure of the paper.

