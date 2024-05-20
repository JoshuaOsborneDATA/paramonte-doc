%
%   Return a MATLAB string containing the
%   absolute path to the system home directory.
%
%       None
%
%>  \return
%       A MATLAB string containing the
%       absolute path to the system home directory.
%
%   Interface
%   ---------
%
%       path = pm.sys.path.home()
%
%>  \final{}
%>
%>  \author
%>  \FatemehBagheri, May 20 2024, 1:25 PM, NASA Goddard Space Flight Center, Washington, D.C.<br>
%>  \AmirShahmoradi, May 16 2016, 9:03 AM, Oden Institute for Computational Engineering and Sciences (ICES), UT Austin<br>
function path = home(varargin)
    persistent homePathPersistent
    %freshRequested = false;
    %if nargin==0
    %    if isempty(homePathPersistent); freshRequested = true; end
    %elseif nargin==1 && ( strcmpi(string(varargin{1}),"fresh") || strcmpi(string(varargin{1}),"new") || strcmpi(string(varargin{1}),"reset") )
    %    freshRequested = true;
    %else
    %    error( "home() takes at most one argument of the following values: ""new"", ""fresh"", ""reset"", all with the same meaning." );
    %end
    %if freshRequested
    if ispc
        [failed, homePathPersistent] = system("echo %HOMEPATH%");
        if failed
            error   ( newline ...
                    + "Failed to capture the path to the home directory of the Windows system." + newline ...
                    + "This is highlt unusual and likely a low-level MATLAB problem." + newline ...
                    + newline ...
                    );
        else
            homePathPersistent = strtrim(homePathPersistent);
        end
    else
        homePathPersistent = strtrim(pm.sys.path.abs("~"));
    end
    %end
    path = string(homePathPersistent);
end