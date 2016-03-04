import re, os, errno, codecs, markdown

def vimwiki2markdown(dirname,filename):
    f = open(dirname+"/"+filename)
    # Remove output file if already exists
    try:
        os.remove(dirname+"/markdown/"+filename)
    except OSError:
        pass
    text = f.read()
    f_out = open(dirname+"/markdown/"+filename,"a+")
    
    changed_text = re.sub('\[\[(.+?)\]\]',r'[\1](\1.html)',text)
    print changed_text
    f_out.write(changed_text)
    
    f.close()
    f_out.close()
    print filename

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

html_head = '''
<head>
<link rel="stylesheet" type="text/css" href="stylesheet.css">
</head>
'''
def markdown_folder2html(dirname):
    target_dir = dirname+"html/"
    try:
        os.makedirs(target_dir)
    except OSError:
        pass
    
    print "\nTarget directory is: %s" % target_dir
    print "Converting files to html...\n"
    
    for filename in os.listdir(dirname):
        print filename
        filename = os.path.splitext(filename)[0]
        if not os.path.isdir(dirname+filename):
            input_file = codecs.open(dirname+"/"+filename+".md",'r',encoding="utf-8")
            md = input_file.read()
            f_out = codecs.open(dirname+'html/'+filename+'.html','w',encoding="utf-8",errors="xmlcharrefreplace")
            output = markdown.markdown(md)
            print output
            f_out.write(html_head)
            f_out.write(output)
            input_file.close()
            f_out.close()
