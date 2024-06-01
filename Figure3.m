%%
clear; close all;
addpath(genpath('./library'))

%% Initialization
%% Grapical parameter 
% Number of bins for drawing probability density function (PDF) of phase measurement error
NumBins=101;
% If you want save matlab variables, set is_save as 1 otherwise 0.
is_save = 1 ;
% If you want to see the enhancement graph, set this 1 othersiwe 0.
is_enhancement_graph=1;

graphicpars = Init_Graphic_param(NumBins,is_save);

%% photon number paraemter 

% We assume the optical modes are arranged in two dimensions [M,N]. 
% Total mode number becomes M*N, typically 10^6 where M is equal to N in this code. 
M=1000;
N=M;
% Total number of phase steps. To implement four-step phase-shifting interferometry, we fixed this as 4.
K=4;

% If you want to add shot noise term on the interference pattern of phase stepping, set is_shotnoise as 1 otherwise 0.
is_shotnoise =1 ;

% Set reference  & signal photon number  
% ref_photon_num_list : the list of referece beam photon number. 
ref_photon_num_list=2500;

% signal_photon_num_list : the list of signal beam photon nubmer 
signal_photon_num_list = [0.001,	0.002, 0.005, 0.0175,	0.035,	0.1,	0.2,	0.5,	5, 25,	250,	2500];
signal_photon_num_list =repmat(signal_photon_num_list,size(ref_photon_num_list,2),1)

% ensemble_num_list : the list of number of ensemble averaging 
ensemble_num_list =  40*ones([1,size(signal_photon_num_list,2)]);
ensemble_num_list = repmat(ensemble_num_list,size(ref_photon_num_list,2),1)
photonpars = Init_Photon_param(M,N,is_shotnoise,ref_photon_num_list,signal_photon_num_list,ensemble_num_list)
%% Camera setting 
% If you want to use camera operation module set is_camera as 1 otherwise 0.
is_camera=0;
[Camera]=  Init_Camera_param(is_camera);

%% SLM operation mode for phase conjugation : (Full-complex, Phase-only, Amplitude-only) 
% option contains three SLM operation mode information. 
option = Init_SLM_operation_mode
% you can choose option_list as 1 for the full-complex, 2 for the phase-only, and 3 for the amplitude-only. 
% e.g. option_list = [1:3] means you select all the SLM operation mode.
% e.g. option_list =2 means you select phase-only SLM opertaion mode.
option_list = [1:3]
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Main loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% repetition : you can repeat the same experiment under the identical paramter setting 
% For the memory issue and calcuation time, ensemble averaging number over
% than 40 can be implemented ensemble_num_list * repetition. 
% e.g. if you want ensemble averaging 400 times, you set the repetition is [1:10] and ensemble_num is 40 which satisfy 10 * 40 = 400.
for repetition = 1:10
    indexpars.repetition=repetition ;
    savefol=['./ensemble40_0529_figure3_Pin/' , num2str(repetition) '/']
    graphicpars = Init_Graphic_param(NumBins,is_save,savefol)
    for ref_index=1:size(ref_photon_num_list,2)
       for sample_index=1:1:size(signal_photon_num_list,2)
            indexpars.ref_index = ref_index;indexpars.sample_index = sample_index;
            %% Interferometric wavefront measurement module 
            % (1) Set reference & signal photon 
            mean_ref_photon_num = ref_photon_num_list(ref_index);
            mean_signal_photon_num = signal_photon_num_list(ref_index,sample_index);
            ensemble_num= ensemble_num_list(ref_index,sample_index)

            % (2) Generate a signal field
            % The dimension of Es is [M,N,ensemble_num], and we take 
            % average on the 3rd dimension to implement ensemble-averaging operation.
            [Es] = Signal_field_generate(mean_signal_photon_num,ensemble_num,[M,N]);
            
            % (3) Calcuate a mean photon number
            [I] = Interference_generate(mean_ref_photon_num,K,Es);

            % (4) Calculate a measured photon number with shot noise
            [I_poisson] = Add_shotnoise(is_shotnoise,I);

            for bit_index = 1:size(Camera.Bitdepth_list,2)
                indexpars.bit_index=bit_index;
                for noise_index = 1 : size(Camera.Noise_list,2)
                    indexpars.noise_index = noise_index;

             % (5) Reconstruction : calculate a mesured complex amplitude                    
                    [recon_field,valuelist]=Reconstruct_signal_field(indexpars,graphicpars,Camera,I_poisson,Es);
            % Draw the PDF of phase measurement error
                    valuelist_option_rot(repetition, ref_index,sample_index,bit_index,noise_index,:) =mean(valuelist,1)./max(mean(valuelist,1));
                    h= Phase_error_distribution_graph(photonpars,indexpars, graphicpars,Camera, valuelist_option_rot);
            %% Wavefront measurement module 

                    for option_index = 1:size(option_list,2)
                        indexpars.option_index=option_index; 
                        SLM_mode = option_list(option_index);
            % (5-6) Calculate the resultant phase-conjugated field & unoptimzed field                
                        [enhancemnt]= Calculate_enhancement(recon_field,Es,SLM_mode,mean_signal_photon_num,1000);
                        enhancement_option_rot(repetition, ref_index,sample_index,bit_index,noise_index,option_index,:) =mean(enhancemnt);
            % Draw the enhancmemet ratio graph.
                        if is_enhancement_graph
                            h1 =Enhancement_graph(photonpars,indexpars, graphicpars,Camera,option{SLM_mode},enhancement_option_rot );
                        end
                        
                    end
                end
            end
        end
        clear I_poisson;
        clear h; clear h1
    end

    %% save result
    if is_save==1
        save([savefol datestr(now,'HHMMSS') 'allbit'  '.mat'],'enhancement_option_rot','M','N','photonpars',  'ref_index','signal_photon_num_list','Camera','indexpars','graphicpars','valuelist_option_rot','ref_photon_num_list','option_list','option')
          
    end
    close all;
end
%% Draw figures and save results 
%% Figure 3.a
h2 =  Make_figure_3a(photonpars,indexpars, graphicpars,Camera, valuelist_option_rot,[1 4 6 9])        
savefig(h2,[savefol  datestr(now,'HHMMSS') '_3a_ELEC' num2str(Camera.Noise_list(noise_index)) '.fig']);
   

%% Figure 3.b
enhancement_option_ens = reshape(mean(enhancement_option_rot,1), size(ref_photon_num_list,2) ,  size(Camera.Bitdepth_list,2),size(signal_photon_num_list,2), size(Camera.Noise_list,2),size(option_list,2), []) ;
    enhancement_option_ens = reshape(enhancement_option_rot(1,:,:,:,:), size(ref_photon_num_list,2) ,  size(Camera.Bitdepth_list,2),size(signal_photon_num_list,2), size(Camera.Noise_list,2),size(option_list,2), []) ;
       
    h3=Make_figure_3b(photonpars,indexpars, graphicpars,option, enhancement_option_ens)

savefig(h3,[savefol  datestr(now,'HHMMSS') '_3b_ELEC' num2str(Camera.Noise_list(noise_index)) '.fig']);
save([savefol  datestr(now,'HHMMSS') '_3_allbit_ELEC'  '.mat'],'valuelist_option_rot','enhancement_option_rot','ref_photon_num_list','signal_photon_num_list','photonpars','M','N',  'ref_index','Camera','indexpars','graphicpars','option_list','option')
   