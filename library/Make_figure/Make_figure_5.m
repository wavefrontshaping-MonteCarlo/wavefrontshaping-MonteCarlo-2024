function h3=  Make_figure_5(photonpars,graphicpars,Camera,option_list, enhancement_option_ens)
%% variable setting
% photonpars : variables for photons
ref_photon_num_list = photonpars.ref_photon_num_list;
signal_photon_num_list = photonpars.signal_photon_num_list;
M=photonpars.size(1);
N=photonpars.size(2);

% Camera 
Bitdepth_list = Camera.Bitdepth_list ;
Noise_list = Camera.Noise_list;
QE = Camera.QE
FW = Camera.FW

% graphicpars : variables to draw graph
markerstyle_list = graphicpars.markerstyle_list;
color_list = graphicpars.color_list;

%% Draw figure
h3=figure();
for optionindex = 1:size(option_list,2)
    for ref_index = 1: size(ref_photon_num_list,2)
        for bit_index =1:size( Bitdepth_list,2)
            for noise_index = 1:size(Noise_list,2)
                DisplayName = [ num2str(Bitdepth_list(bit_index)) 'Bit'] ;

                loglog(signal_photon_num_list(ref_index,:)*QE,squeeze(enhancement_option_ens(ref_index,:,bit_index,noise_index,optionindex)),'DisplayName',DisplayName,...
                    'Marker',markerstyle_list{noise_index},'Color',color_list{bit_index},'LineWidth',3,'MarkerSize',15 );

                xlabel(['Ensemble-averaged signal electron number, ','$\langle \overline{e_s} \rangle$'],'interpreter','Latex');ylabel('Enhancement, \eta');


                legend(Interpreter="latex")

                hold on
                set(gca,'FontSize',15);
                xlim([10^-1 10^8]./(M*N));


                ylim([4*10^-1 5*10^6]);

            end
        end
        set(gca,'FontSize',15);
        pbaspect([1 1 1]);
        title(['FW= ' num2str(FW)  'e-' ])
    end
end
end