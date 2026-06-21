local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

local function titleCase(str)
	return (str:gsub("(%l)(%w*)", function(first, rest)
		return string.upper(first) .. rest
	end))
end

return {
	s("jc", {
		t("{/* "),
		i(1, "type anything here"), -- Your cursor will land here
		t(" */}"),
	}),

	s(
		"compt",
		fmt(
			[[
     const {title}{functionName} = () => {{
       return <div className=""> {repName}{functionName} </div>
     }}

     export default {repName}{functionName}
    ]],
			{
				functionName = f(function()
					return titleCase(vim.fn.expand("%:t:r"))
				end),
				title = i(1, ""),
				repName = rep(1),
			}
		)
	),
}
