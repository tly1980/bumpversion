all: bin/bumpversion

bin/bumpversion:
	coffee -o bin/ -c src/
	mv bin/bumpversion.js bin/bumpversion

test:
	coffee -o tests/ -c tests/
	mocha tests

clean:
	rm -f bin/bumpversion

.PHONY:
	test clean
