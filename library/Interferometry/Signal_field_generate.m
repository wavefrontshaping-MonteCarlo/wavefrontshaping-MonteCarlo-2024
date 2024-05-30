function [Es] = Signal_field_generate(mean_signal_photon_num,ensemble_num,dimension)
% The complex field of each optical mode of scattered wave is the independent speckle granules. 
% The dimension of Es is [M,N,ensemble_num], and we take average on the 3rd dimension to implement ensemble-averaging operation.
% Inputs: 
%   mean_signal_photon_num : ensemble-averaged photon nubmer
%   ensemble_num : number of ensemble-averaging 
%   dimension : we assume the optical modes are arranged in two dimensions [M,N]
% Outputs: 
%   Es : the signal field which is generated from the normal distribution N(0,<bar ns>/2) 

    
M= dimension(1);
N= dimension(2);


Es = sqrt(mean_signal_photon_num/2)*randn(M,N,ensemble_num)+j*sqrt(mean_signal_photon_num/2)*randn(M,N,ensemble_num);

disp('mean signal field intensity : ')
squeeze(mean(abs(Es).^2,[1,2]))


end
