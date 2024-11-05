{pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window.padding = {
        x = 40;
        y = 10;
      };
      window.decorations = "none";
      window.opacity = 1;
      scrolling.history = 10000;
      font = {
        normal = {
          family = "JetBrains Mono Nerd Font";
          style = "Medium";
        };
        bold = {
          family = "JetBrains Mono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrains Mono Nerd Font";
          style = "Italic";
        };
        size = 13;
        offset.x = 0;
        offset.y = 0;
        glyph_offset.x = 0;
        glyph_offset.y = 0;
      };

      colors = {
        draw_bold_text_with_bright_colors = true;
        transparent_background_colors = false;
        primary = {
          background = "0x141b1e";
          foreground =  "0xdadada";
        };

        normal = {
          black =   "0x232a2d";
          red =     "0xe57474";
          green =   "0x8ccf7e";
          yellow =  "0xe5c76b";
          blue =     "0x67b0e8";
          magenta = "0xc47fd5";
          cyan =    "0x6cbfbf";
          white =   "0xb3b9b8";
        };
        bright = {
          black =   "0x2d3437";
          red =     "0xef7e7e";
          green =   "0x96d988";
          yellow =  "0xf4d67a";
          blue =    "0x71baf2";
          magenta = "0xce89df";
          cyan =    "0x67cbe7";
          white =   "0xbdc3c2";
        };
      };

      cursor = {
        style.shape = "Beam" ;
        style.blinking = "Off" ;
        thickness = 0.15;
        unfocused_hollow = false;
      };

    };
  };
}
