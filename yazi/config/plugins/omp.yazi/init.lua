local save = ya.sync(function(st, cwd, output)
  if cx.active.current.cwd == Url(cwd) then
    st.output = output
    ya.render()
  end
end)

return {
  setup = function(st)
    Header:children_remove(1, Header.LEFT)
    Header:children_add(function()
      return ui.Line.parse(st.output or "")
    end, 1000, Header.LEFT)

    ps.sub("cd", function()
      local cwd = cx.active.current.cwd
      if st.cwd ~= cwd then
        st.cwd = cwd
        ya.manager_emit("plugin", { st._id, args = ya.quote(tostring(cwd), true) })
      end
    end)
  end,

  entry = function(_, args)
    local output = Command("oh-my-posh")
        :args({
          "print",
          "primary",
          "--no-status",
          "-c",
          "C:/Users/LENOVO/AppData/Roaming/yazi/config/plugins/omp.yazi/yazi-prompt.omp.json",
        })
        :cwd(args[1])
        :output()
    if output then
      save(args[1], output.stdout:gsub("^%s+", ""))
    end
  end,
}
