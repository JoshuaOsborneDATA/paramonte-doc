%
%   Return the input hashmap with the new (key, val) appended,
%   only if the input pair does not exist in the input hashmap.
%
%       key
%
%           The input scalar MATLAB string
%           containing the key to add to the input pair list.
%
%       val
%
%           The input value to be appended to the 
%           input hashmap after the input ``key``.
%
%       hashmap
%
%           The input cell array of even number of elements
%           containing a set of ``(key, val)`` pairs of the hashmap.
%
%>  \return
%       hashnew
%
%           The output cell array of even number of elements
%           containing the input pair list and ``(key, val)`` pair.
%           If the input ``key`` exists in the input ``hashmap``,
%           the input ``(key, val)`` pair will not be added.
%
%   Interface
%   ---------
%
%       hashnew = pm.matlab.hashmap.addKeyVal(key, val, hashmap)
%
%   Example
%   -------
%
%       hashmap = {"key1", 1, "key2", "val2"};
%       hashnew = pm.matlab.hashmap.addKeyVal("key3", false, {})
%       hashnew = pm.matlab.hashmap.addKeyVal("key2", "val2", hashmap) % = hashmap
%       hashnew = pm.matlab.hashmap.addKeyVal("key3", false, hashmap)
%
%>  \final{}
%>
%>  \author
%>  \FatemehBagheri, May 20 2024, 1:25 PM, NASA Goddard Space Flight Center, Washington, D.C.<br>
%>  \AmirShahmoradi, May 16 2016, 9:03 AM, Oden Institute for Computational Engineering and Sciences (ICES), UT Austin<br>
function hashnew = addKeyVal(key, val, hashmap)
    hashnew = hashmap;
    if  2 < nargin && 0 < length(hashnew)
        [currentVal, failed] = pm.matlab.hashmap.getKeyVal(key, hashmap);
        if  failed
            hashnew = {hashnew{:}, key, val};
        end
    else
        hashnew = {key, val}; % XXX is this correct behavior?
    end
end