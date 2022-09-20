local env = require("environment")

local Adder = {}
Adder.__index = Adder

function Adder.New()
    local s = {
        sum = 0
    }

    function s:Add(value1, value2)
        s.sum = s.sum + value1 + value2
    end

    function s:Sum()
        return s.sum
    end

    return setmetatable(s, Adder)
end

insulate("DU-LuaC test, part 1", function()
    env.Prepare()

    describe("Callable object handlers", function()
        local adder = Adder.New()

        -- Create a mock with spies (this replaces the actual Adder)
        local mockAdder = mock(adder)

        -- Register an event
        system:onEvent("onTick", adder.Add, adder)
        -- Trigger the event twice
        system:triggerEvent("onTick", 1, 2)
        system:triggerEvent("onTick", 3, 4)

        assert.spy(mockAdder.Add).was_called(2)
        assert.are.equal(10, adder:Sum())

        -- Revert the mock to run with the original
        mock.revert(mockAdder)
        system:triggerEvent("onTick", 5, 6)
        assert.are.equal(21, adder:Sum())
    end)
end)

insulate("DU-LuaC test, part 2", function()
    env.Prepare()

    describe("Regular function handler", function()
        local count = 0

        system:onEvent("anEvent", function()
            count = count + 1
        end)

        system:triggerEvent("anEvent")
        assert.are.equal(1, count)
    end)

    describe("Test unit-test setup", function()
        it("Can use callable table handlers added by DU-LuaC", function ()
            local adder = Adder.New()
            
            -- Create a mock with spies (this replaces the actual Adder)
            local mockAdder = mock(adder)

            -- Register an event
            system:onEvent("anEvent", adder.Add, adder)
            -- Trigger the event twice
            system:triggerEvent("anEvent", 1, 2)
            system:triggerEvent("anEvent", 3, 4)

            assert.spy(mockAdder.Add).was_called(2)
            assert.are.equal(10, adder:Sum())

            -- Revert the mock to run with the original
            mock.revert(mockAdder)
            system:triggerEvent("anEvent", 5, 6)
            assert.are.equal(21, adder:Sum())
        end)
    end)
end)