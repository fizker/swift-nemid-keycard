.PHONY: install build xcode

build:
	swift build --configuration release

install:
	cp .build/release/nemid-keycard /usr/local/bin/

xcode:
	swift package generate-xcodeproj --enable-code-coverage
