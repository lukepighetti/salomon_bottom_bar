.PHONY: setup clean format test distribute

setup:
	flutter channel stable
	flutter upgrade
	
clean:
	flutter clean
	flutter pub get
	cd example && flutter clean
	cd example && flutter pub get

test:
	flutter analyze
	flutter format --dry-run --set-exit-if-changed lib
	cd example && flutter analyze
	cd example && flutter format --dry-run --set-exit-if-changed lib

distribute: setup clean test
	flutter pub publish