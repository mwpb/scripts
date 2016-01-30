from sys import argv
import markdown, os, errno, codecs

script, dirname = argv
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
        input_file = codecs.open(dirname+filename+".md",'r',encoding="utf-8")
        md = input_file.read()
        f_out = codecs.open(dirname+'html/'+filename+'.html','w',encoding="utf-8",errors="xmlcharrefreplace")
        output = markdown.markdown(md)
        print output
        f_out.write(output)
        input_file.close()
        f_out.close()
