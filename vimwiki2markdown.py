import re, os, errno

def vimwiki_to_markdown(dirname,filename):
    f = open(dirname+filename)
    text = f.read()
    # Remove output file if already exists
    try:
        os.remove(dirname+"markdown/"+filename)
    except OSError:
        pass
    f_out = open(dirname+"markdown/"+filename,"a+")
    
    changed_text = re.sub('\[\[(.+?)\]\]',r'[\1](\1.html)',text)
    print changed_text
    f_out.write(changed_text)
    
    f.close()
    f_out.close()
    print filename
