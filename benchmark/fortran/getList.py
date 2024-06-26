# to run: python3 getList.py
import os
filename = "bench.list"
def getListOfFiles(dir):
    """
    For the given path, get the List of all files in the directory tree.
    """
    # create a list of file and subdirectories names in the given directory.
    listOfFile = os.listdir(dir)
    allFiles = list()
    # Iterate over all the entries.
    for entry in listOfFile:
        # Create full path
        fullPath = os.path.join(dir, entry)
        # If entry is a directory then get the list of files in this directory.
        if os.path.isdir(fullPath):
            allFiles = allFiles + getListOfFiles(fullPath)
        else:
            allFiles.append(fullPath)
    return allFiles

if __name__ == '__main__':
    rootdir = os.path.dirname(os.path.abspath(__file__))
    allfile = sorted(getListOfFiles(rootdir))
    with open(os.path.join(rootdir, filename), "w") as fid:
        fid.write("!This file is automatically generated by getList.py Python script.\n")
        fid.write("!Comment out any item below by adding ! at the beginning of the line.\n!\n")
        for file in allfile:
            if "main.F90" in file:
                tokens = os.path.dirname(file).split(os.path.sep)
                item = os.path.join(tokens[-2], tokens[-1]) # module/procedure names.
                fid.write(item + "\n")