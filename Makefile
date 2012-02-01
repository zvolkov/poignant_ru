all : .publish_stamp html/images html/guide.css html/index.html html/ch1.html html/ch2.html html/ch3.html html/ch4.html html/copyright.html html/help.html

SHELL := bash

html : 
	mkdir html

html/images : book/images | html
	mkdir -p html/images
	cp -u book/images/* html/images/

html/guide.css : templates/guide.css | html
	cp -u templates/guide.css html/

html/index.html : templates/index.html | html
	cp -u templates/index.html html/

html/ch1.html : book/ch1.markdown book/author.markdown templates/chapter.template templates/google_analytics.inc | html
	pandoc -f markdown -t html book/author.markdown book/ch1.markdown -s --template=templates/chapter.template -c guide.css --indented-code-classes="brush: ruby" -V prevlink=index.html -V nextlink=ch2.html -V lang=ru -H templates/google_analytics.inc -o html/ch1.html

html/ch2.html : book/ch2.markdown book/author.markdown templates/chapter.template templates/google_analytics.inc | html
	pandoc -f markdown -t html book/author.markdown book/ch2.markdown -s --template=templates/chapter.template -c guide.css --indented-code-classes="brush: ruby" -V prevlink=ch1.html -V nextlink=ch3.html -V lang=ru -H templates/google_analytics.inc -o html/ch2.html

html/ch3.html : book/ch3.markdown book/author.markdown templates/chapter.template templates/google_analytics.inc | html
	pandoc -f markdown -t html book/author.markdown book/ch3.markdown -s --template=templates/chapter.template -c guide.css --indented-code-classes="brush: ruby" -V prevlink=ch2.html -V nextlink=ch4.html -V lang=ru -H templates/google_analytics.inc -o html/ch3.html

html/ch4.html : book/ch4.markdown book/author.markdown templates/chapter.template templates/google_analytics.inc | html
	pandoc -f markdown -t html book/author.markdown book/ch4.markdown -s --template=templates/chapter.template -c guide.css --indented-code-classes="brush: ruby" -V prevlink=ch3.html -V lang=ru -H templates/google_analytics.inc -o html/ch4.html

html/copyright.html : book/copyright.markdown book/author.markdown templates/chapter.template templates/google_analytics.inc | html
	pandoc -f markdown -t html book/author.markdown book/copyright.markdown -s --template=templates/chapter.template -c guide.css -V prevlink=index.html -V lang=ru -H templates/google_analytics.inc -o html/copyright.html

html/help.html : book/help.markdown book/author.markdown templates/chapter.template templates/google_analytics.inc | html
	pandoc -f markdown -t html book/author.markdown book/help.markdown -s --template=templates/chapter.template -c guide.css -V prevlink=index.html -V lang=ru -H templates/google_analytics.inc -o html/help.html

.publish_stamp : 
	touch .publish_stamp

publish : html/*
	mkdir -p publish
	tar -N .publish_stamp -cf - html/* | tar -x -C publish --overwrite
	touch .publish_stamp

ftp : publish
	ftp -v < templates/upload.in
	rm -rf publish/html/*

clean :
	rm -rf html
	rm -rf publish
	rm -f .publish_stamp
