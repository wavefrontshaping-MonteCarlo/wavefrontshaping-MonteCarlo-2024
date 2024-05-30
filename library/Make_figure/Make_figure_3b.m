function [hh]= Make_figure_3b(photonpars,indexpars, graphicpars,option, enhancement_option_ens)   

%% variable setting
% photonpars : variables for photons
ref_photon_num_list=  photonpars.ref_photon_num_list
signal_photon_num_list=photonpars.signal_photon_num_list;
M=photonpars.size(1);
N=photonpars.size(2);

% indexpars : variables of indexes
ref_index = indexpars.ref_index;
sample_index = indexpars.sample_index;

% graphicpars : variables to draw graph
color_list = graphicpars.color_list;

mean_signal_photon_num = signal_photon_num_list(ref_index,:);
mean_ref_photon_num = ref_photon_num_list(ref_index);


%%

enhancement_list_raw_list = reshape(enhancement_option_ens, size(signal_photon_num_list,2),size(option,2),[]);

plot_x = mean_signal_photon_num;
eta_theory=1./(1/(M*N)*(1+ 1/(4*mean_ref_photon_num)+1./(4*mean_signal_photon_num)));

%% Draw figure 
hh=figure( );
for option_index =1: size(option,2)

    gamma = option{option_index}.gamma%

    % % %Theortical
    % Displayname = [option{option_index}.name 'theoritical'];
    % loglog(plot_x,eta_theory*gamma,'LineWidth',3,'DisplayName',Displayname,'LineStyle','-.','Color',color_list{option_index});
    % hold on

    %Simulation
    Displayname = [option{option_index}.name ' simulation'];
    loglog(plot_x,enhancement_list_raw_list(1:size(mean_signal_photon_num,2),option_index),'LineWidth',3,'DisplayName',Displayname,'LineStyle','-','Color',color_list{option_index} );

    hold on

    %Ideal case
    Displayname = [option{option_index}.name ' ideal case'];
    yline(eta_theory(end)*gamma,'LineWidth',2.5,'DisplayName',Displayname,'LineStyle',':','Color','k' )

    set(gca,'FontSize',15);
    xlim([10^2 10^10]*1/4 *1/(M*N));
    ylim([5*10^2 5*10^6]);
    pbaspect([1 1 1]);
    xlabel(['Ensemble-averaged photon number, ','$\langle \overline{n_s} \rangle$'],'interpreter','Latex');ylabel('Enhancement, \eta');
    title(['enhancment '])
    legend

end

% enahancement ratio for full-complex modulation at low-phtoton limit.
% eta = 4 <n barns> * M
hold on
option_index=1;
x1q=linspace(plot_x(1)*1/4 , plot_x(9),1000) ;
emode= 1;
loglog(x1q,4*emode*x1q*M*N ,'LineWidth',2.5,'DisplayName','Full-complex modulation at low-phtoton limit','LineStyle',':','Color',color_list{option_index} );
end