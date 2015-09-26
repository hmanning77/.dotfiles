--
-- My Super Amazing Custom Awesomewm rc.lua
-- Hugh Manning
-- Adapted from the default rc.lua and awesome-pro
--

-- {{{ IMPORTS
-- Standard awesome library
local gears      = require("gears")
local awful      = require("awful")
awful.rules      = require("awful.rules")
                   require("awful.autofocus")
-- Shell integration
                   require("awful.remote")
-- Widget and layout library
local wibox      = require("wibox")
-- Theme handling library
local beautiful  = require("beautiful")
local vicious    = require("vicious")
-- Notification library
local naughty    = require("naughty")
local lain       = require("lain")
local cyclefocus = require('cyclefocus')
local menubar    = require("menubar")
local menugen    = require("menubar.menu_gen")

-- }}}

-- {{{ THEME

local theme = "pro-light"

beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/" .. theme .. "/theme.lua")

-- Wallpaper

if beautiful.wallpaper then
    for s = 1, screen.count() do
        -- gears.wallpaper.tiled(beautiful.wallpaper, s)
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end

-- }}}

-- {{{ ERROR HANDLING

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ FIXES

-- Disable cursor animation:

local oldspawn = awful.util.spawn
awful.util.spawn = function (s)
    oldspawn(s, false)
end

-- Java GUI's fix:

awful.util.spawn_with_shell("wmname LG3D")

-- }}}

-- {{{ VARIABLE DEFINITIONS

get_floating = function (c)
    if c.type == "normal" or c.type == "dialog" then
        if c.class == "Nautilus" or c.class == "File-roller" then
            return false
        else
            return awful.client.floating.get(c) or awful.layout.get(c.screen) == awful.layout.suit.floating
        end
    else
        return false
    end
end

local home   = os.getenv("HOME")
local exec   = function (s) oldspawn(s, false) end
local shexec = awful.util.spawn_with_shell

modkey        = "Mod4"
terminal      = "urxvt"
tmux          = "urxvt -e tmux"
termax        = "urxvt --geometry 1680x1034+0+22"
rootterm      = "sudo -i urxvt"
browser       = "firefox"
filemanager   = "nautilus"
configuration = termax .. ' -e "vim -O $HOME/.config/awesome/rc.lua $HOME/.config/awesome/themes/' ..theme.. '/theme.lua"'

-- | Table of layouts | --

local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top
}

-- | Tags | --

tags = {}
for s = 1, screen.count() do
    tags[s] = awful.tag({ "  ", "  ", "  ", "  ", "  " }, s, layouts[1])

    for i, tag in ipairs(tags[s]) do
        tag:connect_signal("property::layout", function (t)
            for i,c in pairs(t:clients()) do
                if get_floating(c) then
                    awful.titlebar.show(c, "top")
                else
                    awful.titlebar.hide(c, "top")
                end
            end
        end )
    end
end

-- | Menu | --

favourites_menu = {
    { "firefox",        "firefox",      "/usr/share/icons/nitrux-icon-theme/apps/48/firefox.svg"        },
    { "thunderbird",    "thunderbird",  "/usr/share/icons/nitrux-icon-theme/apps/48/thunderbird.svg"    },
    { "zim",            "zim",          "/usr/share/icons/nitrux-icon-theme/apps/48/zim.svg"            },
    { "sonata",         "sonata",       "/usr/share/icons/nitrux-icon-theme/apps/48/sonata.svg"         },
    { "nautilus",       "nautilus",     "/usr/share/icons/nitrux-icon-theme/apps/48/nautilus.svg"       },
}

-- xdg_menu = menugen.generate()

awesome_menu = {
    { "configure",  configuration,      "/usr/share/icons/nitrux-icon-theme/actions/22/stock-edit.svg"      },
    { "restart",    awesome.restart,    "/usr/share/icons/nitrux-icon-theme/actions/22/stock-refresh.svg"   },
    { "quit",       awesome.quit,       "/usr/share/icons/nitrux-icon-theme/actions/22/exit.svg"            },
}

system_menu = {
  { "reboot",    "reboot",      "usr/share/icons/nitrux-icon-theme/actions/22/system-reboot.svg"       },
  { "poweroff",  "poweroff",    "/usr/share/icons/nitrux-icon-theme/apps/16/system-shutdown.svg"       },
}

mainmenu = awful.menu({ items = awful.util.table.join(
    favourites_menu,
    -- xdg_menu,
    {
      { " awesome",       awesome_menu},
      { " system",        system_menu },
    })
})
-- }}}

