import os
from vimwiki2markdown import vimwiki_to_markdown
from sys import argv

script, dirname = argv
target_dir = dirname+"/markdown"

try:
    os.makedirs(target_dir)
except OSError:
    pass

print "\nTarget directory is: %s" % target_dir
print "Converting files to markdown...\n"

for filename in os.listdir(dirname):
    if not os.path.isdir(dirname+filename):
        vimwiki_to_markdown(dirname,filename)
