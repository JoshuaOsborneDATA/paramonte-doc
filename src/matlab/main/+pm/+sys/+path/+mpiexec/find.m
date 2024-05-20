%
%   Return a list of scalar MATLAB strings containing the paths to
%   all detected ``mpiexec`` binaries installed on the system and
%   available in the environment path variable.
%
%   The search strategy is to parse and search the paths in the environmental
%   `PATH` variable of the runtime processor shell and return all mpiexec paths.
%   Also, all ``mpiexec`` paths found via ``pm.sys.path.mpiexec.which(vendor)`` are returned.
%   Additionally, if ``vendor`` is missing or is set to ``"Intel"``, also search the default
%   installation directories of Intel MPI libraries on all operating systems.
%
%   Think of this functionality ``pm.sys.path.mpiexec.find(vendor)``
%   as a more comprehensive of what ``pm.sys.path.mpiexec.which(vendor)`` does.
%
%       vendor
%
%           The input scalar MATLAB string, containing the MPI
%           library vendor that should match the ``mpiexec`` binary.
%           Possible values are:
%
%               -   ``Intel``, representing the Intel MPI library.
%               -   ``MPICH``, representing the MPICH MPI library.
%               -   ``OpenMPI``, representing the OpenMPI library.
%
%           (**optional**,  default = ``""``)
%
%>  \return
%       pathList
%
%           A list of scalar MATLAB strings containing the paths to
%           all detected ``mpiexec`` binaries installed on the system.
%           If the ``mpiexec`` is not found or does not match the specified ``vendor``,
%           the output will be an empty list ``[]``.
%
%   Interface
%   ---------
%
%       pathList = pm.sys.path.mpiexec.find()
%       pathList = pm.sys.path.mpiexec.find(vendor)
%
%>  \final{}
%>
%>  \author
%>  \FatemehBagheri, May 20 2024, 1:25 PM, NASA Goddard Space Flight Center, Washington, D.C.<br>
%>  \AmirShahmoradi, May 16 2016, 9:03 AM, Oden Institute for Computational Engineering and Sciences (ICES), UT Austin<br>
function pathList = find(vendor)
    pathList = [];
    if 0 < nargin
        vendorLower = lower(vendor);
        if vendorLower == "impi"
            vendorLower = "intel";
        elseif vendorLower == "open-mpi" || vendorLower == "openrte"
            vendorLower = "openmpi";
        end
        vendorList = vendorLower;
    else
        vendorList = ["Intel", "MPICH", "OpenMPI"];
        vendorLower = "";
    end
    % The strategy is to search for any executable in the
    % environmental paths whose name contains `mpiexec`.
    paths = getenv("PATH");
    paths = string(strsplit(paths, pathsep));
    for path = paths
        apps = pm.sys.path.list(path);
        for icell = 1 : length(apps)
            app = apps(icell);
            if contains(app, "mpiexec") && isfile(app)
                if 0 < nargin
                    name = lower(pm.sys.path.mpiexec.vendor(app));
                    if  name ~= ""
                        if  contains(name, vendorLower)
                            pathList = [pathList, app];
                        end
                    end
                else
                    pathList = [pathList, app];
                end
            end
        end
    end
    % Try more via `which()` and default installation paths.
    for name = vendorList
        path = pm.sys.path.mpiexec.which(name);
        if  path ~= ""
            if isempty(pathList)
                pathList = [pathList, path];
            elseif sum(strcmp(pathList, path)) == 0
                pathList = [pathList, path];
            end
        end
    end
    if  nargin == 0 || contains(vendorLower, "intel")
        possibilities = [ "C:\Program Files (x86)\Intel\oneAPI\mpi\latest\bin\mpiexec.exe" ...
                        , "C:\Program Files\Intel\oneAPI\mpi\latest\bin\mpiexec.exe" ...
                        , "/opt/intel/oneapi/mpi/latest/bin/mpiexec" ...
                        ];
        for path = possibilities
            if isfile(path)
                if isempty(pathList)
                    pathList = [pathList, path];
                elseif sum(contains(pathList, path)) == 0
                    pathList = [pathList, path];
                end
            end
        end
    end
end