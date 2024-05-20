%
%   Return a scalar MATLAB logical that is ``true`` if and
%   only if the current installation of MATLAB contains
%   the MATLAB Neural Network Toolbox.
%
%   This function searches the MATLAB license
%   for an installation of the Toolbox.
%
%       None
%
%>  \return
%       hasit
%
%           The output scalar MATLAB logical that is ``true`` if and
%           only if the current installation of MATLAB contains
%           the required MATLAB Toolbox.
%
%   Interface
%   ---------
%
%       hasit = pm.matlab.has.neuralnet();
%
%>  \final{}
%>
%>  \author
%>  \FatemehBagheri, May 20 2024, 1:25 PM, NASA Goddard Space Flight Center, Washington, D.C.<br>
%>  \AmirShahmoradi, May 16 2016, 9:03 AM, Oden Institute for Computational Engineering and Sciences (ICES), UT Austin<br>
function hasit = neuralnet()
    hasit = license('test', 'Neural_Network_Toolbox');
end