bookname=book01
cd ../build4
mv assets $bookname
zip -r ../$bookname.zip $bookname
mv $bookname assets
cd ../tmplt