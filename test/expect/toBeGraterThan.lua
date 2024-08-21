local describe = require("src.test").describe
local test = require("src.test").test
local expect = require("src.expect")

describe("toBeGraterThan", function()
    test("1 is grater than 0", function()
        expect(1):toBeGraterThan(0)
    end)

    test("0 is not grater than 0", function()
        expect(0).not_:toBeGraterThan(0)
    end)

    test("0 is not grater than 1", function()
        expect(0).not_:toBeGraterThan(1)
    end)

    test("\"aab\" is grater than \"aaa\"", function()
        expect("aab"):toBeGraterThan("aaa")
    end)
end)
