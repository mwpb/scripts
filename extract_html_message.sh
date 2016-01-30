# Rip the html part out 

rm -r ~/tmp/ripmime
mkdir ~/tmp/ripmime
ripmime -i $1 -d ~/tmp/ripmime

# Determine which bit is the html part

contains_html=0
#echo $contains_html
for f in ~/tmp/ripmime/*
do
filetype=$(file -i $f | cut -d : -f 2 | cut -d ';' -f 1)
echo $filetype
if [ $filetype = "text/html" ]; then
    let contains_html=1
    open $f
fi
done

