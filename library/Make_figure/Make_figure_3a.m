function     [h]= Make_figure_3a(photonpars,indexpars, graphicpars,Camera, phase_err_dist,sample_range)        
%% variable setting
% photonpars : variables for photons
ref_photon_num_list = photonpars.ref_photon_num_list;
signal_photon_num_list=photonpars.signal_photon_num_list;%.mean_bar_n_sm_set;

% indexpars : variables of indexes 
ref_index = indexpars.ref_index; 
sample_index = indexpars.sample_index;
bit_index =indexpars.bit_index; 

% graphicpars : variables to draw graph
markerstyle_list=graphicpars.markerstyle_list;
color_list=graphicpars.color_list;
NumBins=graphicpars.NumBins ;


mean_signal_photon_num = signal_photon_num_list(ref_index,:);
mean_ref_photon_num = ref_photon_num_list(ref_index); 


xxx = linspace(-pi,pi,NumBins);

%% valuelist_option_rot(rotation, ref_index,sample_index,bit_index,noise_index,:

rotation =1 ;
result = phase_err_dist(rotation,ref_index,1:size(mean_signal_photon_num,2),:,:)

h=figure(bit_index + ref_index + 3000);


hold on;
for sampleindex = 1:size(sample_range ,2)
    for noise_index =1: size(Camera.Noise_list,2)
        Displayname = [' $<\overline{n_{s}}>$ = ',num2str(signal_photon_num_list(ref_index,sample_range(sampleindex))) ];

        p=plot(xxx,squeeze(phase_err_dist(rotation,ref_index,sample_range(sampleindex),noise_index,:)),'LineWidth',2,'DisplayName',Displayname,'Marker',markerstyle_list{noise_index},'Color',color_list{sampleindex}, 'MarkerSize',15 );

        legend(Interpreter="latex")

        set(gca,'FontSize',15);
        pbaspect([1 1 1]);
        axis([-pi pi 0 1]);
        xlabel('Phase error');ylabel('Phase error distribution');
        xticks(-pi:pi/2:pi);xticklabels({'-\pi','-0.5\pi','0','0.5\pi','\pi'});legend;drawnow


    end
end
end