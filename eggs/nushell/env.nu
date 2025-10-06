$env.STARSHIP_CACHE = $env.HOME | path join "app" "starship" "cache"
$env.STARSHIP_CONFIG = $env.HOME | path join ".config" "starship" "starship.toml"
$env._ZO_DATA_DIR = "/home/zwind/app/zoxide"

$env.EDITOR = "nvim"
$env.LANG = "en_US.UTF-8"
# $env.CLIPSE_CONFIG_DIR = "/home/zwind/app/clipboard/config"

# $env.IRONBAR_CONFIG = "/home/zwind/app/ironbar/config.corn"
# $env.BAT_CONFIG_PATH = "/home/zwind/app/bat/bat.conf"
# $env.NIRI_CONFIG = "/home/zwind/app/niri/config.kdl"

$env.CARGO_HOME = "/home/zwind/language/rust/cargo"
$env.RUSTUP_HOME = "/home/zwind/language/rust/rustup"
$env.RUSTUP_DIST_SERVER = "https://mirrors.aliyun.com/rustup"
$env.RUSTUP_UPDATE_ROOT = "https://mirrors.aliyun.com/rustup/rustup"

$env.LIBSEAT_BACKEND = "logind"
$env.WINEPREFIX = "/home/zwind/game/.wine"
$env.WINEDEBUG = "-all"
$env.JAVA_HOME = "/home/zwind/language/java"

$env.DOTNET_ROOT = "/home/zwind/language/dotnet"

# mpv vulkan Hardware video acceleration Support
$env.RADV_PERFTEST = "video_decode"

#colorize man pages
$env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"
$env.MANROFFOPT = "-c"

$env.PATH = (
  $env.PATH
    | split row (char esep)
    | prepend ($env.HOME | path join app tools)
    | prepend ($env.HOME | path join app 7z)
    | prepend ($env.HOME | path join app neovim bin)
    | prepend ($env.HOME | path join app hypr)
    | prepend ($env._ZO_DATA_DIR)
    | prepend ($env.HOME | path join app formatters)
    | prepend ($env.HOME | path join app screenshots)
    | prepend ($env.HOME | path join app notify)
    | prepend ($env.HOME | path join app clipboard)
    | prepend ($env.HOME | path join app handlr)
    | prepend ($env.HOME | path join app exiftool)
    | prepend ($env.CARGO_HOME | path join bin)
    | prepend ($env.HOME | path join game)
    | prepend ($env.HOME | path join game wine bin)
    | prepend ($env.HOME | path join language nodejs 22.14.0 bin)
    | prepend ($env.HOME | path join language nodejs global bin)
    | prepend ($env.HOME | path join language nodejs pnpm bin)
    | prepend ($env.HOME | path join language bun bin)
    | prepend ($env.DOTNET_ROOT)
    | prepend ($env.HOME | path join .config eww scripts)
    | prepend ($env.JAVA_HOME | path join bin)
    | uniq
)

source /home/zwind/app/starship/init.nu
source /home/zwind/app/zoxide/zoxide.nu
