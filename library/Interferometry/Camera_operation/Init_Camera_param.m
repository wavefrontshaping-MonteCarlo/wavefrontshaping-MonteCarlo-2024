function [Camera]= Init_Camera_param(is_camera,is_digitization,is_readnoise,is_graphic_monitor,g,QE,Noise_list,FW,Bitdepth_list)
% This function initilaize Camera structure

if nargin ==1
    Camera.is_camera=is_camera ;
    Camera.Noise_list=1;
    Camera.Bitdepth_list=1;

else

Dynamic_range = FW./Noise_list ;
if nargin==8
    Bitdepth_list=1;
end
Max_DN= 2.^Bitdepth_list -1; 
Digital_offset = 0;
CF =  (Max_DN - Digital_offset) ./FW;


Camera.FW = FW
Camera.Noise_list = Noise_list;
Camera.Dynamic_range = Dynamic_range;
Camera.QE = QE;
Camera.g=g;
Camera.Bitdepth_list=Bitdepth_list;
Camera.Max_DN=Max_DN;
Camera.Digital_offset=Digital_offset;
Camera.CF=CF;
Camera.is_digitization = is_digitization;
Camera.is_readnoise = is_readnoise;
Camera.is_camera = is_camera;
Camera.is_graphic_monitor = is_graphic_monitor;


end



end

