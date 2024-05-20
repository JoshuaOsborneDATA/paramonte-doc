%
%   Return a scalar MATLAB string containing the
%   root directory of the ParaMonte library package.
%
%       None
%
%>  \return
%       path
%
%           A scalar MATLAB string containing the root
%           directory of the ParaMonte library package.
%>
%>  \interface{}
%>  \code{.m}
%>  \endcode
%>
%       path = pm.lib.path.root()
%
%>  \final{}
%>
%>  \author
%>  \FatemehBagheri, May 20 2024, 1:25 PM, NASA Goddard Space Flight Center, Washington, D.C.<br>
%>  \AmirShahmoradi, May 16 2016, 9:03 AM, Oden Institute for Computational Engineering and Sciences (ICES), UT Austin<br>
function path = root()
    persistent path_persistent
    if isempty(path_persistent)
        [path_persistent, ~, ~] = fileparts(mfilename('fullpath'));
        path_persistent = string(pm.sys.path.abs(fullfile(path_persistent, "..", "..")));
    end
    path = path_persistent;
    %addpath(genpath(tree.root),'-begin');
end