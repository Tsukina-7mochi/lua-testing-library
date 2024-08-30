local describe = require("src.test").describe
local test = require("src.test").test
local expect = require("src.expect")

describe("toEqual", function()
    test("1 + 2 equals to 3", function()
        expect(1 + 2):toEqual(3)
    end)

    test("1 + 2 not euqlas to 4", function()
        expect(1 + 2).not_:toEqual(4)
    end)

    test("{}", function()
        expect({}):toEqual({})
    end)

    test("{ a = 1, b = \"abc\" }", function()
        expect({ a = 1, b = "abc" }):toEqual({ a = 1, b = "abc" })
    end)

    test("{ a = 1 } not equals { a = 2 }", function()
        expect({ a = 1 }).not_:toEqual({ a = 2 })
        expect({ a = 2 }).not_:toEqual({ a = 1 })
    end)

    test("{ 1, 2, 3, \"a\", \"b\", true }", function()
        expect({ 1, 2, 3, "a", "b", true }):toEqual({ 1, 2, 3, "a", "b", true })
    end)

    test("{ a = { b = { c = { 1 } } } }", function()
        expect({ a = { b = { c = { 1 } } } }):toEqual({ a = { b = { c = { 1 } } } })
    end)
end)