-- {{{ WIBOX

-- | Markup | --

markup = lain.util.markup

space3 = markup.font("Terminus 3", " ")
space2 = markup.font("Terminus 2", " ")
vspace1 = '<span font="Terminus 3"> </span>'
vspace2 = '<span font="Terminus 3">  </span>'
clockgf = beautiful.clockgf

-- {{{ WIDGETS

spr = wibox.widget.imagebox()
spr:set_image(beautiful.spr)
spr4px = wibox.widget.imagebox()
spr4px:set_image(beautiful.spr4px)
spr5px = wibox.widget.imagebox()
spr5px:set_image(beautiful.spr5px)

widget_display = wibox.widget.imagebox()
widget_display:set_image(beautiful.widget_display)
widget_display_r = wibox.widget.imagebox()
widget_display_r:set_image(beautiful.widget_display_r)
widget_display_l = wibox.widget.imagebox()
widget_display_l:set_image(beautiful.widget_display_l)
widget_display_c = wibox.widget.imagebox()
widget_display_c:set_image(beautiful.widget_display_c)

-- {{{ >    MPD

prev_icon = wibox.widget.imagebox()
prev_icon:set_image(beautiful.mpd_prev)
next_icon = wibox.widget.imagebox()
next_icon:set_image(beautiful.mpd_nex)
stop_icon = wibox.widget.imagebox()
stop_icon:set_image(beautiful.mpd_stop)
pause_icon = wibox.widget.imagebox()
pause_icon:set_image(beautiful.mpd_pause)
play_pause_icon = wibox.widget.imagebox()
play_pause_icon:set_image(beautiful.mpd_play)
mpd_sepl = wibox.widget.imagebox()
mpd_sepl:set_image(beautiful.mpd_sepl)
mpd_sepr = wibox.widget.imagebox()
mpd_sepr:set_image(beautiful.mpd_sepr)

mpdwidget = lain.widgets.mpd({
    settings = function ()
        if mpd_now.state == "play" then
            mpd_now.artist = mpd_now.artist:upper():gsub("&.-;", string.lower)
            mpd_now.title = mpd_now.title:upper():gsub("&.-;", string.lower)
            widget:set_markup(markup.font("Tamsyn 3", " ")
                              .. markup.font("Tamsyn 7",
                              mpd_now.artist
                              .. " - " ..
                              mpd_now.title
                              .. markup.font("Tamsyn 2", " ")))
            play_pause_icon:set_image(beautiful.mpd_pause)
            mpd_sepl:set_image(beautiful.mpd_sepl)
            mpd_sepr:set_image(beautiful.mpd_sepr)
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font("Tamsyn 4", "") ..
                              markup.font("Tamsyn 7", "MPD PAUSED") ..
                              markup.font("Tamsyn 10", ""))
            play_pause_icon:set_image(beautiful.mpd_play)
            mpd_sepl:set_image(beautiful.mpd_sepl)
            mpd_sepr:set_image(beautiful.mpd_sepr)
        else
            widget:set_markup("")
            play_pause_icon:set_image(beautiful.mpd_play)
            mpd_sepl:set_image(nil)
            mpd_sepr:set_image(nil)
        end
    end
})

musicwidget = wibox.widget.background()
musicwidget:set_widget(mpdwidget)
musicwidget:set_bgimage(beautiful.widget_display)
musicwidget:buttons(awful.util.table.join(awful.button({ }, 1,
function () awful.util.spawn_with_shell(ncmpcpp) end)))
prev_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    awful.util.spawn_with_shell("mpc prev || ncmpcpp prev")
    mpdwidget.update()
end)))
next_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    awful.util.spawn_with_shell("mpc next || ncmpcpp next")
    mpdwidget.update()
end)))
stop_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    play_pause_icon:set_image(beautiful.play)
    awful.util.spawn_with_shell("mpc stop || ncmpcpp stop")
    mpdwidget.update()
end)))
play_pause_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    awful.util.spawn_with_shell("mpc toggle || ncmpcpp toggle")
    mpdwidget.update()
end)))
-- }}}

