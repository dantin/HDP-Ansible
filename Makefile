
SOURCE_DIR := $(shell pwd)

DEFAULT: clean

.PHONE: clean
clean:
	@echo "Clean 'retry' files"
	@find $(SOURCE_DIR) -type f -name "*.retry" -delete
