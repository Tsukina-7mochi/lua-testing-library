LUA = lua
DIST = dist
NEBLUA = ./library/neblua-cli.lua

all: build

$(DIST):
	mkdir -p $(DIST)

$(NEBLUA):
	mkdir -p ./library
	curl -sSL https://github.com/Tsukina-7mochi/neblua/releases/latest/download/neblua-cli.lua > $(NEBLUA)

build: $(DIST) $(NEBLUA)
	$(LUA) $(NEBLUA) -e src.test -o ./dist/test.lua ./src/test.lua

.PHONY: test
test:
	$(LUA) ./test/expect.lua

.PHONY: clean
clean:
	rm -rf $(DIST)
