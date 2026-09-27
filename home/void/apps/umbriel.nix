{ inputs, ... }:

{
  imports = [ inputs.umbriel.homeModules.default ];

  programs.umbriel = {
    enable = true;

    settings = {
      general = {
        autostart = [ "fcitx5 --replace -d" ];
        mod_key = "Super";
        xwayland = true;
        show_cheatsheet = false;
      };

      include.optional.files = [ "noctalia.toml" ];

      input = {
        keyboard = {
          layout = "us";
          numlock_toggle = true;
        };
        mouse.accel_profile = "flat";
        touchpad.accel_profile = "flat";
      };

      layout = {
        mode = "scrolling";
        gap = 4;
        extent_presets = [
          0.333
          0.5
          0.667
        ];
        scrolling.default_extent_fraction = 0.5;
      };

      appearance = {
        prefer_no_csd = true;
        border_width = 2;
        corner_radius = 12;
        shadow = {
          enabled = true;
          softness = 30;
          offset_x = 0;
          offset_y = 5;
        };
      };

      colors.shadow = "#0000007F";

      window_rule = [
        {
          match.app_id = "^org\\.wezfurlong\\.wezterm$";
          default_floating = false;
        }
        {
          match.app_id = "^(gnome-control-center|pavucontrol|nm-connection-editor)$";
          default_floating = false;
        }
        {
          match.app_id = "^(org\\.gnome\\.Calculator|gnome-calculator|galculator|blueman-manager|org\\.gnome\\.Nautilus|xdg-desktop-portal)$";
          default_floating = true;
        }
        {
          match.app_id = "^firefox$";
          match.title = "^(Picture-in-Picture|Picture in picture)$";
          default_floating = true;
        }
        {
          match.app_id = "^zoom$";
          default_floating = true;
        }
        {
          match.app_id = "^steam$";
          match.title = "^notificationtoasts";
          default_focused = false;
          default_pinned = true;
        }
        {
          match.app_id = "^dev\\.noctalia\\.Noctalia$";
          default_floating = true;
          default_floating_size_px = {
            width = 1020;
            height = 900;
          };
        }
      ];

      layer_rule = [
        {
          match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd|desktop-widget-[^\"]*)$";
          blur = true;
          blur_ignore_alpha = 0.5;
          blur_popups = true;
          blur_optimized = false;
        }
      ];

      keybinds = {
        "Mod+T" = "spawn:kitty";
        "Mod+Q" = {
          action = "window-close";
          repeat = false;
        };
        "Mod+Shift+E" = {
          action = "session-quit";
          repeat = false;
        };
        "Mod+Shift+Escape" = {
          action = "shortcuts-inhibit-toggle";
          allow_when_inhibited = true;
          repeat = false;
        };

        "Mod+Space" = {
          action = "spawn:noctalia msg panel-toggle launcher";
          repeat = false;
        };
        "Mod+Comma" = {
          action = "spawn:noctalia msg settings-toggle";
          repeat = false;
        };
        "Mod+V" = {
          action = "spawn:noctalia msg panel-toggle clipboard";
          repeat = false;
        };
        "Mod+X" = {
          action = "spawn:noctalia msg panel-toggle session";
          repeat = false;
        };
        "Mod+Y" = {
          action = "spawn:noctalia msg panel-toggle wallpaper";
          repeat = false;
        };
        "Mod+N" = {
          action = "spawn:noctalia msg panel-toggle control-center notifications";
          repeat = false;
        };
        "Mod+M" = {
          action = "spawn:noctalia msg panel-toggle control-center system";
          repeat = false;
        };
        "Mod+Ctrl+Alt+Delete" = {
          action = "spawn:noctalia msg panel-toggle control-center system";
          repeat = false;
        };
        "Mod+Alt+L" = {
          action = "spawn:noctalia msg session lock";
          repeat = false;
        };
        "Mod+Shift+Slash" = {
          action = "cheatsheet-toggle";
          repeat = false;
        };
        "Mod+Tab" = {
          action = "overview-toggle";
          repeat = false;
        };

        "Alt+Print" = {
          action = "spawn:noctalia msg screenshot-region";
          repeat = false;
        };
        "Ctrl+Print" = {
          action = "spawn:noctalia msg screenshot-fullscreen";
          repeat = false;
        };
        "Mod+Shift+S" = {
          action = "spawn:noctalia msg screenshot-region";
          repeat = false;
        };

        "XF86AudioRaiseVolume" = {
          action = "spawn:noctalia msg volume-up 3";
          allow_when_locked = true;
        };
        "XF86AudioLowerVolume" = {
          action = "spawn:noctalia msg volume-down 3";
          allow_when_locked = true;
        };
        "XF86MonBrightnessUp" = {
          action = "spawn:noctalia msg brightness-up";
          allow_when_locked = true;
        };
        "XF86MonBrightnessDown" = {
          action = "spawn:noctalia msg brightness-down";
          allow_when_locked = true;
        };
        "XF86AudioMute" = {
          action = "spawn:noctalia msg volume-mute";
          repeat = false;
          allow_when_locked = true;
        };
        "XF86AudioMicMute" = {
          action = "spawn:noctalia msg mic-mute";
          repeat = false;
          allow_when_locked = true;
        };
        "XF86AudioPlay" = {
          action = "spawn:noctalia msg media toggle";
          repeat = false;
          allow_when_locked = true;
        };
        "XF86AudioPause" = {
          action = "spawn:noctalia msg media toggle";
          repeat = false;
          allow_when_locked = true;
        };
        "XF86AudioNext" = {
          action = "spawn:noctalia msg media next";
          repeat = false;
          allow_when_locked = true;
        };
        "XF86AudioPrev" = {
          action = "spawn:noctalia msg media previous";
          repeat = false;
          allow_when_locked = true;
        };

        "Mod+1" = "workspace-switch:1";
        "Mod+2" = "workspace-switch:2";
        "Mod+3" = "workspace-switch:3";
        "Mod+4" = "workspace-switch:4";
        "Mod+5" = "workspace-switch:5";
        "Mod+6" = "workspace-switch:6";
        "Mod+7" = "workspace-switch:7";
        "Mod+8" = "workspace-switch:8";
        "Mod+9" = "workspace-switch:9";
        "Mod+Shift+1" = "window-move-to-workspace:1";
        "Mod+Shift+2" = "window-move-to-workspace:2";
        "Mod+Shift+3" = "window-move-to-workspace:3";
        "Mod+Shift+4" = "window-move-to-workspace:4";
        "Mod+Shift+5" = "window-move-to-workspace:5";
        "Mod+Shift+6" = "window-move-to-workspace:6";
        "Mod+Shift+7" = "window-move-to-workspace:7";
        "Mod+Shift+8" = "window-move-to-workspace:8";
        "Mod+Shift+9" = "window-move-to-workspace:9";
        "Mod+U" = "workspace-next";
        "Mod+I" = "workspace-previous";
        "Mod+Page_Down" = "workspace-next";
        "Mod+Page_Up" = "workspace-previous";
        "Mod+WheelDown" = "workspace-next";
        "Mod+WheelUp" = "workspace-previous";
        "Mod+Shift+U" = "window-move-to-workspace-next";
        "Mod+Shift+I" = "window-move-to-workspace-previous";
        "Mod+Shift+Page_Down" = "window-move-to-workspace-next";
        "Mod+Shift+Page_Up" = "window-move-to-workspace-previous";
        "Mod+Ctrl+U" = "window-move-to-workspace-next";
        "Mod+Ctrl+I" = "window-move-to-workspace-previous";
        "Mod+Ctrl+Down" = "window-move-to-workspace-next";
        "Mod+Ctrl+Up" = "window-move-to-workspace-previous";
        "Mod+Ctrl+WheelDown" = "window-move-to-workspace-next";
        "Mod+Ctrl+WheelUp" = "window-move-to-workspace-previous";

        "Mod+H" = "window-focus-left";
        "Mod+L" = "window-focus-right";
        "Mod+K" = "window-focus-up";
        "Mod+J" = "window-focus-down";
        "Mod+Left" = "window-focus-left";
        "Mod+Right" = "window-focus-right";
        "Mod+Up" = "window-focus-up";
        "Mod+Down" = "window-focus-down";
        "Mod+Home" = "column-focus-first";
        "Mod+End" = "window-focus-last";
        "Mod+Ctrl+H" = "output-focus-left";
        "Mod+Ctrl+L" = "output-focus-right";
        "Mod+Ctrl+K" = "output-focus-up";
        "Mod+Ctrl+J" = "output-focus-down";
        "Mod+Ctrl+Left" = "output-focus-left";
        "Mod+Ctrl+Right" = "output-focus-right";

        "Mod+Shift+H" = "column-move-left";
        "Mod+Shift+L" = "column-move-right";
        "Mod+Shift+K" = "window-move-up";
        "Mod+Shift+J" = "window-move-down";
        "Mod+Shift+Left" = "column-move-left";
        "Mod+Shift+Right" = "column-move-right";
        "Mod+Shift+Up" = "window-move-up";
        "Mod+Shift+Down" = "window-move-down";
        "Mod+Shift+Ctrl+H" = "window-move-to-output-left";
        "Mod+Shift+Ctrl+L" = "window-move-to-output-right";
        "Mod+Shift+Ctrl+K" = "window-move-to-output-up";
        "Mod+Shift+Ctrl+J" = "window-move-to-output-down";
        "Mod+Shift+Ctrl+Left" = "window-move-to-output-left";
        "Mod+Shift+Ctrl+Right" = "window-move-to-output-right";
        "Mod+Shift+Ctrl+Up" = "window-move-to-output-up";
        "Mod+Shift+Ctrl+Down" = "window-move-to-output-down";

        "Mod+Equal" = "window-modify-primary-extent:0.05";
        "Mod+Minus" = "window-modify-primary-extent:-0.05";
        "Mod+Shift+Equal" = "window-modify-secondary-extent:0.05";
        "Mod+Shift+Minus" = "window-modify-secondary-extent:-0.05";
        "Mod+Ctrl+F" = {
          action = "window-toggle-maximize";
          repeat = false;
        };

        "Mod+F" = {
          action = "window-toggle-fullscreen";
          repeat = false;
        };
        "Mod+Shift+F" = {
          action = "window-toggle-maximize-to-edges";
          repeat = false;
        };
        "Mod+Shift+T" = {
          action = "window-toggle-floating";
          repeat = false;
        };
        "Mod+R" = {
          action = "window-consume-or-expel-right";
          repeat = false;
        };
        "Mod+W" = {
          action = "window-consume-right";
          repeat = false;
        };
      };
    };
  };
}
