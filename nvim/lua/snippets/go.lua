local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

-- Helper function to get the first letter of the struct type
-- Example: "MyStruct" -> "m"
local function get_receiver(args)
	local text = args[1][1] or ""
	if text == "" then
		return "r"
	end
	return string.sub(text, 1, 1):lower()
end

return {
	-- 1. METHOD ON STRUCT (Smart Receiver)
	-- Trigger: meth
	-- Usage: Type the struct name, and the receiver 'r' will auto-update.
	s(
		"meth",
		fmt(
			[[
    func ({receiver} *{type}) {method}({args}) {ret} {{
      {body}
    }}
    ]],
			{
				type = i(1, "Type"),
				receiver = f(get_receiver, { 1 }),
				method = i(2, "MethodName"),
				args = i(3),
				ret = i(4), -- Matches the {ret} placeholder above
				body = i(0),
			}
		)
	),

	-- 2. IF ERR != NIL (Standard)
	s("ife", {
		t("if err != nil {"),
		t({ "", "\t" }),
		t("return "),
		i(1, "nil"),
		t(", "),
		i(2, "err"), -- Simple return err
		t({ "", "}" }),
		i(0),
	}),

	-- 3. IF ERR != NIL WRAPPED (fmt.Errorf)
	-- Trigger: ifew
	s("ifew", {
		t("if err != nil {"),
		t({ "", "\t" }),
		t("return "),
		i(1, "nil"),
		t(", "),
		t('fmt.Errorf("'),
		i(2, "context"),
		t(': %w", err)'),
		t({ "", "}" }),
		i(0),
	}),

	-- 4. FOR RANGE LOOP
	-- Trigger: forr
	s(
		"forr",
		fmt(
			[[
    for {k}, {v} := range {iter} {{
      {body}
    }}
    ]],
			{
				k = i(1, "_"),
				v = i(2, "v"),
				iter = i(3, "items"),
				body = i(0),
			}
		)
	),

	-- 5. BASIC TEST FUNCTION
	-- Trigger: test
	s(
		"test",
		fmt(
			[[
    func Test{name}(t *testing.T) {{
      {body}
    }}
    ]],
			{
				name = i(1, "Name"),
				body = i(0),
			}
		)
	),

	-- 6. SUB-TEST (t.Run)
	-- Trigger: tr
	s(
		"tr",
		fmt(
			[[
    t.Run("{name}", func(t *testing.T) {{
      {body}
    }})
    ]],
			{
				name = i(1, "case"),
				body = i(0),
			}
		)
	),

	-- 7. JSON TAG (Existing)
	s("json", {
		t('`json:"'),
		i(1, "name"),
		t('"`'),
	}),

	-- 8. YAML TAG
	s("yaml", {
		t('`yaml:"'),
		i(1, "name"),
		t('"`'),
	}),
}
