local describe = require("src.test").describe
local test = require("src.test").test
local expect = require("src.expect")

describe("toBeGraterThanOrEqual", function()
    test("1 is grater than 0", function()
        expect(1):toBeGraterThanOrEqual(0)
    end)

    test("0 is equals to 0", function()
        expect(0):toBeGraterThanOrEqual(0)
    end)

    test("0 is not grater or equals to than 1", function()
        expect(0).not_:toBeGraterThanOrEqual(1)
    end)

    test("\"aab\" is grater than \"aaa\"", function()
        expect("aab"):toBeGraterThanOrEqual("aaa")
    end)

    test("\"aaa\" is grater than \"aaa\"", function()
        expect("aaa"):toBeGraterThanOrEqual("aaa")
    end)
end)
