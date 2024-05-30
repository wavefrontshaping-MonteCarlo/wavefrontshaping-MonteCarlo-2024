function photonpars =  Init_Photon_param(M,N,is_shotnoise, ref_photon_num_list,signal_photon_num_list,ensemble_num_list,alpha_list)
% This function ininialize photon paramters 
% Inputs:
%   M,N : we assume the optical modes are arranged in two dimensions [M,N] 
%         total mode number becomes M*N, typically 10^6 where M is equal to N in this code
%   is_shotnoise : if you want to add shot noise term on the interference pattern of phase stepping, 
%                  set is_shotnoise as 1 otherwise 0.
%   ref_photon_num_list : the list of referece beam photon number 
%   signal_photon_num_list : the list of signal beam photon nubmer 
%   ensemble_num_list : the list of number of ensemble averaging 
%   alpha_list : the list of factor alpha 
%                the reference beam is set to the level reduced by the factor alpha relative to FW
% 
% Outputs:
%   photonpars : structure of photon parameters

photonpars.size =[M,N];
photonpars.is_shotnoise = is_shotnoise;
photonpars.ref_photon_num_list= ref_photon_num_list;
photonpars.signal_photon_num_list=signal_photon_num_list;
photonpars.ensemble_num_list = ensemble_num_list;
if nargin>=7
    photonpars.alpha_list = alpha_list;

end

end