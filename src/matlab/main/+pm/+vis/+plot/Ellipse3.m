%
%   This is the Ellipse3 class for generating
%   instances of 3-dimensional Ellipse3 plots
%   based on the relevant MATLAB
%   intrinsic functions.
%
%       gramian
%
%           See the corresponding input argument to the class ``pm.vis.subplot.Ellipse3``.
%
%       center
%
%           See the corresponding input argument to the class ``pm.vis.subplot.Ellipse3``.
%
%       zval
%
%           See the corresponding input argument to the class ``pm.vis.subplot.Ellipse3``.
%
%       cval
%
%           See the corresponding input argument to the class ``pm.vis.subplot.Ellipse3``.
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
%           of the ``subplot`` component of the parent object.
%
%   Attributes
%   ----------
%
%       See below and also the documentation of the
%       attributes of the superclass ``pm.vis.figure.Figure``.
%
%>  \return
%       An object of class ``pm.vis.plot.Ellipse3``.
%
%   Interface
%   ---------
%
%       p = pm.vis.plot.Ellipse3();
%       p = pm.vis.plot.Ellipse3(gramian);
%       p = pm.vis.plot.Ellipse3(gramian, center);
%       p = pm.vis.plot.Ellipse3(gramian, center, zval);
%       p = pm.vis.plot.Ellipse3(gramian, center, zval, cval);
%       p = pm.vis.plot.Ellipse3(gramian, center, zval, cval, varargin);
%
%   Example
%   -------
%
%       p = pm.vis.plot.Ellipse3();
%       p.make("dims", [1, 2]);
%
%>  \final{}
%>
%>  \author
%>  \FatemehBagheri, May 20 2024, 1:25 PM, NASA Goddard Space Flight Center, Washington, D.C.<br>
%>  \AmirShahmoradi, May 16 2016, 9:03 AM, Oden Institute for Computational Engineering and Sciences (ICES), UT Austin<br>
classdef Ellipse3 < pm.vis.plot.Plot
    methods(Access = public)
        function self = Ellipse3(gramian, center, zval, cval, varargin)
            %%%% Define the missing optional values as empty with the right rank.
            if  nargin < 4
                cval = zeros(0, 0);
            end
            if  nargin < 3
                zval = zeros(0, 0);
            end
            if  nargin < 2
                center = zeros(0, 0);
            end
            if  nargin < 1
                gramian = zeros(0, 0, 0);
            end
            self = self@pm.vis.plot.Plot(pm.vis.subplot.Ellipse3(gramian, center, zval, cval), varargin{:});
        end
    end
end