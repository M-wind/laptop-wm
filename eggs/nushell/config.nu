$env.config.show_banner = false
$env.config.color_config.hints = 'white_dimmed'
$env.config.color_config.shape_garbage = { fg: 'red'}
$env.config.color_config.shape_external = 'blue'
$env.config.color_config.shape_internalcall = 'blue_bold'
$env.config.datetime_format.table = '%F %T'
$env.config.filesize.unit = 'binary'

alias core-ls = ls

def old-ls [
    path
    --all (-a)
    --directory (-u)
    --du (-d)
    --full-paths (-f)
    --mime-type (-m) --long (-l)
] {
    match $long {
        true => { core-ls $path --long=true --all=$all --directory=$directory --du=$du --full-paths=$full_paths --mime-type=$mime_type | sort-by name }
        false => { core-ls $path --long=true --all=$all --directory=$directory --du=$du --full-paths=$full_paths --mime-type=$mime_type | select name type user group mode size modified | sort-by name }
    }
}

def ls [
    path?: string
    --long (-l)         # Get all available columns for each entry
    --all (-a)          # Show hidden files
    --reverse (-r)      # Display reverse
    --directory (-u)    # List the specified directory directory instead of its contents
    --du (-d)           # Display the apparent directory size ("disk usage") in place of the directory metadata size
    --time-sort (-t)    # Sort by modified
    --full-paths (-f)   # Display paths as absolute paths
    --mime-type (-m)    # Show mime-type in type column instead of 'file'
] {
    let a = if $path == null { '.' } else { $path | str replace '~' $env.home }
    match [$reverse $time_sort] {
        [true false] => { old-ls $a --long=$long --all=$all --directory=$directory --du=$du --full-paths=$full_paths --mime-type=$mime_type | reverse }
        [true true] => { old-ls $a --long=$long --all=$all --directory=$directory --du=$du --full-paths=$full_paths --mime-type=$mime_type | sort-by modified | reverse }
        [false true] => { old-ls $a --long=$long --all=$all --directory=$directory --du=$du --full-paths=$full_paths --mime-type=$mime_type | sort-by modified }
        _ => { old-ls $a --long=$long --all=$all --directory=$directory --du=$du --full-paths=$full_paths --mime-type=$mime_type }
    }
}

alias vi = neovide

alias l = ls

alias color = nu-highlight

alias tldr = /home/zwind/app/tldr/tldr --config /home/zwind/app/tldr/config.toml

# def --env y [...args] {
# 	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
# 	yazi ...$args --cwd-file $tmp
# 	let cwd = (open $tmp)
# 	if $cwd != "" and $cwd != $env.PWD {
# 		cd $cwd
# 	}
# 	rm -fp $tmp
#   printf '\x1b[\x36 q'
# }
#
