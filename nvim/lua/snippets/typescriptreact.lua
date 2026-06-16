local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s("jc", {
		t("{/* "),
		i(1, "type anything here"), -- Your cursor will land here
		t(" */}"),
	}),
}
