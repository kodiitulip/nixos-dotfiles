$env.VISUAL = '/usr/bin/nvim'
$env.EDITOR = '/usr/bin/nvim'
$env.RUSTC_WRAPPER = 'sccache'
$env.PATH ++= ['/home/kodie/.cargo/bin/', '/home/kodie/.nuscripts/']
$env.PATH = ($env.PATH | split row (char esep) | prepend "/home/kodie/.config/carapace/bin")
$env.TAPLO_CONFIG = ($env.HOME + "/.config/.taplo.toml")

def --env get-env [name] { $env | get $name }
def --env set-env [name, value] { load-env { $name: $value } }
def --env unset-env [name] { hide-env $name }

def --env godot4 [...rest] {
  godot ...$rest
}


# ---------------------------------------------------------------------------- #
#                                      GIT                                     #
# ---------------------------------------------------------------------------- #

alias gs = git status
alias ga = git add
alias gc = git commit -m
alias gp = git push
alias gb = git branch
alias gsw = git switch
alias gd = git diff
alias gcl = git clone
alias dotfiles = /usr/bin/git --git-dir=($env.HOME)/dotfiles/ --work-tree=($env.HOME)
alias ly = /usr/bin/lazygit --git-dir=($env.HOME)/dotfiles/ --work-tree=($env.HOME)

# ---------------------------------------------------------------------------- #
#                                   SHORTCUTS                                  #
# ---------------------------------------------------------------------------- #

alias e = exit
alias c = clear
alias els = eza --icons --group-directories-first
alias ell = eza -l --icons --group-directories-first
alias elt = eza --tree --level=1 --icons --group-directories-first
alias lg = lazygit
alias wifi = nmtui connect
alias clock = peaclock
alias reload = exec nu
alias gw = ./gradlew
alias cr = cargo run
alias crq = cr --quiet
alias cb = cargo build
alias cbq = cb --quiet
alias ct = cargo test
alias ctq = ct --quiet
alias .. = z ..
alias ... = z ../..
alias 3.. = z ../../..
alias 4.. = z ../../../..
alias 5.. = z ../../../../..

alias garbage-collect = sudo nix-collect-garbage -d
alias rebuild = sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos

# ---------------------------------------------------------------------------- #
#                              SHELL INTEGRATIONS                              #
# ---------------------------------------------------------------------------- #

mkdir ($nu.data-dir | path join "vendor/autoload")
zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")
tree-sitter complete --shell nushell | save -f ($nu.data-dir | path join "vendor/autoload/tree-sitter-completions.nu")

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

# ---------------------------------------------------------------------------- #
#                                   COMPLETERS                                 #
# ---------------------------------------------------------------------------- #

let carapace_completer = {|spans|
  carapace $spans.0 nushell ...$spans | from json
}

$env.config.buffer_editor = "nvim"
$env.config.show_banner = false
$env.config.edit_mode = "vi"
$env.config.cursor_shape.emacs = "inherit"
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "blink_block"
$env.config.use_kitty_protocol = true

$env.config = {
  show_banner: false,
  buffer_editor: "nvim",
  use_kitty_protocol: true,
  completions: {
    case_sensitive: false
    quick: true
    partial: true
    algorithm: "fuzzy"
    external: {
      enable: true
      max_results: 100
      completer: $carapace_completer # check 'carapace_completer' 
    }
  }
}

# ---------------------------------------------------------------------------- #
#                              CUSTOM PROMPTS                                  #
# ---------------------------------------------------------------------------- #

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

$env.TRANSIENT_PROMPT_COMMAND = ^starship prompt --profile transient
$env.TRANSIENT_PROMPT_INDICATOR = ""
$env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = ": "
$env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = ""
$env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = "∙ "
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = ""

let direnv_hook = { ||
    if (which direnv | is-empty) {
        return
    }

    direnv export json | from json | default {} | load-env
    # Direnv outputs $PATH as a string, but nushell silently breaks if isn't a list-like table.
    # The following behemoth of Nu code turns this into nu's format while following the standards of how to handle quotes, use it if you need quote handling instead of the line below it:
    $env.PATH = $env.PATH | parse --regex ('' + `((?:(?:"(?:(?:\\[\\"])|.)*?")|(?:'.*?')|[^` + (char env_sep) + `]*)*)`) | each {|x| $x.capture0 | parse --regex `(?:"((?:(?:\\"|.))*?)")|(?:'(.*?)')|([^'"]*)` | each {|y| if ($y.capture0 != "") { $y.capture0 | str replace -ar `\\([\\"])` `$1` } else if ($y.capture1 != "") { $y.capture1 } else $y.capture2 } | str join }
    # $env.PATH = $env.PATH | split row (char env_sep)
}

$env.config.hooks.env_change.PWD = (
    $env.config.hooks.env_change.PWD | append direnv_hook
)