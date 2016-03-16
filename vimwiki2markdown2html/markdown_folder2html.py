from sys import argv
import markdown, os, errno, codecs

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
    
    for file_handle in os.listdir(dirname):
        print file_handle
        filename = os.path.splitext(file_handle)[0]
        if not os.path.isdir(dirname+'/'+filename):
            if not file_handle.startswith('.'):
                input_file = codecs.open(dirname+"/"+file_handle,'r',encoding="utf-8")
                md = input_file.read()
                f_out = codecs.open(dirname+'html/'+filename+'.html','w',encoding="utf-8",errors="xmlcharrefreplace")
                output = markdown.markdown(md)
                print output
                f_out.write(html_head)
                f_out.write(output)
                input_file.close()
                f_out.close()

if __name__ =='__main__':
    script, dirname = argv
    markdown_folder2html(dirname)
