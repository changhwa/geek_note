.PHONY: run
run:
	grunt coffee && grunt test && nodemon --debug bin/www --ignore store/**