%
%   Return a set of unique integer spacings almost linearly 
%   spaced in the logarithmic scale in the input given base,
%   between the specified lower and upper bounds.
%
%       loglb
%
%           See the documentation of the corresponding argument of ``pm.array.logspace``.
%
%       logub
%
%           See the documentation of the corresponding argument of ``pm.array.logspace``.
%
%       logskip
%
%           See the documentation of the corresponding argument of ``pm.array.logspace``.
%
%       base
%
%           See the documentation of the corresponding argument of ``pm.array.logspace``.
%
%>  \return
%       array
%
%           The output vector of MATLAB real values containing
%           the set of logarithmically-spaced integer values in
%           the specified input range with the specified ``base``.
%
%   Interface
%   ---------
%
%       array = pm.array.logspaceint(loglb, logub)
%       array = pm.array.logspaceint(loglb, logub, logskip)
%       array = pm.array.logspaceint(loglb, logub, [], base)
%       array = pm.array.logspaceint(loglb, logub, logskip, base)
%
%   Example
%   -------
%
%       array = pm.array.logspaceint(log(10), log(20)) % 10 11 12 13 14 15 16 17 18 19 20
%       array = pm.array.logspaceint(log(10), log(20), log(1.5)) % 10  15
%       array = pm.array.logspaceint(log(10), log(20), [], 2) % 10 11 12 13 14 15 16 17 18 19 20
%       array = pm.array.logspaceint(log(10), log(100), log(1.5)) % 10 15 23 34 51 76
%
%>  \final{}
%>
%>  \author
%>  \FatemehBagheri, May 20 2024, 1:25 PM, NASA Goddard Space Flight Center, Washington, D.C.<br>
%>  \AmirShahmoradi, May 16 2016, 9:03 AM, Oden Institute for Computational Engineering and Sciences (ICES), UT Austin<br>
function array = logspaceint(loglb, logub, logskip, base)
    if nargin < 3
        logskip = [];
    end
    if nargin < 4
        array = unique(round(pm.array.logspace(loglb, logub, logskip)));
    else
        array = unique(round(pm.array.logspace(loglb, logub, logskip, base)));
    end
end