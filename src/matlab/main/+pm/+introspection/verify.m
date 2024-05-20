%
%   Verify the type and number of elements of the input ``varval``
%   match the specified input ``vartype`` and ``varsize``.
%   Otherwise, halt the program by calling the MATLAB
%   intrinsic ``error()`` with an appropriate
%   descriptive error message.
%
%   This function is merely a higher-level wrapper around
%   the ParaMonte functionality ``pm.introspection.istype()``.
%   The goal is to offer a unified interface for argument
%   verification and aborting the program with a suitable
%   error message if the verification fails.
%
%       varval
%
%           The input value to whose type and
%           number of elements is to be verified.
%
%       vartype
%
%           See the documentation of the corresponding
%           argument of ``pm.introspection.istype()``.
%
%       varsize
%
%           See the documentation of the corresponding
%           argument of ``pm.introspection.istype()``.
%
%       varname
%
%           The input scalar MATLAB string containing the label to assign
%           to the namelist-converted value in the output ``entry``.
%           The specified value of ``varname`` will be trimmed
%           (to remove leading and trailing blanks).
%
%>  \return
%       None
%>
%>  \interface{}
%>  \code{.m}
%>  \endcode
%>
%       pm.introspection.verify(varval, vartype, varsize, varname)
%
%>  \final{}
%>
%>  \author
%>  \FatemehBagheri, May 20 2024, 1:25 PM, NASA Goddard Space Flight Center, Washington, D.C.<br>
%>  \AmirShahmoradi, May 16 2016, 9:03 AM, Oden Institute for Computational Engineering and Sciences (ICES), UT Austin<br>
function verify(varval, vartype, varsize, varname)
    varval = varval(:);
    varname = string(strtrim(varname));
    if ~pm.introspection.istype(varval, vartype, varsize)
        disp(varname + " = ");
        disp(varval);
        error   ( newline ...
                + "The input ``" + varname + "`` specification value(s) displayed" + newline ...
                + "above must be conformable to a MATLAB " + vartype + " type," + newline ...
                + "with a maximum " + string(varsize) + " number of elements." + newline ...
                + "The specified value has the class:" + newline ...
                + newline ...
                + pm.io.tab + "class(" + varname + ") = " + string(class(varval)) + newline ...
                + "with size:" + newline ...
                + newline ...
                + pm.io.tab + "size(" + varname + ") = [" + join(string(size(varval)), ", ") + "]" + newline ...
                + newline ...
                );
    end
end