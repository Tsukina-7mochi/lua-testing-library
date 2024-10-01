local describe = require("src.test").describe
local test = require("src.test").test
local expect = require("src.test").expect

describe("toBeCloseTo", function()
    test("0.1 + 0.2 is not to be 0.3", function()
        expect(0.1 + 0.2).not_:toBe(0.3)
    end)

    test("0.1 + 0.2 is close to 0.3", function()
        expect(0.1 + 0.2):toBeCloseTo(0.3)
    end)

    test("inf is close to inf", function()
        expect(1 / 0):toBeCloseTo(1 / 0)
    end)

    test("-inf is close to -inf", function()
        expect(-1 / 0):toBeCloseTo(-1 / 0)
    end)

    test("inf is not close to -inf", function()
        expect(1 / 0).not_:toBeCloseTo(-1 / 0)
    end)
end)
