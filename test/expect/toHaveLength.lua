local describe = require("src.test").describe
local test = require("src.test").test
local expect = require("src.test").expect

describe("toHaveLength", function()
    test("\"123\" haves length 3", function()
        expect("123"):toHaveLength(3)
    end)

    test("\"123\" does not have length 4", function()
        expect("123").not_:toHaveLength(4)
    end)

    test("{ 1, 2, 3 } haves length 3", function()
        expect({ 1, 2, 3 }):toHaveLength(3)
    end)

    test("{ 1, 2, 3 } does not have length 4", function()
        expect({ 1, 2, 3 }).not_:toHaveLength(4)
    end)
end)
