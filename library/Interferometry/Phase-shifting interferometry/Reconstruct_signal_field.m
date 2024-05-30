function [recon_field,phase_err_dist] = Reconstruct_signal_field(indexpars,graphicpars,Camera,I_poisson,Es)
% This function implements the reconstruction of the signal field. 
% If you want to use camera module, you already set the Camera.is_camera as 1, then you will follow the camera operaton module. 
% is_readnoise : You can select the effect of stochastic camera noises by set this as 1. The result is explained in chapter 4.2.
% is_digitization : You can select the effect of digitization by set the as 1. The result is explained in chapter 4.3. 
% Finally you will reconstruct the signal field based on the digital number.
% If you don't want to use camera module,you will reconstruct the signal field based on the photon number.

% Inputs:
%   indexpars : variables of indexes 
%   graphicpars : variables to draw graph
%   Camera : variables for camera. 
%   I_poisson : a measured photon number with random number generators for Poisson distribution
%   Es : the signal field which is generated from the normal distribution N(0,<bar ns>/2) 

% Outputs:
%   recon_field : reconstructted the measured complex-valued field 
%   phase_err_dist : the data for probability density function(PDF) of phase measurement error  


%% variable setting
% indexpars : variables of indexes 
noise_index = indexpars.noise_index;
bit_index = indexpars.bit_index;

% graphicpars : variables to draw graph
NumBins=graphicpars.NumBins ;
NumBinEdges=NumBins+1;

%% Camera opertaion module : chapter 4.1

%variables for camera
is_camera = Camera.is_camera ;

if is_camera
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % (1) Setting the five independent variables for camera operation
    g=Camera.g;
    QE = Camera.QE;
    Noise_list=Camera.Noise_list ;
    FW=Camera.FW;
    Bitdepth_list =Camera.Bitdepth_list;
    Bitdepth = Bitdepth_list(bit_index);


    % other variables for camera operation
    Max_DN= 2^Bitdepth -1;
    Digital_offset = 0; % we fixed digital offset as 0
    ConversionFactor = (Max_DN - Digital_offset) ./FW;

    
    is_digitization = Camera.is_digitization;
    is_readnoise = Camera.is_readnoise;


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % (2) Convert from photon number to photoelectron number

    electrons = round(g*QE * I_poisson);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % (3) Simulate stochastic camera noises
    noise = Noise_list(noise_index);

    if is_readnoise ==1

        electrons_out = normrnd(0,noise,size(electrons))+electrons;
        disp("Read-out noise : True ")
    else

        electrons_out =electrons;
        disp("Read-out noise : False ")
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % (4) Convert from electron number to digital number
    if is_digitization ==1
        disp("digitiziation")
        DN =round(ConversionFactor * electrons_out);

        DN = DN + Digital_offset;
        DN(DN > Max_DN) = Max_DN;
        DN(DN<0) = 0;
    else
        DN = electrons_out;
    end
   
   
    %%%% Reconstruct the measured complex-valued field with the digital numbers
    recon_field = (DN(:,:,4,:) -DN(:,:,2,:))+(DN(:,:,1,:)-DN(:,:,3,:))*i;

else
    %%%% Reconstruct the measured complex-valued field with photon numbers

    disp("No camera opertaion ")
    recon_field = (I_poisson(:,:,4,:) -I_poisson(:,:,2,:))+(I_poisson(:,:,1,:)-I_poisson(:,:,3,:))*i;
end


recon_field=squeeze(recon_field);

%%%% Calculate phase error
phase_error=mod(angle(Es)-angle(recon_field)+pi,2*pi)-pi;

%% phase errror distribtuion data

phase_err_dist = [];
for xx =1:size(Es,3)
    [valuelist,edges] = histcounts(phase_error(:,:,xx),linspace(-pi,pi,NumBinEdges));
    phase_err_dist(xx,:) = valuelist;
end
end



