#!/usr/bin/env bash


if hyprctl getoption decoration:screen_shader | grep "/home/will/.config/hypr/shaders/grayscale.glsl"; then
    hyprctl keyword decoration:screen_shader ""
else
    hyprctl keyword decoration:screen_shader ~/.config/hypr/shaders/grayscale.glsl
  
fi
