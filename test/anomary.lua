local describe = require("src.test").describe
local test = require("src.test").test
local expect = require("src.expect")

describe("anomary", function()
    test("not an expectation", function()
        expect(0).toBe()
    end)

    test("expect.toBe", function()
        expect(0):toBe(1)
    end)

    test("expect.not_.toBe", function()
        expect(0).not_:toBe(0)
    end)

    test("expect.toBeCloseTo", function()
        expect(0):toBeCloseTo(1)
    end)

    test("expect.not_.toBeCloseTo", function()
        expect(0).not_:toBeCloseTo(1)
    end)

    test("expect.toBeTruthy", function()
        expect(false):toBeTruthy()
    end)

    test("expect.not.toBeTruthy", function()
        expect(true).not_:toBeTruthy()
    end)

    test("expect.toBeFalsy", function()
        expect(true):toBeFalsy()
    end)

    test("expect.not.toBeFalsy", function()
        expect(false).not_:toBeFalsy()
    end)

    test("expect.toBeGraterThan", function()
        expect(0):toBeGraterThan(1)
    end)

    test("expect.not.toBeGraterThan", function()
        expect(1).not_:toBeGraterThan(0)
    end)

    test("expect.toBeGraterThanOrEqual", function()
        expect(0):toBeGraterThanOrEqual(1)
    end)

    test("expect.not.toBeGraterThanOrEqual", function()
        expect(1).not_:toBeGraterThanOrEqual(0)
    end)

    test("expect.toBeLessThan", function()
        expect(1):toBeLessThan(0)
    end)

    test("expect.not.toBeLessThan", function()
        expect(0).not_:toBeLessThan(1)
    end)

    test("expect.toBeLessThanOrEqual", function()
        expect(1):toBeLessThanOrEqual(0)
    end)

    test("expect.not.toBeLessThanOrEqual", function()
        expect(0).not_:toBeLessThanOrEqual(1)
    end)

    test("expect.toBeNil", function()
        expect(0):toBeNil()
    end)

    test("expect.not.toBeNil", function()
        expect(nil).not_:toBeNil()
    end)

    test("expect.toContain", function()
        expect({ 1, 2, 3 }):toContain(0)
    end)

    test("expect.not.toContain", function()
        expect({ 1, 2, 3 }).not_:toContain(1)
    end)

    test("expect.toEqual", function()
        expect({ a = { b = 1 } }):toEqual({ a = { b = 2 } })
    end)

    test("expect.not.toEqual", function()
        expect({ a = { b = 1 } }).not_:toEqual({ a = { b = 1 } })
    end)

    test("expect.toHaveLength", function()
        expect("123"):toHaveLength(4)
    end)

    test("expect.not.toHaveLength", function()
        expect("123").not_:toHaveLength(3)
    end)

    test("expect.toMatch", function()
        expect("abc123a"):toMatch("^%l+%d+$")
    end)

    test("expect.not.toMatch", function()
        expect("abc123").not_:toMatch("^%l+%d+$")
    end)
end)
