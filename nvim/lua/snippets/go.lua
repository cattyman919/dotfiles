local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
	-- Trigger: "ife" -> expands to if err != nil check
	s("ife", {
		t("if err != nil {"),
		t({ "", "\t" }), -- newline and indent
		t("return "),
		i(1, "nil"),
		t(", "),
		i(2, 'fmt.Errorf("failed to %v: %w", err)'),
		t({ "", "}" }),
		i(0),
	}),

	-- Trigger: "json" -> struct tag
	s("json", {
		t('`json:"'),
		i(1, "name"),
		t('"`'),
	}),
}