-- {{{ >    Mail

-- mail_widget = wibox.widget.textbox()
-- vicious.register(mail_widget, vicious.widgets.gmail, vspace1 .. "${count}" .. vspace1, 1200)
-- 
-- widget_mail = wibox.widget.imagebox()
-- widget_mail:set_image(beautiful.widget_mail)
-- mailwidget = wibox.widget.background()
-- mailwidget:set_widget(mail_widget)
-- mailwidget:set_bgimage(beautiful.widget_display)
-- }}}

-- {{{ >    CPU

cpu_widget = lain.widgets.cpu({
    settings = function()
        widget:set_markup(space3 .. cpu_now.usage .. "%" .. markup.font("Tamsyn 4", " "))
    end
})

widget_cpu = wibox.widget.imagebox()
widget_cpu:set_image(beautiful.widget_cpu)
cpuwidget = wibox.widget.background()
cpuwidget:set_widget(cpu_widget)
cpuwidget:set_bgimage(beautiful.widget_display)
-- }}}

-- {{{ >    Temp
-- tmp_widget = wibox.widget.textbox()
-- vicious.register(tmp_widget, vicious.widgets.thermal, vspace1 .. "$1°C" .. vspace1, 9, "thermal_zone0")

-- widget_tmp = wibox.widget.imagebox()
-- widget_tmp:set_image(beautiful.widget_tmp)
-- tmpwidget = wibox.widget.background()
-- tmpwidget:set_widget(tmp_widget)
-- tmpwidget:set_bgimage(beautiful.widget_display)
-- }}}

-- {{{ >    Memory

mem_widget = lain.widgets.mem({
    settings = function()
        widget:set_markup(space3 .. mem_now.used .. "MB" .. markup.font("Tamsyn 4", " "))
    end
})

widget_mem = wibox.widget.imagebox()
widget_mem:set_image(beautiful.widget_mem)
memwidget = wibox.widget.background()
memwidget:set_widget(mem_widget)
memwidget:set_bgimage(beautiful.widget_display)
-- }}}

-- {{{ >    FS

fs_widget = wibox.widget.textbox()
vicious.register(fs_widget, vicious.widgets.fs, vspace1 .. "${/ avail_gb}GB" .. vspace1, 2)

widget_fs = wibox.widget.imagebox()
widget_fs:set_image(beautiful.widget_fs)
fswidget = wibox.widget.background()
fswidget:set_widget(fs_widget)
fswidget:set_bgimage(beautiful.widget_display)
-- }}}

-- {{{ >    Net

net_widgetdl = wibox.widget.textbox()
net_widgetul = lain.widgets.net({
    iface = "enp1s0",
    settings = function()
        widget:set_markup(markup.font("Tamsyn 1", "  ") .. net_now.sent)
        net_widgetdl:set_markup(markup.font("Tamsyn 1", " ") .. net_now.received .. markup.font("Tamsyn 1", " "))
    end
})

widget_netdl = wibox.widget.imagebox()
widget_netdl:set_image(beautiful.widget_netdl)
netwidgetdl = wibox.widget.background()
netwidgetdl:set_widget(net_widgetdl)
netwidgetdl:set_bgimage(beautiful.widget_display)

widget_netul = wibox.widget.imagebox()
widget_netul:set_image(beautiful.widget_netul)
netwidgetul = wibox.widget.background()
netwidgetul:set_widget(net_widgetul)
netwidgetul:set_bgimage(beautiful.widget_display)
-- }}}

-- {{{ >   Clock / Calendar

mytextclock    = awful.widget.textclock(markup(clockgf, space3 .. "%H:%M" .. markup.font("Tamsyn 3", " ")))
mytextcalendar = awful.widget.textclock(markup(clockgf, space3 .. "%a %d %b"))

widget_clock = wibox.widget.imagebox()
widget_clock:set_image(beautiful.widget_clock)

clockwidget = wibox.widget.background()
clockwidget:set_widget(mytextclock)
clockwidget:set_bgimage(beautiful.widget_display)

local index = 1
local loop_widgets = { mytextclock, mytextcalendar }
local loop_widgets_icons = { beautiful.widget_clock, beautiful.widget_cal }

clockwidget:buttons(awful.util.table.join(awful.button({}, 1,
    function ()
        index = index % #loop_widgets + 1
        clockwidget:set_widget(loop_widgets[index])
        widget_clock:set_image(loop_widgets_icons[index])
    end)))
-- }}}

-- {{{ >    Taglist

mytaglist         = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 5, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 4, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
-- }}}

-- {{{ >    Tasklist

mytasklist         = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

-- }}}

-- }}}

