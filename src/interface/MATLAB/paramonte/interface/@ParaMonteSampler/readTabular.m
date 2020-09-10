%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%
%%%%   MIT License
%%%%
%%%%   ParaMonte: plain powerful parallel Monte Carlo library.
%%%%
%%%%   Copyright (C) 2012-present, The Computational Data Science Lab
%%%%
%%%%   This file is part of the ParaMonte library.
%%%%
%%%%   Permission is hereby granted, free of charge, to any person obtaining a 
%%%%   copy of this software and associated documentation files (the "Software"), 
%%%%   to deal in the Software without restriction, including without limitation 
%%%%   the rights to use, copy, modify, merge, publish, distribute, sublicense, 
%%%%   and/or sell copies of the Software, and to permit persons to whom the 
%%%%   Software is furnished to do so, subject to the following conditions:
%%%%
%%%%   The above copyright notice and this permission notice shall be 
%%%%   included in all copies or substantial portions of the Software.
%%%%
%%%%   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
%%%%   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
%%%%   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
%%%%   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
%%%%   DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
%%%%   OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
%%%%   OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%%%%
%%%%   ACKNOWLEDGMENT
%%%%
%%%%   ParaMonte is an honor-ware and its currency is acknowledgment and citations.
%%%%   As per the ParaMonte library license agreement terms, if you use any parts of 
%%%%   this library for any purposes, kindly acknowledge the use of ParaMonte in your 
%%%%   work (education/research/industry/development/...) by citing the ParaMonte 
%%%%   library as described on this page:
%%%%
%%%%       https://github.com/cdslaborg/paramonte/blob/master/ACKNOWLEDGMENT.md
%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = readTabular(self, callerName, varargin) % callerName, file, delimiter

    if isempty(self.objectName); self.objectName = inputname(1); end

    self.Err.marginTop = 0;

    file = [];
    delimiter = [];
    errorOccurred = false;
    markovChainRequested = false;
    if nargin==1; errorOccurred = true; end
    if strcmp(callerName,"readChain")
        fileType = "chain";
    elseif strcmp(callerName,"readSample")
        fileType = "sample";
    elseif strcmp(callerName,"readMarkovChain")
        fileType = "chain";
        markovChainRequested = true;
    end
    if nargin>2; file = convertStringsToChars(varargin{2}); end
    if nargin>3; delimiter = varargin{3}; end
    if nargin>4 || errorOccurred
        self.Err.msg    = callerName + " takes only two input arguments (file, delimiter). Correct usage:" + newline + newline ...
                        + "    " + callerName + "(file,delimiter)" + newline + newline ...
                        + "where ""file"" is the name of the file to be read, delimiter is the delimiter used in the file.";
        self.Err.abort();
    end

    if isempty(delimiter)
        if isempty(self.spec.outputDelimiter)
            delimiter = ',';
            if ~self.mpiEnabled
                self.Err.msg    = "The " + self.methodName + " input simulation specification " + self.objectName + ".spec.outputDelimiter is not set." + newline ...
                                + "This information is essential for successful reading of the requested " + fileType + " file(s)." + newline ...
                                + "Proceeding with the default assumption of comma-delimited " + fileType + " file contents...";
                self.Err.warn();
            end
        else
            delimiter = string(self.spec.outputDelimiter);
        end
    else
        delimiter = string(delimiter);
    end

    filePathList = self.getFilePathList(file,fileType);
    filePathListLen = length(filePathList);

    outputList = cell(filePathListLen,1);
    for ifile = filePathListLen:-1:1
        if ~self.mpiEnabled
            self.Err.msg = "processing file: """ + filePathList(ifile) + """";
            self.Err.marginTop = 1;
            self.Err.marginBot = 0;
            self.Err.note();
        end
        outputList{ifile} = TabularFileContents ( filePathList(ifile) ...
                                                , fileType ...
                                                , delimiter ...
                                                , self.methodName ...
                                                , self.mpiEnabled ...
                                                , markovChainRequested ...
                                                , self.Err ...
                                                );
    end

    if nargout==0
        dummy = fileType; if contains(lower(callerName),"markov"); dummy = "markovChain"; end
        outputListName = dummy + "List"; 
        outputListFullName = self.objectName + "." + outputListName;
        prop=outputListName; if ~any(strcmp(properties(self),prop)); self.addprop(prop); end
        self.(outputListName) = outputList;
        self.Err.msg    = "The processed " + fileType + " files are now stored in the newly-created component """ + outputListFullName + """ of the " + self.methodName + " object as a cell array. " ...
                        + "For example, to access the contents of the first (or the only) " + fileType + " file, try:";
    elseif nargout==1
        varargout{1} = outputList;
        outputListFullName = "OUTPUT_CELL_ARRAY";
        self.Err.msg    = "The processed " + fileType + " files are now stored in the output variable as a cell array. " ...
                        + "For example, to access the contents of the first (or the only) " + fileType + " file stored in an output variable named " ...
                        + outputListFullName + ", try:";
    end

    if ~self.mpiEnabled
        self.Err.marginTop = 1;
        self.Err.marginBot = 1;
        self.Err.msg    = self.Err.msg ...
                        + newline + newline ...
                        + "    " + outputListFullName + "{1}.df" + newline + newline ...
                        + "To access the plotting tools, try:" + newline + newline ...
                        + "    " + outputListFullName + "{1}.plot.<PRESS TAB TO SEE THE LIST OF PLOTS>" + newline + newline ...
                        + "For example," + newline + newline ...
                        + "    " + outputListFullName + "{1}.plot.line.plot()         % to make bivariate line plots." + newline ...
                        + "    " + outputListFullName + "{1}.plot.scatter.plot()      % to make bivariate scatter plots." + newline ...
                        + "    " + outputListFullName + "{1}.plot.lineScatter.plot()  % to make bivariate line-scatter plots." + newline ...
                        + "    " + outputListFullName + "{1}.plot.line3.plot()        % to make trivariate line plots." + newline ...
                        + "    " + outputListFullName + "{1}.plot.scatter3.plot()     % to make trivariate scatter plots." + newline ...
                        + "    " + outputListFullName + "{1}.plot.lineScatter3.plot() % to make trivariate line-scatter plots." + newline ...
                        + "    " + outputListFullName + "{1}.plot.contour3.plot()     % to make 3D kernel-density contour plots." + newline ...
                        + "    " + outputListFullName + "{1}.plot.contourf.plot()     % to make 2D kernel-density filled-contour plots." + newline ...
                        + "    " + outputListFullName + "{1}.plot.contour.plot()      % to make 2D kernel-density plots." + newline ...
                        + "    " + outputListFullName + "{1}.plot.histogram2.plot()   % to make bivariate histograms." + newline ...
                        + "    " + outputListFullName + "{1}.plot.histogram.plot()    % to make univariate histograms." + newline ...
                        + "    " + outputListFullName + "{1}.plot.grid.plot()         % to make GridPlot" + newline + newline ...
                        + "To plot or inspect the variable autocorrelations or the correlation/covariance matrices, try:" + newline + newline ...
                        + "    " + outputListFullName + "{1}.stats.<PRESS TAB TO SEE THE LIST OF COMPONENTS>" + newline + newline ...
                        + "For more information and examples on the usage, visit:" + newline + newline ...
                        + "    " + href(self.website.home.url);
        self.Err.note();
    end

end
