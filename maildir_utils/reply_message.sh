# Get the day month year and time for indexing
date=$(date +"%Y-%m-%d-%H-%M-%S")
echo $date
filename="/Users/mat/@msmtp/$date.txt"
echo $filename
echo "dummy text" > $filename

#Put message into file
echo "- - - Original Message - - -\n" > $filename
mu view $1 >> $filename

#Extract Subject To From and Body
subject=$(mu view --summary-len=1 $1 | sed '$d' | grep "^Subject:" | cut -d : -f 2-100)
echo "subject=$subject"
to=$(mu view --summary-len=1 $1 | sed '$d' | grep "^To:" | cut -d : -f 2-100)
echo "to=$to"
from=$(mu view --summary-len=1 $1 | sed '$d' | grep "^From:" | cut -d : -f 2-100)
echo "from=$from"

#Put in From and To headers
ex $filename -c "normal ggO" -c "normal ggOFrom:$to" -c wq
ex $filename -c "normal ggOTo:$from" -c wq

#Check whether email is a reply 
subject_prefix=$(echo $subject | cut -d : -f 1)
echo "subject_prefix=$subject_prefix"
#Put in headers
if [ "$subject_prefix" = "Re" ] || [ "$subject_prefix" = "RE" ];
then 
    ex $filename -c "normal ggOSubject:$subject" -c wq
    echo "identified reply"
else
    ex $filename -c "normal ggOSubject: Re:$subject" -c wq
    echo "not reply"
fi 
vim $filename -c "normal jjj"
