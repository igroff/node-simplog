.PHONY: clean test pass

node_modules: 
	npm install .

log.js: node_modules
	./node_modules/.bin/coffee --output . --compile src/log.coffee

test/results:
	mkdir -p test/results

clean:
	rm -rf ./node_modules/

test: node_modules test/results log.js
	./test/run.sh

commit: test
	git commit -a
	git push origin master

pass/%:
	cp test/results/$(subst pass/,,$@) test/expected/$(subst pass/,,$@)
