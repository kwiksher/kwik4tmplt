bookname=book01
cp ~/Documents/Kwik/BookServer/copyright.txt ../build4/assets/copyright.txt
cp ../build4/model.json  ../build4/assets/model.json
cd ../build4
mv assets $bookname
zip -r ../$bookname.zip $bookname
mv $bookname assets
cd ../tmplt