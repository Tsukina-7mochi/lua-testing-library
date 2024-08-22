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
                "expect(received):toBe(expected)\nExpected: %s\nActual: %s",
                tostring(expected),
                tostring(self.value)
            ),
            string.format(
                "expect(received).not_:toBe(expected)\nExpected not: %s\nActual: %s",
                tostring(expected),
                tostring(self.value)
            )
        )
    end,

    ---Expects approximate equality of floating numbers.
    ---@param number number
    ---@param numDigits integer?
    toBeCloseTo = function(self, number, numDigits)
        if numDigits == nil then
            numDigits = 2
        end

        local inf = 1 / 0

        if self.value == inf and number == inf then
            --pass
            return
        elseif self.value == -inf and number == -inf then
            --pass
            return
        end

        local actual = math.abs(self.value - number)
        local expected = (10 ^ -(numDigits)) / 2

        self:assert(
            actual < expected,
            string.format(
                "expect(received):toBeCloseTo\nExpected diff: <%f\nActual:%f",
                expected,
                actual
            ),
            string.format(
                "expect(received).not_toBeCloseTo\nExpected diff: >%f\nActual:%f",
                expected,
                actual
            )
        )
    end,

    toBeFalsy = function(self)
        self:assert(
            not self.value,
            string.format("expect(received):toBeFalsy()\nReceived: %s", tostring(self.value)),
            string.format("expect(received).not_:toBeFalsy()\nReceived: %s", tostring(self.value))
        )
    end,

    ---@param another any
    toBeGraterThan = function(self, another)
        self:assert(
            self.value > another,
            string.format(
                "expect(received):toBeGraterThan(number)\nExpected: >%s\nReceived: %s",
                tostring(another),
                tostring(self.value)
            ),
            string.format(
                "expect(received).not_:toBeGraterThan(number)\nExpected: <=%s\nReceived: %s",
                tostring(another),
                tostring(self.value)
            )
        )
    end,

    ---@param another any
    toBeGraterThanOrEqual = function(self, another)
        self:assert(
            self.value >= another,
            string.format(
                "expect(received):toBeGraterThan(number)\nExpected: >=%s\nReceived: %s",
                tostring(another),
                tostring(self.value)
            ),
            string.format(
                "expect(received).not_:toBeGraterThan(number)\nExpected: <%s\nReceived: %s",
                tostring(another),
                tostring(self.value)
            )
        )
    end,

    ---@param another any
    toBeLessThan = function(self, another)
        self:assert(
            self.value < another,
            string.format(
                "expect(received):toBeGraterThan(number)\nExpected: <%s\nReceived: %s",
                tostring(another),
                tostring(self.value)
            ),
            string.format(
                "expect(received).not_:toBeGraterThan(number)\nExpected: >=%s\nReceived: %s",
                tostring(another),
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
