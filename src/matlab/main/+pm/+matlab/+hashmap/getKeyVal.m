%
%   Return the value corresponding to the input ``key``
%   in the input ``hashmap`` cell array.
%
%       key
%
%           The input scalar MATLAB string
%           containing the key to search for in the input pair list.
%
%       hashmap
%
%           The input cell array of even number of elements
%           containing the ``(key, val)`` pairs of the hashmap
%           in sequence as element of the cell array.
%
%>  \return
%       val
%
%           The output MATLAB object stored in the element of the
%           input cell array, whose ``key`` is given as the input.
%
%       failed
%
%           The output scalar MATLAB logical that is ``true``
%           if and only if the input ``key`` exists in the input ``hashmap``,
%           otherwise, it is ``false``.
%           (**optional**. If missing, ``val`` will remain an empty array ``[]`` on output.)
%>
%>  \interface{}
%>  \code{.m}
%>  \endcode
%>
%       val = pm.matlab.hashmap.getKeyVal(key, hashmap)
%       [val, failed] = pm.matlab.hashmap.getKeyVal(key, hashmap)
%
%   Example
%   -------
%
%       hashmap = {"key1", 1, "key2", "val2", "key3", false};
%       [val, failed] = pm.matlab.hashmap.getKeyVal("key2", hashmap) % = "val2"
%       [val, failed] = pm.matlab.hashmap.getKeyVal("key3", hashmap) % = false
%       [val, failed] = pm.matlab.hashmap.getKeyVal("key3", hashmap(1:4)) % = {}
%       [val, failed] = pm.matlab.hashmap.getKeyVal("key2", hashmap(1:4)) % = "val2"
%       [val, failed] = pm.matlab.hashmap.getKeyVal("key2", hashmap(1:3)) % error
%
%>  \final{}
%>
%>  \author
%>  \FatemehBagheri, May 20 2024, 1:25 PM, NASA Goddard Space Flight Center, Washington, D.C.<br>
%>  \AmirShahmoradi, May 16 2016, 9:03 AM, Oden Institute for Computational Engineering and Sciences (ICES), UT Austin<br>
function [val, failed] = getKeyVal(key, hashmap)
    vararginLen = length(hashmap);
    if mod(vararginLen, 2) ~= 0
        help("pm.matlab.hashmap.getKeyVal");
        error   ( newline ...
                + "The length of ``hashmap`` must be even." + newline ...
                + newline ...
                + "length(hashmap) = " + string(vararginLen) + newline ...
                + newline ...
                );
    end
    val = [];
    if 1 < nargout
        failed = true;
    end
    for i = 1 : vararginLen - 1
        if strcmpi(string(hashmap{i}), string(key))
            if 1 < nargout
                failed = false;
            end
            val = hashmap{i + 1};
            return;
        end
    end
end