import re, os, errno, codecs, markdown
from vimwiki2markdown import *
from sys import argv

def vimwiki_folder2markdown(dirname):
    target_dir = dirname+"/markdown"
    try:
        os.makedirs(target_dir)
    except OSError:
        pass
    
    print "\nTarget directory is: %s" % target_dir
    print "Converting files to markdown...\n"
    
    for filename in os.listdir(dirname):
        print filename
        ext = os.path.splitext(filename)[1]
        if ext == ".md":
            print filename
            vimwiki2markdown(dirname,filename)

if __name__ == '__main__':
    script, dirname = argv
    vimwiki_folder2markdown(dirname)
