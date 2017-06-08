.PHONY: all test clean

all:
	jbuilder build --dev

test:
	jbuilder build --dev test/test_hook_server.exe

clean:
	jbuilder clean
