%
%   Return ``true`` if and only if the input ``varval`` conforms with the
%   specified input type ``vartype`` and the specified maximum size ``varsize``.
%   Otherwise, return ``false``.
%
%       varval
%
%           The input value to be converted to namelist-compatible value.
%
%       vartype
%
%           The input scalar MATLAB string containing the
%           expected type of the value given by the input ``varval``.
%
%           The following type-conformance rules apply:
%
%               -   if ``vartype`` is ``"string"``, then ``varval`` can be
%                   either a MATLAB ``string`` or ``char``.
%
%               -   if ``vartype`` is ``"integer"``, then ``varval`` can be
%                   either a MATLAB ``int8``, ``int16``, ``int32``, ``int64``,
%                   or a whole-number ``real`` value.
%
%               -   if ``vartype`` is ``"logical"``, then ``varval`` can be
%                   either a MATLAB ``int8``, ``int16``, ``int32``, ``int64``,
%                   a MATLAB ``real``, or a MATLAB ``logical`` value.
%
%               -   if ``vartype`` is ``"complex"``, then ``varval`` can be
%                   either a MATLAB ``int8``, ``int16``, ``int32``, ``int64``,
%                   a MATLAB ``real``, or a MATLAB ``complex`` value.
%
%               -   if ``vartype`` is ``"real"``, then ``varval`` can be
%                   either a MATLAB ``int8``, ``int16``, ``int32``, ``int64``,
%                   or a MATLAB ``real`` value.
%
%           For all other object types, the type-conformance is verified by
%           passing the input ``varval`` and ``vartype`` directly to the
%           MATLAB intrinsic function ``isa()``
%
%       varsize
%
%           The input scalar MATLAB integer representing the
%           maximum allowed size of the input value ``varval``.
%           (**optional**. If missing, the maximum length of the
%           input ``varval`` will not be checked.)
%
%>  \return
%       itis
%
%           The output scalar MATLAB logical that is ``true`` if and only if
%           the input ``varval`` conforms with the specified input type ``vartype``
%           and the specified maximum size ``varsize``. Otherwise, it is ``false``.
%
%   Interface
%   ---------
%
%       itis = pm.introspection.istype(varval, vartype, varsize)
%
%>  \final{}
%>
%>  \author
%>  \FatemehBagheri, May 20 2024, 1:25 PM, NASA Goddard Space Flight Center, Washington, D.C.<br>
%>  \AmirShahmoradi, May 16 2016, 9:03 AM, Oden Institute for Computational Engineering and Sciences (ICES), UT Austin<br>
function itis = istype(varval, vartype, varsize)
    varvalen = numel(varval);
    itis = false;
    if 2 < nargin
        itis = varvalen <= varsize;
        return;
    end
    for i = 1 : varvalen
        if isa(varval(i), "cell")
            value = varval{i};
        else
            value = varval(i);
        end
        if strcmpi(vartype, "string")
            itis = isa(value, "string") || isa(value, "char");
        elseif strcmpi(vartype, "integer")
            itis = isa(value, "int8") || isa(value, "int16") || isa(value, "int32") || isa(value, "int64");
            if ~itis && isreal(value)
                itis = rem(value, 1) == 0;
            end
        elseif strcmpi(vartype, "logical")
            itis = isa(value, "logical") || isreal(value) || isa(value, "int8") || isa(value, "int16") || isa(value, "int32") || isa(value, "int64");
        elseif strcmpi(vartype, "complex")
            itis = isnumeric(value);
        elseif strcmpi(vartype, "real")
            itis = isreal(value) || isa(value, "int8") || isa(value, "int16") || isa(value, "int32") || isa(value, "int64");
        else
            itis = isa(value, vartype);
        end
    end
end