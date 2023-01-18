local ls = require("luasnip")
-- some shorthands...

ls.add_snippets(nil, {
	typescript = {
		ls.parser.parse_snippet("ctor", "constructor($1) {\n	// $2\n	}"),
		ls.parser.parse_snippet("enum", "export enum $1 {\n $2 \n };$0"),
		ls.parser.parse_snippet("clg", "console.log(`$1`, '👈')"),
		ls.parser.parse_snippet(
			"new Promise",
			"const $1 = (): Promise<$2> =>\n new Promise<$2>((resolve, reject) => {\n $3;\n });"
		),
		ls.parser.parse_snippet(
			"sleep",
			"const sleep = (ms: number): Promise<void> => new Promise((resolve) => setTimeout(resolve, ms));"
		),
	},
})
