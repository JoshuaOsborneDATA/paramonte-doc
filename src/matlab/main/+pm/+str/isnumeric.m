%
%   Return a scalar MATLAB logical that is ``true`` if and
%   only if the input string can be converted to a number.
%
%   The returned result is ``~isnan(str2double(str))``.
%   This is different from the result returned by
%   the MATLAB intrinsic ``isnumeric()``.
%
%       str
%
%           The input scalar MATLAB string
%           whose conversion to numeric value is to be tested.
%
%>  \return
%       itis
%
%           The output scalar MATLAB logical that is ``true`` if and
%           only if the input ``str`` contains text that is convertible
%           to number(s), e.g., integer, real, complex.
%
%   Interface
%   ---------
%
%       itis = pm.str.isnumeric(str)
%
%>  \final{}
%>
%>  \author
%>  \FatemehBagheri, May 20 2024, 1:25 PM, NASA Goddard Space Flight Center, Washington, D.C.<br>
%>  \AmirShahmoradi, May 16 2016, 9:03 AM, Oden Institute for Computational Engineering and Sciences (ICES), UT Austin<br>
function itis = isnumeric(str)
    itis = ~isnan(str2double(str));
end