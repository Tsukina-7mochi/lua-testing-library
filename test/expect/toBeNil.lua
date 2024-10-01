local describe = require("src.test").describe
local test = require("src.test").test
local expect = require("src.test").expect

describe("toBeNil", function()
    test("nil is nil", function()
        expect(nil):toBeNil()
    end)

    test("false is not nil", function()
        expect(false).not_:toBeNil()
    end)
end)