-- {{{ PANEL

mywibox           = {}
mypromptbox       = {}
mylayoutbox       = {}

for s = 1, screen.count() do
   
    mypromptbox[s] = awful.widget.prompt()
    
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    mywibox[s] = awful.wibox({ position = "top", screen = s, height = "22" })

    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(spr5px)
    left_layout:add(mytaglist[s])
    left_layout:add(spr5px)

    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(spr)
    right_layout:add(spr5px)
    right_layout:add(mypromptbox[s])
    if s == 1 then
        right_layout:add(wibox.widget.systray())
        right_layout:add(spr5px)

        right_layout:add(mpd_sepl)
        right_layout:add(musicwidget)
        right_layout:add(mpd_sepr)
        right_layout:add(spr)
        right_layout:add(prev_icon)
        right_layout:add(spr)
        right_layout:add(stop_icon)
        right_layout:add(spr)
        right_layout:add(play_pause_icon)
        right_layout:add(spr)
        right_layout:add(next_icon)
    end

    if s == 2 then
        -- right_layout:add(spr)

        -- right_layout:add(widget_mail)
        -- right_layout:add(widget_display_l)
        -- right_layout:add(mailwidget)
        -- right_layout:add(widget_display_r)
        -- right_layout:add(spr5px)

        right_layout:add(spr)

        right_layout:add(widget_cpu)
        right_layout:add(widget_display_l)
        right_layout:add(cpuwidget)
        right_layout:add(widget_display_r)
        -- right_layout:add(widget_display_c)
        -- right_layout:add(tmpwidget)
        -- right_layout:add(widget_tmp)
        -- right_layout:add(widget_display_r)
        right_layout:add(spr5px)

        right_layout:add(spr)

        right_layout:add(widget_mem)
        right_layout:add(widget_display_l)
        right_layout:add(memwidget)
        right_layout:add(widget_display_r)
        right_layout:add(spr5px)

        right_layout:add(spr)

        right_layout:add(widget_fs)
        right_layout:add(widget_display_l)
        right_layout:add(fswidget)
        right_layout:add(widget_display_r)
        right_layout:add(spr5px)

        right_layout:add(spr)

        right_layout:add(widget_netdl)
        right_layout:add(widget_display_l)
        right_layout:add(netwidgetdl)
        right_layout:add(widget_display_c)
        right_layout:add(netwidgetul)
        right_layout:add(widget_display_r)
        right_layout:add(widget_netul)
    end

    if s == 1 then
        right_layout:add(spr)

        right_layout:add(widget_clock)
        right_layout:add(widget_display_l)
        right_layout:add(clockwidget)
        right_layout:add(widget_display_r)
        right_layout:add(spr5px)
    end

    right_layout:add(spr)

    right_layout:add(mylayoutbox[s])

    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_bg(beautiful.panel)

    mywibox[s]:set_widget(layout)
end

-- }}}
-- }}}

-- {{{ BINDINGS

-- | Mouse bindings | --

root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mainmenu:toggle() end)
    -- awful.button({ }, 4, awful.tag.viewnext),
    -- awful.button({ }, 5, awful.tag.viewprev)
))

-- | Key bindings | --


globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "w",      function () mainmenu:show() end),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    -- awful.key({ modkey,           }, "Tab",
    --     function ()
    --         awful.client.focus.history.previous()
    --         if client.focus then
    --             client.focus:raise()
    --         end
    --     end),
    -- awful.key({ modkey,         }, "Tab", function(c)
    --         cyclefocus.cycle(1, {modifier="Super_L"})
    -- end),
    -- awful.key({ modkey, "Shift" }, "Tab", function(c)
    --         cyclefocus.cycle(-1, {modifier="Super_L"})
    -- end),
    cyclefocus.key({ "Mod1", }, "Tab", 1, {
        cycle_filters = { cyclefocus.filters.same_screen, cyclefocus.filters.common_tag },
        keys = {'Tab', 'ISO_Left_Tab'}
    }),
    -- awful.key({ modkey, "Control" }, "r",      awesome.restart),
    -- awful.key({ modkey, "Shift"   }, "q",      awesome.quit),
    -- awful.key({ modkey,           }, "Return", function () exec(terminal) end),
    -- awful.key({ modkey, "Control" }, "Return", function () exec(rootterm) end),
    -- awful.key({ modkey,           }, "space",  function () awful.layout.inc(layouts,  1) end),
    -- awful.key({ modkey, "Shift"   }, "space",  function () awful.layout.inc(layouts, -1) end)
    -- awful.key({ modkey            }, "a",      function () shexec(configuration) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end),
   
    -- Media keys
    awful.key({}, "XF86AudioPlay",        function() exec("mpc toggle")  end),
    awful.key({}, "XF86AudioStop",        function() exec("mpc stop")  end),
    awful.key({}, "XF86AudioNext",        function() exec("mpc next")  end),
    awful.key({}, "XF86AudioPrev",        function() exec("mpc prev")  end),
    awful.key({}, "XF86AudioRaiseVolume", function() exec("amixer set Headphone '1%+'")  end),
    awful.key({}, "XF86AudioLowerVolume", function() exec("amixer set Headphone '1%-'")  end)
)

