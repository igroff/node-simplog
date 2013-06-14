.PHONY: clean test pass

node_modules: 
	npm install .

test/results:
	mkdir -p test/results

clean:
	rm -rf ./node_modules/

test: node_modules test/results
	./test/run.sh

pass/%:
	cp test/results/$(subst pass/,,$@) test/expected/$(subst pass/,,$@)
