import "themes" as themes;
import "theme" as color;

export let eggs = #{
    alacritty: #{
        targets: "~/.config/alacritty",
        templates: ["alacritty.toml"],
        enabled: true,
    },     
    foot: #{
        targets: "~/.config/foot",
        templates: ["foot.ini"],
        enabled: true,
    },     
    eww: #{
        targets: "~/.config/eww",
        templates: ["modules/_base.scss", "modules/colors.yuck", "icons/circle.svg"],
        enabled: true,
    },     
    nvim: #{
        targets: "~/.config/nvim",
        templates: ["init.lua"],
        enabled: true,
    },     
    hypr: #{
        targets: "~/.config/hypr",
        enabled: true,
    },     
    wallust: #{
        targets: "~/.config/wallust",
        enabled: true,
    },     
    fcitx5: #{ targets: "~/.config/fcitx5",
        enabled: true,
    },    
    btop: #{
        targets: "~/.config/btop",
        enabled: true,
    },     
    fastfetch: #{
        targets: "~/.config/fastfetch",
        enabled: true,
    },     
    mpv: #{
        targets: "~/.config/mpv",
        enabled: true,
    },     
    nushell: #{
        targets: "~/.config/nushell",
        enabled: true,
    },     
    gtk: #{
        targets: "~/.config/gtk-3.0",
        enabled: true,
    },     
    starship: #{
        targets: "~/.config/starship",
        enabled: true,
    },     
    neovide: #{
        targets: "~/.config/neovide",
        enabled: true,
    },     
    yazi: #{
        targets: "~/.config/yazi",
        enabled: true,
    },     
    wpaperd: #{
        targets: "~/.config/wpaperd",
        enabled: true,
    },     
    clipse: #{
        targets: "~/.config/clipse",
        enabled: true,
    },     
    dunst: #{
        targets: "~/.config/dunst",
        enabled: true,
    },     
};

export const theme = #{
    colors: themes::colors[color::name],
    color_name: color::name,
};

fn replace_color_foot(s) {
    let original = get_yolk_text();
    original[-6..=-1] = s[1..=s.len()];
    original
};

fn hex_to_hext(s, t) {
    let hex = color_hex_to_rgba_str(s);
    hex[-4..=-2] = t;
    hex
};
