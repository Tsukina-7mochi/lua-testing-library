---@class Expectation
---@field value any
---@field negated boolean
---@field not_ Expectation
---@overload fun(value: any): Expectation
local expect = {
    ---@private
    ---@param pass boolean
    ---@param message string
    ---@param negMessage string
    assert = function(self, pass, message, negMessage)
        if not self.negated then
            assert(pass, message)
        else
            assert(not pass, negMessage)
        end
    end,

    ---Expects `==` equality.
    ---@param expected any
    toBe = function(self, expected)
        self:assert(
            self.value == expected,
            string.format(
                "expect(received).toBe(expected)\nExpected: %s\nActual: %s",
                tostring(expected),
                tostring(self.value)
            ),
            string.format(
                "expect(received).toBe(expected)\nExpected not: %s\nActual: %s",
                tostring(expected),
                tostring(self.value)
            )
        )
    end,
}

setmetatable(expect --[[@as table]], {
    __call = function(_, value)
        local obj = { value = value, negated = false }
        local notObj = { negated = true }
        obj.not_, notObj.not_ = notObj, obj

        setmetatable(obj, { __index = expect })
        setmetatable(notObj, { __index = obj })

        return obj
    end
})

return expect
