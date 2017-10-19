edit:prompt = { tilde-abbr $pwd; put '❱ ' }
edit:rprompt = (constantly (edit:styled (whoami)@(hostname) inverse))
edit:-matcher[''] = [p]{ edit:match-prefix &ignore-case $p }
E:PATH = $E:PATH":"$E:HOME"/.bin"
