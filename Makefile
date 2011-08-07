html : book/* templates/*
	mkdir -p html
	mkdir -p html/images
	cp -u book/images/* html/images/
	cp -u templates/guide.css html/
	cp -u templates/index.html html/
	pandoc -f markdown -t html book/ch1.markdown -s --template=templates/chapter.template -c guide.css --indented-code-classes="brush: ruby" -V nextlink=ch2.html -V lang=ru -H templates/google_analytics.inc -o html/ch1.html
	pandoc -f markdown -t html book/ch2.markdown -s --template=templates/chapter.template -c guide.css --indented-code-classes="brush: ruby" -V nextlink=ch3.html -V lang=ru -H templates/google_analytics.inc -o html/ch2.html
	pandoc -f markdown -t html book/ch3.markdown -s --template=templates/chapter.template -c guide.css --indented-code-classes="brush: ruby" -o html/ch3.html -H templates/google_analytics.inc -V lang=ru -V nextlink=ch4.html
	pandoc -f markdown -t html book/ch4.markdown -s --template=templates/chapter.template -c guide.css --indented-code-classes="brush: ruby" -o html/ch4.html -H templates/google_analytics.inc -V lang=ru
ftp : html/*
	mkdir -p publish
	rm -rf publish/*
	tar -N .publish_stamp -cf - html/* | tar -x -C publish --overwrite
	touch .publish_stamp
	ftp -v < templates/upload.in
clean :
	rm -rf html
