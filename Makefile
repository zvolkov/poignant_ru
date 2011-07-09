html : book/*
	rm -rf html
	mkdir html
	mkdir html/images
	cp book/images/* html/images/
	cat templates/header.html > html/ch1.html
	markdown book/ch1.markdown >> html/ch1.html
	cat templates/footer.html >> html/ch1.html

clean :
	rm -rf html
