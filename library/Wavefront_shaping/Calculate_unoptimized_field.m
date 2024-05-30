function E_unopt = Calculate_unoptimized_field(dimension,mean_signal_photon_num,ref_ens,Pin)
%function E_unopt = Calculate_unoptimized_field(dimension,mean_signal_photon_num,ref_ens)

% Inputs:
%   M,N : we assume the optical modes are arranged in two dimensions [M,N] 
%         total mode number becomes M*N, typically 10^6 where M is equal to N in this code
%   mean_signal_photon_num : the mean photon number of signal field 
%   ref_ens : the number of ensemble averaging to calculate reference intensity of enhancement
%   Pin : total incident power remains constant to calculate enhancement for both optimized and unoptimized cases.
% Outputs : 
%   E_unopt : unoptimzed field 

M= dimension(1);
N =dimension(2);
E_unopt=zeros(1,ref_ens);

A0 =  1/sqrt(M*N) * sqrt(Pin);
E_plane= ones(M,N)*A0;
disp('A0')
for index=1:ref_ens
    if(fix(index/100)==index/100)
        disp(index);
    end
    % the transmission matrix element is generated from the normal distribution N(0,<bar ns>/2) 
    % which is identical to the one used in generation of signal field. 
    t = sqrt(mean_signal_photon_num/2)*randn(M,N)+j*sqrt(mean_signal_photon_num/2)*randn(M,N);

    E_unopt(index)=sum(sum(E_plane.*t));

end

end 