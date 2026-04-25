return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
  dependencies = {
    -- include a picker of your choice, see picker section for more details
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    ---@type lc.lang
    lang = "python3",

    injector = { ---@type table<lc.lang, lc.inject>
      ["cpp"] = {
        imports = function()
          -- return a different list to omit default imports
          return { "#include <bits/stdc++.h>", "using namespace std;" }
        end,
        after = "int main() {}",
      },
      ["python3"] = {
        imports = function()
          return {
            "import collections",
            "import math",
            "import heapq",
            "import bisect",
            "import functools",
            "from typing import List, Optional, Any"
          }
        end
      },
      ["java"] = {
        imports = function()
          return {
            "import java.util.*;",
            "import java.math.*;"
          }
        end
      }
    },

    --@type boolean
    image_support = true,
  },
}
