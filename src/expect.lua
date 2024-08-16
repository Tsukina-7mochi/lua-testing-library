---@class Expectation
---@field value any
---@field negated boolean
---@field not_ Expectation
---@overload fun(value: any): Expectation
local expect = {
    ---@private
    assert = function(self, pass, message, negMessage)
        if not self.negated then
            assert(pass, message)
        else
            assert(not pass, negMessage)
        end
    end,

    ---Expects `==` equality.
    ---@param other any
    toBe = function(self, other)
        self:assert(
            self.value == other,
            tostring(self.value) .. " and " .. tostring(other) .. " is not equal.",
            tostring(self.value) .. " and " .. tostring(other) .. " is equal."
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
