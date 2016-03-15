import os
from vimwiki2markdown2html import vimwiki_folder

from sys import argv

script, dirname = argv

vimwiki_folder2markdown(dirname)
