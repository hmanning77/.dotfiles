---------------------------
-- Default awesome theme --
---------------------------

theme = {}

-- Colours
-- Based on baskerville_ivorylight retrieved from xcolors.net
theme.colourscheme = {}
theme.colourscheme.background =    "#FEF9EC"
theme.colourscheme.foreground =    "#6D727E"

theme.colourscheme.colorBD =       "#3E424D"
theme.colourscheme.colorIT =       "#3E424D"
theme.colourscheme.colorUL =       "#3E424D"

theme.colourscheme.cursorColor =   "#007693"

theme.colourscheme.white =         "#C5C1B4"
theme.colourscheme.strongwhite =   "#A1A6B2"

theme.colourscheme.black =         "#3E424D"
theme.colourscheme.strongblack =   "#282C36"

theme.colourscheme.red =           "#E75C58"
theme.colourscheme.strongred =     "#B22B31"

theme.colourscheme.yellow =        "#A08A00"
theme.colourscheme.strongyellow =  "#715F00"

theme.colourscheme.green =         "#00A250"
theme.colourscheme.stronggreen =   "#007427"

theme.colourscheme.cyan =          "#00A4C1"
theme.colourscheme.strongcyan =    "#007693"

theme.colourscheme.blue =          "#208FFB"
theme.colourscheme.strongblue =    "#0065CA"

theme.colourscheme.magenta =       "#D160C4"
theme.colourscheme.strongmagenta = "#A03196"

theme.font          = "sans 8"

theme.bg_normal     = theme.colourscheme.background
theme.bg_focus      = theme.colourscheme.strongwhite
theme.bg_urgent     = theme.colourscheme.strongred
theme.bg_minimize   = theme.colourscheme.white
theme.bg_systray    = theme.colourscheme.strongblack

theme.fg_normal     = theme.colourscheme.black
theme.fg_focus      = theme.colourscheme.blue
theme.fg_urgent     = theme.colourscheme.strongblack
theme.fg_minimize   = theme.colourscheme.foreground

theme.border_width  = 2
theme.border_normal = theme.colourscheme.strongwhite
theme.border_focus  = theme.colourscheme.blue
theme.border_marked = theme.colourscheme.strongmagenta

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "/home/hugh/.config/awesome/themes/diamond/taglist/squarefw.png"
theme.taglist_squares_unsel = "/home/hugh/.config/awesome/themes/diamond/taglist/squarew.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/home/hugh/.config/awesome/themes/diamond/submenu.png"
theme.menu_height = 25
theme.menu_width  = 200

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/home/hugh/.config/awesome/themes/diamond/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/home/hugh/.config/awesome/themes/diamond/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/home/hugh/.config/awesome/themes/diamond/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/home/hugh/.config/awesome/themes/diamond/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/home/hugh/.config/awesome/themes/diamond/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/home/hugh/.config/awesome/themes/diamond/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/home/hugh/.config/awesome/themes/diamond/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/home/hugh/.config/awesome/themes/diamond/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/home/hugh/.config/awesome/themes/diamond/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/home/hugh/.config/awesome/themes/diamond/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/home/hugh/.config/awesome/themes/diamond/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/home/hugh/.config/awesome/themes/diamond/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/home/hugh/.config/awesome/themes/diamond/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/home/hugh/.config/awesome/themes/diamond/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/home/hugh/.config/awesome/themes/diamond/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/home/hugh/.config/awesome/themes/diamond/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/home/hugh/.config/awesome/themes/diamond/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/home/hugh/.config/awesome/themes/diamond/titlebar/maximized_focus_active.png"

theme.wallpaper = "/home/hugh/.config/awesome/themes/diamond/wallpaper-greenglass.png"

-- You can use your own layout icons like this:
theme.layout_fairh = "/home/hugh/.config/awesome/themes/diamond/layouts/fairh.png"
theme.layout_fairv = "/home/hugh/.config/awesome/themes/diamond/layouts/fairv.png"
theme.layout_floating  = "/home/hugh/.config/awesome/themes/diamond/layouts/floating.png"
theme.layout_magnifier = "/home/hugh/.config/awesome/themes/diamond/layouts/magnifier.png"
theme.layout_max = "/home/hugh/.config/awesome/themes/diamond/layouts/max.png"
theme.layout_fullscreen = "/home/hugh/.config/awesome/themes/diamond/layouts/fullscreen.png"
theme.layout_tilebottom = "/home/hugh/.config/awesome/themes/diamond/layouts/tilebottom.png"
theme.layout_tileleft   = "/home/hugh/.config/awesome/themes/diamond/layouts/tileleft.png"
theme.layout_tile = "/home/hugh/.config/awesome/themes/diamond/layouts/tile.png"
theme.layout_tiletop = "/home/hugh/.config/awesome/themes/diamond/layouts/tiletop.png"
theme.layout_spiral  = "/home/hugh/.config/awesome/themes/diamond/layouts/spiral.png"
theme.layout_dwindle = "/home/hugh/.config/awesome/themes/diamond/layouts/dwindle.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"
theme.archlinux_icon = "/usr/share/icons/nitrux-icon-theme/places/48/distributor-logo-archlinux.svg"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "nitrux-icon-theme"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
