SHELL := /bin/bash

all: list convert

list:
	@source scripts/updatedata.sh

convert:
	@source scripts/convertimg.sh

.PHONY: list convert