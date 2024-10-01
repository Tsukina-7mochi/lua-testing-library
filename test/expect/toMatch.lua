local describe = require("src.test").describe
local test = require("src.test").test
local expect = require("src.test").expect

describe("toMatch", function()
    test("\"abc123\" matches \"^%l+%d+$", function()
        expect("abc123"):toMatch("^%l+%d+$")
    end)

    test("\"abc123a\" does not match \"^%l+%d+$", function()
        expect("abc123a").not_:toMatch("^%l+%d+$")
    end)
end)
