{pkgs, config, ...}:

{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };

	wayland.windowManager.hyprland.enable = true;
	wayland.windowManager.hyprland.settings = {

    monitor = ",highres,auto,1";

    exec-once = [
      "ags"
      "udiskie"
      "clipse -listen"
    ];
    
    general = {
      gaps_in = "5";
      gaps_out = "60";
      border_size = "0";
      gaps_workspaces = "20";
      resize_on_border = "true";
      layout = "dwindle";
    };

    input = {
      repeat_rate=50;
      repeat_delay=300;
      touchpad = {
      natural_scroll = "true";
    };
    };

    decoration = {
      rounding = "20";
      active_opacity = "1.0";
      inactive_opacity = "1.0";
      drop_shadow = "false";
      shadow_render_power = "5";
      "col.shadow" = "rgba(0609094a)";
      dim_inactive = "true";
      dim_strength = "0.2";

      blur = {
        enabled = "true";
        size = "4";
        passes = "2";
        noise = "0";
        ignore_opacity = "true";
        vibrancy = "0.1696";
        new_optimizations = "true";
      };
    };

    animations = {
      enabled = "true";
      first_launch_animation = "false";
      animation = "workspaces, 1, 5, default, slidevert";
    };
    
    dwindle = {
      pseudotile = "true"; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = "true"; # You probably want this
        force_split = "2";
    };

    master = {
      new_status = "master";
    };
    
    xwayland = {
      force_zero_scaling= "true";
    };

    cursor={
      persistent_warps = "true";
      warp_on_change_workspace= "true";
      zoom_factor = 1;
    };

    misc = { 
      force_default_wallpaper = "0" ;
      disable_hyprland_logo = "true";
      new_window_takes_over_fullscreen = "true";
      background_color = "rgb(0a0e0f)";
      vfr = "true";
      font_family = "JetBrainsMono Nerd Font";
      layers_hog_keyboard_focus = "true";
      animate_manual_resizes = "true";
      animate_mouse_windowdragging = "true";
      enable_swallow="false";
      swallow_regex = "^(alacritty)$";
      focus_on_activate = "false";
      initial_workspace_tracking = "true";
      close_special_on_empty = "true";
    };

		"$m" = "SUPER";
		"$a" = "ALT";
    bind =
      [
      "$m, return, exec, alacritty"
        "$m SHIFT, b, exec, firefox"
        "$m, Q, killactive, "
        "$m, END, exit, "
        "$m SHIFT, END, exec, poweroff"
        "$m SHIFT, HOME, exec, reboot"
        "$m, S, togglefloating"
        "$m SHIFT, S, pseudo"
        "$m, T, togglesplit"
        "$m, f, fullscreen, 0"
        "$m CTRL, h, resizeactive, -20 0"
        "$m CTRL, l, resizeactive, 20 0"
        "$m CTRL, k, resizeactive, 0 -20"
        "$m CTRL, j, resizeactive, 0 20"

        "$m, h, movefocus, l"
        "$m, l, movefocus, r"
        "$m, k, movefocus, u"
        "$m, j, movefocus, d"

        "$m SHIFT, h, movewindow, l"
        "$m SHIFT, l, movewindow, r"
        "$m SHIFT, k, movewindow, u"
        "$m SHIFT, j, movewindow, d"

        "$m, 1, workspace, 1"
        "$m, 2, workspace, 2"
        "$m, 3, workspace, 3"
        "$m, 4, workspace, 4"
        "$m, 5, workspace, 5"
        "$m, 6, workspace, 6"
        "$m, 7, workspace, 7"
        "$m, 8, workspace, 8"
        "$m, 9, workspace, 9"

        "$m SHIFT, 0, movetoworkspace, 0"
        "$m SHIFT, 1, movetoworkspace, 1"
        "$m SHIFT, 2, movetoworkspace, 2"
        "$m SHIFT, 3, movetoworkspace, 3"
        "$m SHIFT, 4, movetoworkspace, 4"
        "$m SHIFT, 5, movetoworkspace, 5"
        "$m SHIFT, 6, movetoworkspace, 6"
        "$m SHIFT, 7, movetoworkspace, 7"
        "$m SHIFT, 8, movetoworkspace, 8"
        "$m SHIFT, 9, movetoworkspace, 9"
        "$m SHIFT, 0, movetoworkspace, 0"

        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"

        "$a, space, exec, ags --toggle-window appLauncher"

        "$m SHIFT, c, exec, hyprpicker -a"
        ", Print, exec, /home/chilly/Scripts/hyprshot -m region -o /home/chilly/Pictures/Screenshots/"
        "$m, Print, exec, /home/chilly/Scripts/hyprshot -m window -o /home/chilly/Pictures/Screenshots/"
        "$m SHIFT, Print, exec, /home/chilly/Scripts/hyprshot -m output -o /home/chilly/Pictures/Screenshots/"

        "$m, space, togglespecialworkspace, magic"
        "$m SHIFT, space, movetoworkspace, special:magic"

        "$m, n, workspace, e+1"
        "$m SHIFT, n, workspace, e-1"
        ];
    binde = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        ",XF86MonBrightnessUp, exec, brightnessctl set 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"
    ];

    bindm = [
      "$m, mouse:272, movewindow"
        "$m SHIFT, mouse:272, resizewindow"
    ];

    gestures={
      workspace_swipe = "true";
      workspace_swipe_distance = "200";
      workspace_swipe_forever = "false";
      workspace_swipe_cancel_ratio = "0.1";
    };

    layerrule = [
      "unset, *"
      "dimaround, appLauncher"
      # "blur, appLauncher"
      "animation slide, appLauncher"
      "animation slide, notifications0"
      # "ignorealpha, notifications0"
    ];
  };
}
