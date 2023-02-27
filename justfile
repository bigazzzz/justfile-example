# https://just.systems/man/en/chapter_27.html
# just --completions zsh > ~/.zsh/just.zsh

# just $HOME/games/pwd

# include with --unstable flag
# !include another-justfiles/sub.just
set dotenv-load
set export
set positional-arguments
# set shell := ["python3", "-c"]
set shell := ["bash", "-uc"]

justvar := "just var"
path := env_var('PATH')
kubeconfig := env_var_or_default('KUBECONFIG', '~/kubeconfig/mmtr_2022.kubeconfig')
name := "noname"
# onetwothree := ```
#     echo 1
#     echo 2
#     echo 3

# ```
# numbers:
#     echo "{{onetwothree}}"

role := if env_var("USER") =~ '^bigaz{0,4}?$' { "master" } else { "slave" }

[private]
alias sys := system-info

[private]
default:
    @just --list
    @just --choose

[macos]
fuck:
    @echo "go and fuck yourself!"

@dumpvar:
    -echo $NULLVAR
    echo $TESTVAR
    echo {{justvar}}
    echo {{role}}

system-info:
    @echo "This is an {{arch()}} machine on {{os_family()}}({{os()}})"

view-path:
    @echo "Path is {{path}}"

pwd:
    @echo "{{invocation_directory()}}"

view-kubeconfig:
    @echo "{{kubeconfig}}"

where-justfile:
    @echo "Justfile on {{justfile()}}. Workdir file is {{justfile_directory()}}"

git *args:
    @git {{args}}

push:
    @git add -A && git commit -m "update files" && git push

say-hello:
    @echo "Hi, {{ name }}"!
# just name=Anton say-hello

print_home_folder:
  echo "HOME is: '${HOME}'"

update-repo repo-dir="~/git/myproject":
    cd {{repo-dir}}
    git push

python:
  #!/usr/bin/env python3
  print('Hello from python!')

test: system-info view-path pwd where-justfile

foo:
  x=hello && echo $x # This works!
  x := "hello" # This doesn't work!

for:
  for file in `ls .`; do \
    echo $file; \
  done
# for:
#   for file in `ls .`; do echo $file; done
# for:
#   #!/usr/bin/env sh
#   for file in `ls .`; do
#     echo $file
#   done
