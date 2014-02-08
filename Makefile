DIRECTORIES = bin _build

.PHONY: clean test

test:
	@echo $(DIRECTORIES)

_build/%.o: %.s $(DIRECTORIES)
	as $< -o $@

bin/%: _build/%.o $(DIRECTORIES)
	ld $< -o $@

_build:
	mkdir -p _build

bin:
	mkdir -p bin

clean:
	rm -r _build
	rm -r bin
