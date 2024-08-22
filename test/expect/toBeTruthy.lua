local describe = require("src.test").describe
local test = require("src.test").test
local expect = require("src.expect")

describe("toBeTruthy", function()
    test("true is truthy", function()
        expect(true):toBeTruthy()
    end)

    test("0 is truthy", function()
        expect(0):toBeTruthy()
    end)

    test("empty string is truthy", function()
        expect(""):toBeTruthy()
    end)

    test("false is not truthy", function()
        expect(false).not_:toBeTruthy()
    end)

    test("nil is not truthy", function()
        expect(nil).not_:toBeTruthy()
    end)
end)
