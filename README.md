# Monte Carlo simulation of interferometric measurement and wavefront shaping under influence of shot noise and camera noise 
# Abstract
Interferometry often serves as an essential building block of wavefront shaping systems to obtain optimal wavefront solutions. In this tutorial, we provide a Monte Carlo simulation tool to calculate the accuracy of interferometric measurement and its impact on wavefront shaping in the context of focusing through disordered media. In particular, we have focused on evaluating wavefront shaping fidelity under the influence of shot noise with practical considerations on the operation of digtial image sensors, including read-out and dark current noises, and digitization with finite bit-detph. Based on some exemplary simulation results, we provide practical guidance for setting up an interferometric measurement system for wavefront shaping applications.

# Overview   
    ├── library                              # Function library 
    │   ├── Interferometry                   # Interferometric wavefront measurement module
    │     ├── Initialize                     # Initialize structures (e.g. Graphic, Photon number, Camera operation, SLM operation mode)
    │     ├── Phase-shifitng interferometry  # Phase-shifting interferometry
    │   ├── Wavefront_shaping                # Wavefront shaping module
    │   └── Make_figure                      # Functions to draw each figure in paper
    └── README.md
![Figure2_0531](https://github.com/wavefrontshaping-MonteCarlo/wavefrontshaping-MonteCarlo-2024/assets/168101179/64aa346d-9b78-452c-88ac-086c96381623)
I have uploaded Matlab files to reproduce each figure from the paper. Each Matlab file is structured in the same way, consisting of the following three parts.

1) Initialization
2) Main loop
3) Draw figures and save results 
 

In the Initialization section, the user inputs the paramters and those are packed into the structures which will be used in the Main loop.
Main loop is composed of the 'Interferometric Wavefront Measure module' and the 'Wavefront Shaping module', following the sequence of the flow chart.
Interferometry folder contains the functions required for the 'Interferometric wavefront measurement module'.
- Signal_field_generate
- Interference_generate
- Add_shotnoise
- Reconstruct_signal_field
- Phase_error_distribution_graph
  
Wavefront_shaping folder contains the functions corresponding to the Wavefront shaping module, excluding any functions that are duplicated in the Interferometric Wavefront Measurement module.
- Calculate enhancement
- Calculate_unoptimized_field
- Enhancement_graph 


# Getting started 
## 1) Clone the repository
```
git clone https://github.com/wavefrontshaping-MonteCarlo/wavefrontshaping-MonteCarlo-2024.git
cd wavefrontshaping-MonteCarlo-2024/

```
## 2) Run the scripts
Each matlab files reproduce the figure of the paper.
- “Main_ShotNoiseEffect.m”: Ready-to-run code to generate the phase error distribution and the associated enhancement ratio under the effects of shot noise, without camera noises as demonstrated in Figure 3."
- “Main_StochasticCameraNoise.m”: Ready-to-run code to generate Figure 4 under the effects of shot noise and stochastic camera noises, without digitization errors.
- “Main_DigitizationEffect.m”: Ready-to-run code to generate Figure 5 under the effects of shot noise, stochastic camera noises, and digitization errors.

