local describe = require("src.test").describe
local test = require("src.test").test
local expect = require("src.expect")

describe("toBeLessThan", function()
    test("0 is less than 1", function()
        expect(0):toBeLessThan(1)
    end)

    test("0 is not less than 0", function()
        expect(0).not_:toBeLessThan(0)
    end)

    test("1 is not less than 0", function()
        expect(1).not_:toBeLessThan(0)
    end)

    test("\"aaa\" is less than \"aab\"", function()
        expect("aaa"):toBeLessThan("aab")
    end)
end)
