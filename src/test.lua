---@alias DescribeFunc fun(name: string, func: fun(context: TestContext))
---@alias TestFunc fun(name: string, func: fun())

---@class Test
---@field name string
---@field func function

---@class TestContext
---@field parent TestContext | nil
---@field name string
---@field children (Test | TestContext)[]


---@type TestContext | nil
_ENV.__testContext = nil


local function chalkGreen(text)
    return "\x1b[92m" .. text .. "\x1b[0m"
end

local function chalkRed(text)
    return "\x1b[91m" .. text .. "\x1b[0m"
end

local successMark = chalkGreen("✔")
local failMark = chalkRed("✘")

---@param ctx TestContext | Test
---@param indent integer
local function dumpTest(ctx, indent)
    if ctx.children ~= nil then
        print(("  "):rep(indent) .. ctx.name .. "(" .. #ctx.children .. ")")
        for _, child in ipairs(ctx.children) do
            dumpTest(child, indent + 1)
        end
    else
        print(("  "):rep(indent) .. "*" .. ctx.name)
    end
end

---@alias TestError { name: string, error: string }
---@param ctx TestContext | Test
---@param depth integer
---@return TestError[]
local function performTest(ctx, depth)
    ---@type TestError[]
    local errors = {}


    if ctx.func ~= nil then
        --node is Test
        io.stdout:write(("  "):rep(depth) .. ctx.name)
        io.stdout:flush()

        local success, err = pcall(ctx.func)
        if success then
            print(successMark)
        else
            print(failMark)
            table.insert(errors, {
                name = ctx.name,
                error = tostring(err),
            })
        end
    else
        --node is test context
        print(("  "):rep(depth) .. ctx.name)

        local numErrors = 0
        for _, c in ipairs(ctx.children) do
            local succeeded = true
            for _, err in ipairs(performTest(c, depth + 1)) do
                succeeded = false
                table.insert(errors, {
                    name = ctx.name .. " > " .. err.name,
                    error = err.error,
                })
            end

            if not succeeded then
                numErrors = numErrors + 1
            end
        end

        if numErrors == 0 then
            print(("  "):rep(depth) .. ctx.name .. successMark)
        else
            local errorText = string.format("(%d/%d)", #ctx.children - numErrors, #ctx.children)
            print(("  "):rep(depth) .. ctx.name .. failMark .. " " .. errorText)
        end
    end

    if depth == 0 then
        print(string.format("%d test(s) failed:", #errors))
        for _, err in ipairs(errors) do
            print()
            print("Error in " .. err.name)
            print(err.error)
        end
    end

    return errors
end


---Define test context
---@param name string
---@param func fun()
local function describe(name, func)
    ---@type TestContext
    local ctx = {
        parent = nil,
        name = name,
        children = {}
    }

    if _ENV.__testContext ~= nil then
        table.insert(_ENV.__testContext.children, ctx)
        ctx.parent = _ENV.__testContext
    end

    _ENV.__testContext = ctx

    func()

    if _ENV.__testContext.parent == nil then
        --dumpTest(_ENV.__testContext, 0)
        if #performTest(_ENV.__testContext, 0) ~= 0 then
            os.exit(1)
        end
    else
        _ENV.__testContext = _ENV.__testContext.parent
    end
end

---Define test
---@param name string
---@param func fun()
local function test(name, func)
    if _ENV.__testContext == nil then
        _ENV.__testContext = {
            parent = nil,
            name = "(anonymous)",
            children = {},
        }
    end

    table.insert(_ENV.__testContext.children, {
        name = name,
        func = func,
    })
end

return {
    test = test,
    describe = describe,
}
