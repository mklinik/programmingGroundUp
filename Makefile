DIRECTORIES = bin _build
# --gstabs tells the assembler to include debugging information
ASFLAGS=--gstabs

.PHONY: clean test

test:
	@echo $(DIRECTORIES)

_build/%.o: %.s $(DIRECTORIES)
	as $(ASFLAGS) $< -o $@

bin/%: _build/%.o $(DIRECTORIES)
	ld $< -o $@

_build:
	mkdir -p _build

bin:
	mkdir -p bin

clean:
	rm -r _build
	rm -r bin
