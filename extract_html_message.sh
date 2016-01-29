# Rip the html part out 

rm -r /Users/mat/tmp/ripmime
mkdir /Users/mat/tmp/ripmime
ripmime -i $1 -d /Users/mat/tmp/ripmime

# Determine which bit is the html part

contains_html=0
#echo $contains_html
for f in /Users/mat/tmp/ripmime/*
do
filetype=$(file -i $f | cut -d : -f 2 | cut -d ';' -f 1)
echo $filetype
if [ $filetype = "text/html" ]; then
    let contains_html=1
    open $f
fi
done

