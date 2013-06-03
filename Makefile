all: bin/bumpversion

version: bin/bumpversion
	bin/bumpversion -p -lc 2
	cp VERSION.json bin/bumpversion_VERSION.json

bin/bumpversion:
	coffee -o bin/ -c src/
	cp bin/bumpversion.js lib/bumpversion.js
	echo "#!/usr/bin/env node\n" > bin/bumpversion
	cat bin/bumpversion.js >> bin/bumpversion
	chmod a+x bin/bumpversion

test:
	coffee -o tests/ -c tests/
	mocha tests

clean:
	rm -f bin/bumpversion

.PHONY:
	test clean
