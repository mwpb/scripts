#Extract Subject To From and Body

subject=$(head -n 3 $1 | grep "^Subject:" | cut -d : -f 2-10)
echo "subject=$subject"
to=$(head -n 3 $1 | grep "^To:" | cut -d : -f 2-10)
echo "to=$to" 
from=$(head -n 3 $1 | grep "^From:" | cut -d : -f 2-10)
echo "from=$from "
#body=$(tail -n +3 $1)
#echo $body
from_address=$(echo $from | cut -d "<" -f 2 |cut -d ">" -f 1)
echo "from_address = $from_address"
to_address=$(echo $to | cut -d : -f 2 | cut -d "<" -f 2 |cut -d ">" -f 1)
echo "to_address = $to_address"

cat $1 | msmtp -a $from_address $to_address
