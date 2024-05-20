%
%   Return a scalar MATLAB string containing the ParaMonte MATLAB library banner.
%
%       None
%
%>  \return
%       A scalar MATLAB string containing the ParaMonte MATLAB library banner.
%
%   Interface
%   ---------
%
%       str = pm.lib.banner()
%
%>  \final{}
%>
%>  \author
%>  \FatemehBagheri, May 20 2024, 1:25 PM, NASA Goddard Space Flight Center, Washington, D.C.<br>
%>  \AmirShahmoradi, May 16 2016, 9:03 AM, Oden Institute for Computational Engineering and Sciences (ICES), UT Austin<br>
function str = banner()
    verlen = pm.lib.version();
    verlen = length(verlen{1});
    offset = fix((verlen - 4) / 2);
    bannerFile = fullfile(pm.lib.path.auxil(), ".paramonte.banner");
    try
        str = strrep(fileread(bannerFile), string(repmat(' ', 1, offset)) + "Version 0.0.0", "Version " + pm.lib.version());
        str = newline + strrep(str, string(char(13)), "") + newline;
    catch
        weblinks = pm.lib.weblinks;
        warning ( newline ...
                + "Failed to read the ParaMonte banner file: " ...
                + newline ...
                + pm.io.tab + bannerFile ...
                + newline ...
                + "The integrity of the ParaMonte library has been comprised. " ...
                + newline ...
                + "You can download a new or the latest version of the library from: " ...
                + newline ...
                + pm.io.tab + pm.web.href(weblinks.github.release.latest.url) ...
                + newline ...
                );
        str = "";
    end
end