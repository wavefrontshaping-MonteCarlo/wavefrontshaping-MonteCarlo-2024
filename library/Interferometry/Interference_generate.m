function [I] =Interference_generate(mean_ref_photon_num,K,Es)
% To implement four-step phase-shifting interferometry, the plane wave reference beam interferes with the signal beam.  
% Inputs:
%   mean_ref_photon_num : mean photon number of reference beam
%   K : total number of phase steps. we fixed this as  4
%   Es : a complex-valued signal field 
% Outputs:
%   I : interference for each phase step based on photon number 

[M,N,rep]=size(Es);


E0=ones(M,M)*sqrt(mean_ref_photon_num);
I=zeros(M,M,K,rep);

for index=1:K
   E0=E0*exp(j * 2*pi/K);
   I(:,:,index,:)=abs(E0+Es).^2;

end
clear E0;

