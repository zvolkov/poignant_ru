compile : .publish_stamp html/images html/guide.css html/index.html html/ch1.html html/ch2.html html/ch3.html html/ch4.html html/copyright.html html/help.html 

html : 
	mkdir html

html/images : book/images | html
	mkdir -p html/images
	cp -u book/images/* html/images/

html/guide.css : templates/guide.css | html
	cp -u templates/guide.css html/

html/index.html : templates/index.html | html
	cp -u templates/index.html html/

html/ch1.html : book/ch1.markdown templates/chapter.template templates/google_analytics.inc | html
	pandoc -f markdown -t html book/ch1.markdown -s --template=templates/chapter.template -c guide.css --indented-code-classes="brush: ruby" -V nextlink=ch2.html -V lang=ru -H templates/google_analytics.inc -o html/ch1.html

html/ch2.html : book/ch2.markdown templates/chapter.template templates/google_analytics.inc | html
	pandoc -f markdown -t html book/ch2.markdown -s --template=templates/chapter.template -c guide.css --indented-code-classes="brush: ruby" -V nextlink=ch3.html -V lang=ru -H templates/google_analytics.inc -o html/ch2.html

html/ch3.html : book/ch3.markdown templates/chapter.template templates/google_analytics.inc | html
	pandoc -f markdown -t html book/ch3.markdown -s --template=templates/chapter.template -c guide.css --indented-code-classes="brush: ruby" -o html/ch3.html -H templates/google_analytics.inc -V lang=ru -V nextlink=ch4.html

html/ch4.html : book/ch4.markdown templates/chapter.template templates/google_analytics.inc | html
	pandoc -f markdown -t html book/ch4.markdown -s --template=templates/chapter.template -c guide.css --indented-code-classes="brush: ruby" -o html/ch4.html -H templates/google_analytics.inc -V lang=ru

html/copyright.html : book/copyright.markdown templates/chapter.template templates/google_analytics.inc | html
	pandoc -f markdown -t html book/copyright.markdown -s --template=templates/chapter.template -c guide.css -o html/copyright.html -H templates/google_analytics.inc -V lang=ru

html/help.html : book/help.markdown templates/chapter.template templates/google_analytics.inc | html
	pandoc -f markdown -t html book/help.markdown -s --template=templates/chapter.template -c guide.css -o html/help.html -H templates/google_analytics.inc -V lang=ru

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
