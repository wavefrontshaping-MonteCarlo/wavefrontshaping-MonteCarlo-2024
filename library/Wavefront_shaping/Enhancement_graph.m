function [h] = Enhancement_graph(photonpars,indexpars, graphicpars,Camera, option,enhancemnt )
% This function draws the enhancement graph
% Inputs:
%   photonpars : variables for photons
%   indexpars : variables of indexes 
%   graphicpars : variables to draw graph
%   Camera : variables for camera.
%   option : cell of three SLM operation mode information .
%   enhancemnt : calculated enhancement value 
% Outputs:
%   h : enhancement graph
%% variable setting
% photonpars : variables for photons
ref_photon_num_list=photonpars.ref_photon_num_list;
signal_photon_num_list=photonpars.signal_photon_num_list;
M=photonpars.size(1);
N=photonpars.size(2);

% indexpars : variables of indexes 
repetition = indexpars.repetition;
ref_index = indexpars.ref_index; 
sample_index = indexpars.sample_index;

bit_index = indexpars.bit_index;
option_index = indexpars.option_index;

Noise_list =Camera.Noise_list;
gamma = option.gamma%
mean_signal_photon_num = signal_photon_num_list(ref_index,:);
mean_ref_photon_num = ref_photon_num_list(ref_index); 
%% title name 

if Camera.is_camera
       
    Bitdepth_list =Camera.Bitdepth_list;
    Bitdepth = Bitdepth_list(bit_index)
    if Bitdepth==1
        titlename = '';
    else
        titlename = [ num2str(Bitdepth) 'bit '];
    end
    titlename = [titlename option.name]

else
    titlename = [  option.name]

end
%%

eta_theory=1./(1/(M*N)*(1+ 1/(4*mean_ref_photon_num)+1./(4*mean_signal_photon_num)));

%
for noise_index =1: size(Noise_list,2)
    h=figure(20021 + noise_index+option_index+bit_index);

    loglog(mean_signal_photon_num,eta_theory*gamma,'k','LineWidth',3);
    hold on
    loglog(mean_signal_photon_num(1:sample_index),squeeze(enhancemnt(repetition,ref_index,1:sample_index,bit_index,noise_index,option_index)),'g--+','LineWidth',3);

    set(gca,'FontSize',15);
    xlim([10^2 10^10]*1/4 *1/(M*N));
    ylim([5*10^2 5*10^6]);
    pbaspect([1 1 1]);
    xlabel(['Ensemble-averaged photon number, ','$\langle \overline{n_s} \rangle$'],'interpreter','Latex');ylabel('Enhancement, \eta');
    legend('eta theoritical','eta simulation','Location','northwest') ; hold off
    title(titlename)

end
%% save figure 
A=option.name;
if Camera.is_camera
    filename = strcat([ A(1:4) 'en' num2str(photonpars.ensemble_num_list(1)) '_' num2str(Camera.Bitdepth_list(bit_index)) 'bt' 'FW' num2str(Camera.FW)...
        'nrm' num2str(ref_photon_num_list(ref_index)) 'bin' num2str(graphicpars.NumBins) ]);
else
    filename = strcat([ A(1:4) 'en' num2str(photonpars.ensemble_num_list(1)) 'nrm' num2str(ref_photon_num_list(ref_index)) 'bin' num2str(graphicpars.NumBins) ]);
end
if graphicpars.is_save && sample_index==size(signal_photon_num_list,2)

    

    savefig(h,[graphicpars.savefol filename datestr(now,'MMSS') '_Enhance.fig'])
end
end