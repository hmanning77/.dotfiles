#!/usr/bin/bash

new_name=$(dmenu -p Name: < ~/.config/bspwm/desktop_names);

bspc monitor focused -a $new_name;

bspc desktop --focus $new_name;

