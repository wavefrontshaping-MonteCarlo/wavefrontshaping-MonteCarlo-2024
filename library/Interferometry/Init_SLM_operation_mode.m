function option = Init_SLM_operation_mode
% This function ininialize SLM operation mode.
% option contains three SLM operation mode information.
% you can choose option_list as 1 for the Full-complex, 2 for the phase-only, and 3 for the amplitude-only. 
% e.g. option_list = [1:3] means you select all the SLM operation mode,
% e.g. option_list =2 means you select phase-only SLM opertaion mode.
% Outputs:
%   option : cell of three SLM operation mode information .
gamma =[1, pi/4, 1/(2*pi)];
ampandphase.name =  'Full-complex modulation';
ampandphase.gamma =gamma(1)

phaseonly.name = 'Phase-only modulation'
phaseonly.gamma =gamma(2)

amponly.name = 'Amplitude-only modulation'
amponly.gamma =gamma(3)
option = {ampandphase,phaseonly,amponly};
end