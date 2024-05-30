function graphicpars = Init_Graphic_param(NumBins,is_save,savefol)
% This function ininialize graphic paramters 
% Inputs:
%   NumBins :  number of bins for drawing probability density function (PDF) of phase measurement error
%   is_save : if you want save matlab variables, set is_save as 1 otherwise 0
% Outputs:
%   graphicpars : structure of graphic parameters

graphicpars.NumBins = NumBins;
graphicpars.is_save= is_save ;

graphicpars.markerstyle_list={'none','+' , 'o' , '*','.' , 'x' ,'square', 'diamond', 'v' , '^' , '>' , '<' ,'pentagram' , 'hexagram' , '|' , '_'};;
graphicpars.color_list = {"#0072BD", "#D95319" ,"#EDB120" ,	"#7E2F8E" ,"#77AC30", "#4DBEEE","#A2142F","#0072BD", "#D95319" ,"#EDB120" ,	"#7E2F8E" ,"#77AC30", "#4DBEEE","#A2142F"	};

if nargin >=3
    graphicpars.savefol = savefol;
    if ~exist(savefol, 'dir')
           mkdir(savefol)
    end

end

end


