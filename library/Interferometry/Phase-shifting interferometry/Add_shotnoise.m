function [I_poisson] = Add_shotnoise(is_shotnoise,I)
% This function generatees a measured photon number, with random number generators for Poisson distribution.
% Inputs:
%   is_shotnoise : if you want to add shot noise term set 1 otherwise 0
%   I : a mean photon number which is calculated from the interference
% Outputs:
%   I_poisson : a measured photon number with random number generators for Poisson distribution
if is_shotnoise
    I_poisson = poissrnd(I(:,:,:,:));
else

    I_poisson = I(:,:,:,:);
    disp('no shot noise ')
end


end

