%
%   This is the Contourf class for generating
%   instances of 2-dimensional Contourf plots
%   based on the relevant MATLAB
%   intrinsic functions.
%
%       dfref
%
%           See the documentation of the corresponding input
%           argument of the class ``pm.vis.plot.Plot``.
%
%       varargin
%
%           Any ``property, value`` pair of the parent object.
%           If the property is a ``struct()``, then its value must be given as a cell array,
%           with consecutive elements representing the struct ``property-name, property-value`` pairs.
%           Note that all of these property-value pairs can be also directly set via the
%           parent object attributes, before calling the ``make()`` method.
%
%       \note
%
%           The input ``varargin`` can also contain the components
%           of the ``template`` component of the parent object.
%
%   \note
%       See the documentation of the attributes
%       of the superclass ``pm.vis.cascade.Cascade``.
%
%>  \return
%       An object of ``pm.vis.cascade.Contourf`` class.
%>
%>  \interface{}
%>  \code{.m}
%>  \endcode
%>
%       p = pm.vis.cascade.Contourf(dfref);
%       p = pm.vis.cascade.Contourf(dfref, varargin);
%
%>  \final{}
%>
%>  \author
%>  \FatemehBagheri, May 20 2024, 1:25 PM, NASA Goddard Space Flight Center, Washington, D.C.<br>
%>  \AmirShahmoradi, May 16 2016, 9:03 AM, Oden Institute for Computational Engineering and Sciences (ICES), UT Austin<br>
classdef Contourf < pm.vis.cascade.Cascade
    methods(Access = public)
        function self = Contourf(dfref, varargin)
            if nargin < 1
                dfref = [];
            end
            self = self@pm.vis.cascade.Cascade(pm.vis.plot.Contourf(dfref), varargin{:});
        end
    end
end