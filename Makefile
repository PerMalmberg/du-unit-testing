.PHONY: clean test
PWD=$(shell pwd)

LUA_PATH := ./src/?.lua
LUA_PATH := $(LUA_PATH);$(PWD)/external/du-lua-examples/?.lua
LUA_PATH := $(LUA_PATH);$(PWD)/external/du-lua-examples/api-mockup/?.lua
LUA_PATH := $(LUA_PATH);$(PWD)/external/du-luac/lua/?.lua

all: test

clear_screen:
	clear

lua_path:
	@echo "$(LUA_PATH)"

test: clear_screen
	@LUA_PATH="$(LUA_PATH)" busted .
