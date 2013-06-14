.PHONY: clean test pass

node_modules: 
	npm install .

clean:
	rm -rf ./node_modules/

test: node_modules
	./test/run.sh

pass/%:
	cp test/results/$(subst pass/,,$@) test/expected/$(subst pass/,,$@)