local wa = screen[mouse.screen].workarea
ww = wa.width
wh = wa.height
ph = 22 -- (panel height)

clientkeys = awful.util.table.join(
    awful.key({ modkey            }, "Next",     function () awful.client.moveresize( 20,  20, -40, -40) end),
    awful.key({ modkey            }, "Prior",    function () awful.client.moveresize(-20, -20,  40,  40) end),
    awful.key({ modkey            }, "Down",     function () awful.client.moveresize(  0,  20,   0,   0) end),
    awful.key({ modkey            }, "Up",       function () awful.client.moveresize(  0, -20,   0,   0) end),
    awful.key({ modkey            }, "Left",     function () awful.client.moveresize(-20,   0,   0,   0) end),
    awful.key({ modkey            }, "Right",    function () awful.client.moveresize( 20,   0,   0,   0) end),
    awful.key({ modkey, "Control" }, "space",    function (c) awful.client.floating.toggle(c) end),
    awful.key({ modkey, "Control" }, "KP_Left",  function (c) c:geometry( { width = ww / 2, height = wh, x = 0, y = ph } ) end),
    awful.key({ modkey, "Control" }, "KP_Right", function (c) c:geometry( { width = ww / 2, height = wh, x = ww / 2, y = ph } ) end),
    awful.key({ modkey, "Control" }, "KP_Up",    function (c) c:geometry( { width = ww, height = wh / 2, x = 0, y = ph } ) end),
    awful.key({ modkey, "Control" }, "KP_Down",  function (c) c:geometry( { width = ww, height = wh / 2, x = 0, y = wh / 2 + ph } ) end),
    awful.key({ modkey, "Control" }, "KP_Prior", function (c) c:geometry( { width = ww / 2, height = wh / 2, x = ww / 2, y = ph } ) end),
    awful.key({ modkey, "Control" }, "KP_Next",  function (c) c:geometry( { width = ww / 2, height = wh / 2, x = ww / 2, y = wh / 2 + ph } ) end),
    awful.key({ modkey, "Control" }, "KP_Home",  function (c) c:geometry( { width = ww / 2, height = wh / 2, x = 0, y = ph } ) end),
    awful.key({ modkey, "Control" }, "KP_End",   function (c) c:geometry( { width = ww / 2, height = wh / 2, x = 0, y = wh / 2 + ph } ) end),
    awful.key({ modkey, "Control" }, "KP_Begin", function (c) c:geometry( { width = ww, height = wh, x = 0, y = ph } ) end),
    awful.key({ modkey,           }, "f",        function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "c",        function (c) c:kill() end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

awful.menu.menu_keys = {
    up    = { "k", "Up" },
    down  = { "j", "Down" },
    exec  = { "l", "Return", "Space" },
    enter = { "l", "Right" },
    back  = { "h", "Left" },
    close = { "q", "Escape" }
}

root.keys(globalkeys)

-- }}}

-- {{{ RULES

awful.rules.rules = {
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     -- size_hints_honor = false,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     floating = nil } },
    { rule = { class = "gcolor2" },
      properties = { floating = true } },
    { rule = { class = "xmag" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
}

-- }}}

-- {{{ SIGNALS

client.connect_signal("manage", function (c, startup)
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end

        if get_floating(c) then
            awful.titlebar.show(c,"top")
        else
            awful.titlebar.hide(c, "top")
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = true
    if titlebars_enabled then
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)

        if not get_floating(c) then
            awful.titlebar.hide(c, "top")
        end
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- }}}

-- {{{ STARTUP

function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

-- | Autostart | --

-- os.execute("pkill compton")
-- run_once("compton")
-- run_once("parcellite")

-- }}}

