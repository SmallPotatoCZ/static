SHELL := /bin/bash

all: list convert

list:
	@source scripts/updatedata.sh

convert:
	@source scripts/convertimg.sh

add:
	@source scripts/generateImgs.sh

.PHONY: list convert add