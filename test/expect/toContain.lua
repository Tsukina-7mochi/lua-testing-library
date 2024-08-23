local describe = require("src.test").describe
local test = require("src.test").test
local expect = require("src.expect")

describe("toContain", function()
    test("{ 1, 2, 3 } contains 1", function()
        expect({ 1, 2, 3 }):toContain(1)
    end)

    test("{ 1, 2, 3 } contains 2", function()
        expect({ 1, 2, 3 }):toContain(2)
    end)

    test("{ 1, 2, 3 } contains 3", function()
        expect({ 1, 2, 3 }):toContain(3)
    end)

    test("{ 1, 2, 3 } does not contain 4", function()
        expect({ 1, 2, 3 }).not_:toContain(4)
    end)

    test("{ a = 1, b = 2, c = 3 } does not contain 1", function()
        expect({ a = 1, b = 2, c = 3 }).not_:toContain(1)
    end)
end)
