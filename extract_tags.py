import re
from sys import argv
import os
from datetime import date

def extract_tags(dir_path):
    tag_dict = {}
    for file_name in os.listdir(dir_path):
        if not file_name.startswith('.'):
            try: 
                file_object = open(dir_path+file_name)
                for line in file_object:
                    tag = re.search('\s*(.*)@(.+)@',line)
                    if tag:
                        new_tag = [tag.group(1)]
                        if tag.group(2) in tag_dict:
                            tag_dict[tag.group(2)] = tag_dict[tag.group(2)]+new_tag
                        else:
                            tag_dict[tag.group(2)] = new_tag
                file_object.close()
            except:
                pass
    return tag_dict
        
def print_tags_to_file(dir_path):
    file_object = open(dir_path+'next.txt','w')
    file_object.write('# Next\n\n')
    tag_dict = extract_tags(dir_path)
    tag_dict[date.today().__str__()+'-----------'] = '-'
    for key in sorted(tag_dict):
        for value in tag_dict[key]:
            file_object.write('{:18} {} \n'.format(key,value)+'\n')
    file_object.close()

if __name__ == '__main__':
    script, dir_path = argv
    print_tags_to_file(dir_path)
