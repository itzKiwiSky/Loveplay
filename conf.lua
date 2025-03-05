function love.conf(w)
    w.window.icon           =       "icon.png"
    w.window.title          =       "Cinnamon Project"

    --% Debug %--
    w.console               =       not love.filesystem.isFused()

    --% Storage %--
    w.externalstorage       =       true
end