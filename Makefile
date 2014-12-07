.PHONY: run
run:
	grunt coffee && grunt test && nodemon --debug -w src -w public -w views -i store -e coffee,hbs,js bin/www