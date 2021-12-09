.PHONY: setup clean get test publish ci distribute

setup:
	flutter channel stable
	flutter upgrade
	
clean:
	flutter clean
	cd example && flutter clean

get:
	flutter pub get
	cd example && flutter pub get

test:
	flutter analyze
	flutter format --dry-run --set-exit-if-changed lib
	cd example && flutter analyze
	cd example && flutter format --dry-run --set-exit-if-changed lib

publish:
	flutter pub publish

ci: get test

distribute: setup clean get test publish