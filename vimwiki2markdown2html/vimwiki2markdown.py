import re, os, errno, codecs, markdown
from sys import argv

def vimwiki2markdown(dirname,filename):
    f = open(dirname+"/"+filename)
    # Remove output file if already exists
    try:
        os.remove(dirname+"/markdown/"+filename)
    except OSError:
        pass
    text = f.read()
    f_out = open(dirname+"/markdown/"+filename,"a+")
    
    #changed_text = re.sub('\[\[(.+?)\]\]',r'[\1](\1)',text)
    changed_text = re.sub('\[(.+?)\]\((.+?)\)',r'[[\1]]',text)
    print changed_text
    f_out.write(changed_text)
    
    f.close()
    f_out.close()
    print filename

if __name__ == '__main__':
    script, dirname, filename = argv
    vimwiki2markdown(dirname,filename)
