html : book/* templates/*
	rm -rf html
	mkdir html
	mkdir html/images
	cp book/images/* html/images/
	cp templates/guide.css html/
	#ch1
	cat templates/header.html > html/ch1.html
	markdown book/ch1.markdown >> html/ch1.html
	sed -e "s/chX/ch2/g" templates/footer.html >> html/ch1.html
	#ch2
	cat templates/header.html > html/ch2.html
	markdown book/ch2.markdown >> html/ch2.html
	sed -e "s/chX/ch3/g" templates/footer.html >> html/ch2.html
	#ch3
	cat templates/header.html > html/ch3.html
	markdown book/ch3.markdown >> html/ch3.html
	sed -e "s/chX/ch4/g" templates/footer.html >> html/ch3.html

clean :
	rm -rf html
