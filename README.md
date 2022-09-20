# du-unit-testing

The files in this repository sets up a runtime environment to be used when running unit tests for code targeting Dual Universe using the [Busted](https://lunarmodules.github.io/busted) unit testing framework

## Instructions

Add this repository as a submodule (or otherwise make it available to your code) and make sure to get all sub repositories too:

```bash
git submodule add git@github.com:PerMalmberg/du-unit-testing.git external/du-unit-testing
git submodule update --recursive --checkout --init
```

Next, setup your LUA_PATH to include the following folders from the root of this repo:
* src/?.lua
* external/du-lua-examples/?.lua
* external/du-lua-examples/api-mockup/?.lua
* external/du-luac/lua/?.lua

Finally, `local env = require("environment")` in your code in which you need the environment available. As Busted runs all test files in isolation, you can likely do that at the top of your unit test file. Then do `env.Prepare()` to setup the environment. Each call to `Prepare` replaces the environment with a fresh copy of the DU-related globals.