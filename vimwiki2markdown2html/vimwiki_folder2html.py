import os
from vimwiki2markdown2html_functions import vimwiki_folder2markdown, markdown_folder2html

cwd = os.getcwd()

vimwiki_folder2markdown(cwd)

markdown_dir = cwd+"/markdown/"
markdown_folder2html(markdown_dir)
