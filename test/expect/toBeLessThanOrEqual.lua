local describe = require("src.test").describe
local test = require("src.test").test
local expect = require("src.test").expect

describe("toBeLessThanOrEqual", function()
    test("0 is less than 1", function()
        expect(0):toBeLessThanOrEqual(1)
    end)

    test("0 is equals to 0", function()
        expect(0):toBeLessThanOrEqual(0)
    end)

    test("1 is not less or equals to than 0", function()
        expect(1).not_:toBeLessThanOrEqual(0)
    end)

    test("\"aaa\" is less than \"aab\"", function()
        expect("aaa"):toBeLessThanOrEqual("aab")
    end)
end)
