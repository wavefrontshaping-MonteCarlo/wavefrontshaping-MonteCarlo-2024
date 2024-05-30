function        [h]= Phase_error_distribution_graph(photonpars,indexpars, graphicpars,Camera, phase_err_dist)     
% This function draws the probability density function(PDF) of phase measurement error.

% Inputs:
%   photonpars : variables for photons
%   indexpars : variables of indexes 
%   graphicpars : variables to draw graph
%   Camera : variables for camera.
%   phase_err_dist : the data for probability density function(PDF) of phase measurement error  

% Outputs:
%   h : the PDF of phase measurement error
%% variable setting
% photonpars : variables for photons
ref_photon_num_list= photonpars.ref_photon_num_list;
signal_photon_num_list=photonpars.signal_photon_num_list  ;

% indexpars : variables of indexes 
ref_index = indexpars.ref_index; 
sample_index = indexpars.sample_index;
bit_index =indexpars.bit_index; 
repetition = indexpars.repetition;

% graphicpars : variables to draw graph
markerstyle_list=graphicpars.markerstyle_list;
color_list=graphicpars.color_list;
NumBins=graphicpars.NumBins ;

mean_ref_photon_num = ref_photon_num_list(ref_index); 
%% title name & display name setting 
if Camera.is_camera
    % Noise_list =Camera.Noise_list;
    % Dynamic_range = Camera.Dynamic_range;   
    Bitdepth_list =Camera.Bitdepth_list;
    Bitdepth = Bitdepth_list(bit_index)
    if Bitdepth==1
        titlename = '';
    else
        titlename = [ num2str(Bitdepth) 'bit '];
    end
    titlename = [titlename '$\overline{n_{r}}$ = ' num2str(mean_ref_photon_num)  ]
    Displayname = ['$\langle \overline{n_s} \rangle$ = ',num2str(signal_photon_num_list(ref_index,sample_index)) ];

else
    titlename = [  ' $\overline{n_{r}}$ = ' num2str(mean_ref_photon_num) ]
    Displayname = [' $\langle \overline{n_s} \rangle$ = ',num2str(signal_photon_num_list(ref_index,sample_index)) ];

end


       
%% Draw the phase error distribution 
xxx = linspace(-pi,pi,NumBins);

h=figure(bit_index + ref_index + 3000);

title(titlename,'interpreter','Latex');

hold on;
for noise_index =1: size(Camera.Noise_list,2)
    p=plot(xxx,squeeze(phase_err_dist(repetition,ref_index,sample_index,noise_index,:)),'LineWidth',2,'DisplayName',Displayname,'Marker',markerstyle_list{noise_index},'Color',color_list{sample_index}, 'MarkerSize',15 );

    legend(Interpreter="latex")
    
    set(gca,'FontSize',15);
    pbaspect([1 1 1]);
    axis([-pi pi 0 1]);
    xlabel('Phase error');ylabel('Phase error distribution');
    xticks(-pi:pi/2:pi);xticklabels({'-\pi','-0.5\pi','0','0.5\pi','\pi'});legend;drawnow

end

%% figure save 
A='Pdf';

if Camera.is_camera
    filename = strcat([ A 'en' num2str(photonpars.ensemble_num_list(1)) '_' num2str(Camera.Bitdepth_list(bit_index)) 'bt' 'FW' num2str(Camera.FW)...
        'nrm' num2str(ref_photon_num_list(ref_index)) 'bin' num2str(graphicpars.NumBins) ]);
else
    filename = strcat([ A 'en' num2str(photonpars.ensemble_num_list(1)) 'nrm' num2str(ref_photon_num_list(ref_index)) 'bin' num2str(graphicpars.NumBins) ]);
end

if graphicpars.is_save && sample_index==size(signal_photon_num_list,2)
    savefig(h,[graphicpars.savefol filename datestr(now,'MMSS') '_PDF.fig'])
end

end