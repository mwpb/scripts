from sys import argv
import markdown, os, errno, codecs
from vimwiki2markdown2html_functions import markdown_folder2html

script, dirname = argv

markdown_folder2html(dirname)
