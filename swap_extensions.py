import os
from sys import argv

def swap_extensions(dir_path,ext1,ext2):
    """ Takes dir_path, ext1,ext2 as arguments.
    Then it searches for all of the files in dir_path with extension ext1.
    All the files with extension ext1 are renamed to have extension ext2.
    Note that this function is invertible!
    Just keep a track of which swaps you have made...
    """
    ext1 = ext1.split('.')[0] # If user puts dot in ext then let them off.
    ext2 = ext2.split('.')[0]
    for file_name in os.listdir(dir_path):
        pre, ext = os.path.splitext(file_name)
        print 'ext=',ext
        print 'pre=',pre
        if ext == '.'+ext1:
            print file_name
            os.rename(dir_path+file_name,dir_path+pre+'.'+ext2)

if __name__ == '__main__':
    script, dir_path, ext1, ext2 = argv
    swap_extensions(dir_path,ext1,ext2)

