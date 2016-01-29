for i in ~/markdown/*.md; 
    do
        fbname=$(basename "$i");
        echo $fbname;
        markdown --html4tags $i > ~/markdown/html/$fbname.html;
done;
