function h3=  Make_figure_4b(photonpars,indexpars, graphicpars,Camera, enhancement_option_ens)

%% variable setting
% photonpars : variables for photons
signal_photon_num_list = photonpars.signal_photon_num_list;
alpha_list = photonpars.alpha_list;
M = photonpars.size(1);
N= photonpars.size(2);

% indexpars ; variables of indexes
bit_index = indexpars.bit_index;
noise_index = indexpars.noise_index;
option_index = indexpars.option_index;

% graphicpars : variables to draw graph
markerstyle_list = graphicpars.markerstyle_list;
color_list=graphicpars.color_list;
%% Draw figure 

sample_range = 3:size(signal_photon_num_list,2);
h3=figure();
count=1;
for ref_index =1:size(alpha_list,2)
    DisplayName = ['$\alpha$ = ' num2str(alpha_list(ref_index))  ]
    loglog(signal_photon_num_list(ref_index,sample_range) *Camera.QE ,squeeze(enhancement_option_ens(ref_index,sample_range,bit_index,noise_index ,option_index)) ,'DisplayName',DisplayName,...
        'Marker',markerstyle_list{noise_index},'Color',color_list{count},'LineWidth',3,'MarkerSize',15 );

    xlabel(['Ensemble-averaged signal electron number, ','$\langle \overline{e_s} \rangle$'],'interpreter','Latex');ylabel('Enhancement, \eta');

    legend(Interpreter="latex")

    hold on
    set(gca,'FontSize',15);
    xlim([0.5*10^1 10^9]./(M*N));
    ylim([10^1 5*10^6]);

    count=count+1
end
set(gca,'FontSize',15);
pbaspect([1 1 1]);
title(['FW= ' num2str(Camera.FW)  'e-, ' 'shot noise , readout noise'])
legend
end