local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	-- Trigger: "p" -> println!
	s("p", {
		t('println!("'),
		i(1, "{}"),
		t('", '),
		i(2, "var"),
		t(");"),
	}),

	-- Trigger: "modtest" -> Test module boilerplate
	s("modtest", {
		t("#[cfg(test)]"),
		t({ "", "mod tests {", "\tuse super::*;", "", "\t#[test]", "\tfn " }),
		i(1, "it_works"),
		t("() {", "\t\t"),
		i(0),
		t({ "", "\t}", "}" }),
	}),
}
