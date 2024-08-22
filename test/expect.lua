local describe = require("src.test").describe

describe("nomality", function()
    require("test.expect.toBe")
    require("test.expect.toBeCloseTo")
    require("test.expect.toBeTruthy")
    require("test.expect.toBeFalsy")
    require("test.expect.toBeGraterThan")
    require("test.expect.toBeGraterThanOrEqual")
    require("test.expect.toBeLessThan")
    require("test.expect.toBeLessThanOrEqual")
    require("test.expect.toBeNil")
end)
