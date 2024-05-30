function [enhancemnt]= Calculate_enhancement(recon_field,t_target,SLM_mode,mean_signal_photon_num,ref_ens)
% This function calcuate enhancment 
% Inputs:
%   recon_field : reconstructted the measured complex-valued field 
%   t_target : the transmission matrix element which is same as the ideal signal field 
%   SLM_mode : SLM operation mode.
%   mean_signal_photon_num : the mean photon number of signal field 
%   ref_ens : the number of ensemble averaging to calculate reference intensity of enhancement

% Outputs:
%   enhancemnt : calculated enhancement value 
%% Wavefront shaping module

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (5) Calculate the resultant phase-conjugated field 
[M,N,rep]=size(t_target);
% Pin : total incident power remains constant to calculate enhancement for both optimized and unoptimized cases.
% Note that you can set Pin as arbitray value because it will be cancelled
% when you calcuate enhancement ratio as Eq.6 in the paper. 
Pin=1 ; 
disp(['Pin=' num2str(Pin)])

if SLM_mode ==1 
        Eopt_element = conj(recon_field); 
elseif SLM_mode == 2
        Eopt_element = exp(j*angle(conj(recon_field)));
else
    each_segment_field = recon_field;
    total_field = sum(sum(each_segment_field));
    angleEin = angle(total_field .* conj(each_segment_field));
    Eopt_element=((pi/2>angleEin) & (angleEin>-pi/2));
end

E0 = sqrt(Pin ./ sum(abs(Eopt_element).^2,[1,2])) ;

E_incident = E0 .* Eopt_element;

sum(abs(E_incident).^2,[1,2]) %This should be same as Pin

for xx =1 : rep

    E_opt(xx) = sum(E_incident(:,:,xx).*t_target(:,:,xx),"all");

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (6) Calcuate the unoptimized field 
E_ref = Calculate_unoptimized_field([M,N],mean_signal_photon_num,ref_ens,Pin);

I_ref=mean(abs(E_ref).^2);

I_cen = abs(E_opt).^2 ;
enhancemnt =I_cen./I_ref;

disp(enhancemnt);
end


