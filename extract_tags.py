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
                    tag = re.search('(.*)@(.+)@',line)
                    if tag:
                        tag_dict[tag.group(2)] = tag.group(1)
            except:
                pass
    return tag_dict
        
def print_tags_to_file(dir_path):
    file_object = open(dir_path+'next.txt','w')
    file_object.write('# Next\n\n')
    tag_dict = extract_tags(dir_path)
    tag_dict['--**'+date.today().__str__()+'**'] = ''
    for key in sorted(tag_dict):
        file_object.write('{:18} {} \n'.format(key,tag_dict[key])+'\n')

if __name__ == '__main__':
    script, dir_path = argv
    print_tags_to_file(dir_path)
