function        [h4]= Make_figure_4a(photonpars,graphicpars, Camera, nrm_hist,sample_range)                      
%% variable setting
% photonpars : variables for photons
ref_photon_num_list = photonpars.ref_photon_num_list;
signal_photon_num_list=photonpars.signal_photon_num_list;
alpha_list = photonpars.alpha_list;

% graphicpars : variables to draw graph
color_list=graphicpars.color_list;
Linestyle_list ={"-","--",":"}
%% Draw figure
h4=figure()
%
for ref_index =1:size(ref_photon_num_list,2)
    count =1 ;
    for sample_index =sample_range% sample

        for bit_index = 1
            for noise_index= 1:size(Camera.Noise_list,2)
                DisplayName = ['$\alpha$ = ' ,num2str(alpha_list(ref_index)) , ', ', '$\langle \overline{e_s} \rangle$=', num2str(signal_photon_num_list(ref_index,sample_index)*Camera.QE) ];

                p=plot(linspace(-pi,pi,301),   squeeze(nrm_hist(ref_index,sample_index,bit_index,noise_index, : ) ),'DisplayName',DisplayName);
                p.Color = color_list{ref_index}%color_list{sample_index}
                p.MarkerFaceColor= color_list{ref_index};
                p.MarkerSize=7;
                p.LineStyle = Linestyle_list{count};;
                p.LineWidth = 2;
                legend(Interpreter="latex")

                drawnow;
                hold on

            end
        end
        count = count +1;

    end

end
set(gca,'FontSize',15);
pbaspect([1 1 1]);
axis([-pi pi 0 1]);
xlabel('Phase error');ylabel('Phase error distribution');
xticks(-pi:pi/2:pi);xticklabels({'-\pi','-0.5\pi','0','0.5\pi','\pi'});
hl=legend;
hl.Interpreter='latex';

end