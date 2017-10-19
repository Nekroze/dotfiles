edit:prompt = { tilde-abbr $pwd; put '❱ ' }
edit:rprompt = (constantly (edit:styled (whoami)@(hostname) inverse))
edit:-matcher[''] = [p]{ edit:match-prefix &ignore-case $p }
