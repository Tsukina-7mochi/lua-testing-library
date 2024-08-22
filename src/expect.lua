---@class Expectation
---@field value any
---@field negated boolean
---@field not_ Expectation
---@overload fun(value: any): Expectation
local expect = {}

---@param value any
---@return boolean
local function isExpectation(value)
    if type(value) ~= "table" then
        return false
    end

    local meta = getmetatable(value)
    while meta ~= nil do
        if meta.__index == expect then
            return true
        end

        meta = getmetatable(meta.__index)
    end

    return false
end

---@param value any
local function assertExpectation(value)
    assert(
        isExpectation(value),
        "Received value seems not to be Expectation.\nPerhaps you are using \".\" instead of \":\" to call the method?"
    )
end

---@private
---@param pass boolean
---@param message string
---@param negMessage string
function expect.assert(self, pass, message, negMessage)
    if not self.negated then
        assert(pass, message)
    else
        assert(not pass, negMessage)
    end
end

---Expects `==` equality.
---@param expected any
function expect.toBe(self, expected)
    assertExpectation(self)

    self:assert(
        self.value == expected,
        string.format(
            "expect(received):toBe(expected)\nExpected: %s\nReceived: %s",
            tostring(expected),
            tostring(self.value)
        ),
        string.format(
            "expect(received).not_:toBe(expected)\nExpected not: %s\nReceived: %s",
            tostring(expected),
            tostring(self.value)
        )
    )
end

---Expects approximate equality of floating numbers.
---@param number number
---@param numDigits integer?
function expect.toBeCloseTo(self, number, numDigits)
    assertExpectation(self)

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

    local received = math.abs(self.value - number)
    local expected = (10 ^ -(numDigits)) / 2

    self:assert(
        received < expected,
        string.format(
            "expect(received):toBeCloseTo\nExpected diff: <%f\nReceived:%f",
            expected,
            received
        ),
        string.format(
            "expect(received).not_toBeCloseTo\nExpected diff: >%f\nReceived:%f",
            expected,
            received
        )
    )
end

---Expects falsy values: false and nil.
function expect.toBeFalsy(self)
    assertExpectation(self)

    self:assert(
        not self.value,
        string.format("expect(received):toBeFalsy()\nReceived: %s", tostring(self.value)),
        string.format("expect(received).not_:toBeFalsy()\nReceived: %s", tostring(self.value))
    )
end

---@param another any
function expect.toBeGraterThan(self, another)
    assertExpectation(self)

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
end

---@param another any
function expect.toBeGraterThanOrEqual(self, another)
    assertExpectation(self)

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
end

---@param another any
function expect.toBeLessThan(self, another)
    assertExpectation(self)

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
end

---@param another any
function expect.toBeLessThanOrEqual(self, another)
    assertExpectation(self)

    self:assert(
        self.value <= another,
        string.format(
            "expect(received):toBeGraterThan(number)\nExpected: <=%s\nReceived: %s",
            tostring(another),
            tostring(self.value)
        ),
        string.format(
            "expect(received).not_:toBeGraterThan(number)\nExpected: >%s\nReceived: %s",
            tostring(another),
            tostring(self.value)
        )
    )
end

function expect.toBeNil(self)
    assertExpectation(self)

    self:assert(
        self.value == nil,
        string.format(
            "expect(received):toBeNil()\nReceived: %s",
            tostring(self.value)
        ),
        string.format(
            "expect(received).not_:toBeNil()\nReceived: %s",
            tostring(self.value)
        )
    )
end

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
