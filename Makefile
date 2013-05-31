all: bin/bumpversion

bin/bumpversion:
	coffee -o bin/ -c src/
	mv bin/bumpversion.js bin/bumpversion

clean:
	rm -f bin/bumpversion
