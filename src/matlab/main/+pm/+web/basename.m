%>  \brief
%>  Return a scalar MATLAB string containing
%>  the basename part of an input ``url``, defined as
%>  the segment of the ``url`` after the last separator ``/``.
%>
%>  \param[in]  url :   The input scalar MATLAB string containing a bare URL.
%>
%>  \return
%>  `name`          :   The output scalar MATLAB string containing
%>                      the basename part of an input ``url``, defined as
%>                      the segment of the ``url`` after the last separator ``/``.
%>                      If the input ``url`` ends with ``/``, then the output
%>                      basename is set to the default ``index.html``.
%>
%>
%>  \interface{basename}
%>  \code{.m}
%>
%>      name = pm.web.basename(url)
%>
%>  \endcode
%>
%>  \final{basename}
%>
%>  \author
%>  \JoshuaOsborne, May 22 2024, 7:47 PM, University of Texas at Arlington<br>
%>  \FatemehBagheri, May 20 2024, 1:25 PM, NASA Goddard Space Flight Center, Washington, D.C.<br>
%>  \AmirShahmoradi, May 16 2016, 9:03 AM, Oden Institute for Computational Engineering and Sciences (ICES), UT Austin<br>
function name = basename(url)
    name = strsplit(url, '/');
    name = name(end);
end
