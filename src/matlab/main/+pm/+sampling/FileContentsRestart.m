%
%   This is the base class for generating objects
%   that contain the contents of a restart file
%   generated by a ParaMonte sampler.
%
%   This class is meant to be primarily internally
%   used by the ParaMonte MATLAB library samplers.
%
%       See the documentation of the class constructor.
%
%   Attributes
%   ----------
%
%       See below for information on the attributes (properties).
%
%   Methods
%   -------
%
%       See below for information on the methods.
%
%>  \return
%       An object of class ``pm.sampling.FileContentsRestart``.
%
%   Interface
%   ---------
%
%       contents = pm.sampling.FileContentsRestart(file)
%       contents = pm.sampling.FileContentsRestart(file, [])
%       contents = pm.sampling.FileContentsRestart(file, silent)
%       contents = pm.sampling.FileContentsRestart(file, [], [])
%       contents = pm.sampling.FileContentsRestart(file, silent, [])
%       contents = pm.sampling.FileContentsRestart(file, silent, method)
%
%>  \final{}
%>
%>  \author
%>  \FatemehBagheri, May 20 2024, 1:25 PM, NASA Goddard Space Flight Center, Washington, D.C.<br>
%>  \AmirShahmoradi, May 16 2016, 9:03 AM, Oden Institute for Computational Engineering and Sciences (ICES), UT Austin<br>
classdef FileContentsRestart < pm.io.FileContents

    properties(Access = public)
        %
        %   count
        %
        %       The scalar MATLAB integer containing the number of
        %       restart entries in the specified restart file.
        %
        count = [];
        %
        %   ndim
        %
        %       The scalar MATLAB integer containing the number of
        %       dimensions of the domain of the objective function.
        %
        ndim = [];
        %
        %   domainAxisName
        %
        %       The vector of MATLAB strings of size ``ndim`` containing
        %       the domain axes names of the density function explored.
        %
        %
        domainAxisName = [];
        %
        %   contents
        %
        %       The scalar MATLAB string containing the entire
        %       contents of the restart file with all Carriage Return
        %       characters removed (relevant only to Windows OS).
        %
        contents = [];
    end

    properties(Hidden)
        method = '';
        lineList = [];
        lineListLen = [];
        ilast = 0; % index that is always set to the last line number read.
    end

    methods(Access = public)

        %
        %   Return a scalar object of class ``pm.sampling.FileContentsRestart``.
        %
        %   This is the constructor of the class ``pm.sampling.FileContentsRestart``.
        %
        %   Parameters
        %   ----------
        %
        %       file
        %
        %           The input scalar MATLAB string
        %           containing the path to an external restart file.
        %
        %       silent
        %
        %           See the corresponding argument of ``pm.io.FileContents`` class.
        %           (**optional**. The default is set by ``pm.io.FileContents``.)
        %
        %       method
        %
        %           The input scalar MATLAB string
        %           containing the sampling method name.
        %           The input value must be any of the following:
        %
        %               -   "ParaDRAM"
        %               -   "ParaDISE"
        %               -   "ParaNest"
        %
        %           (**optional**. If missing, some of the restart file contents will not be (properly) parsed.)
        %
        %   Returns
        %   -------
        %
        %       self
        %
        %           The output scalar object of class ``pm.sampling.FileContentsRestart``.
        %
        %   Interface
        %   ---------
        %
        %       contents = pm.sampling.FileContentsRestart(file)
        %       contents = pm.sampling.FileContentsRestart(file, [])
        %       contents = pm.sampling.FileContentsRestart(file, silent)
        %       contents = pm.sampling.FileContentsRestart(file, [], [])
        %       contents = pm.sampling.FileContentsRestart(file, silent, [])
        %       contents = pm.sampling.FileContentsRestart(file, silent, method)
        %
        %   LICENSE
        %   -------
        %
        %       https://github.com/cdslaborg/paramonte/blob/main/LICENSE.md
        %
        function self = FileContentsRestart(file, silent, method)
            if  nargin < 2
                silent = [];
            end
            self = self@pm.io.FileContents(file, silent);
            if  2 < nargin
                self.method = convertStringsToChars(method);
            end

            %%%%
            %%%% remove any CARRIAGE RETURN.
            %%%%

            self.contents = strrep(fileread(file), char(13), '');
            self.lineList = strsplit(self.contents, newline);
            self.lineListLen = length(self.lineList);

            % find the field names in the file.
            %fields = [];
            %for ilast = 1 : self.lineListLen
            %    line = self.lineList{ilast};
            %    if isletter(line(1))
            %        if ~any(contains(fields, line))
            %            fields = [fields, line];
            %        else
            %            break;
            %        end
            %    end
            %end

            %%%%
            %%%% Read restart meta data (ndim, domainAxisName).
            %%%%

            %%%% This is the old DRAM-specific approach where we inferred the ndim value from the file contents.

            % self.ndim = 0;
            % rowOffset = 1;
            % while ~contains(self.lineList(rowOffset), "proposalMean")
            %     rowOffset = rowOffset + 1;
            %     if  self.lineListLen < rowOffset
            %         error   ( newline ...
            %                 + "Failed to detect any field named ""proposalMean""" + newline ...
            %                 + "in the specified restart file:" + newline ...
            %                 + newline ...
            %                 + pm.io.tab + file + newline ...
            %                 + newline ...
            %                 + "The file structure may have been compromized." + newline ...
            %                 + newline ...
            %                 );
            %     end
            % end
            % rowOffset = rowOffset + 1; % the first numeric value of proposalMean.
            % while ~isnan(str2double(self.lineList{self.ndim + rowOffset}))
            %     self.ndim = self.ndim + 1;
            % end
            % if  self.ndim == 0
            %     error   ( newline ...
            %             + "Failed to infer the value of ``ndim``." + newline ...
            %             + "from the specified restart file:" + newline ...
            %             + newline ...
            %             + pm.io.tab + file + newline ...
            %             + newline ...
            %             + "The file structure may have been compromized." + newline ...
            %             + newline ...
            %             );
            % end

            %%%% This is the new approach where the ndim value is explicitly written in the file along with domainAxisName.

            if ~contains(self.lineList(1), "ndim") || ~contains(self.lineList(3), "domainAxisName")
                error   ( newline ...
                        + "The structure of the specified restart file appears to have been compromised:" + newline ...
                        + newline ...
                        + pm.io.tab + file + newline ...
                        + newline ...
                        + "The first line of the restart file must match ""ndim""." + newline ...
                        + "The third line of the restart file must match ""domainAxisName""." + newline ...
                        + newline ...
                        );
            else
                self.ndim = str2double(self.lineList(2));
                self.domainAxisName = strings(self.ndim, 1);
                for idim = 1 : self.ndim
                    self.domainAxisName(idim) = string(self.lineList(3 + idim));
                end
            end

            self.ilast = 3 + self.ndim;

        end % constructor

    end % methods(Access = public)

end % classdef