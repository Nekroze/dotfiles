const activate = (oni) => {
  oni.input.unbind("<c-g>")
  oni.input.bind("<s-c-g>", () => oni.commands.executeCommand("sneak.show"))
};

module.exports = {
  activate,
  "oni.hideMenu": true,
  "oni.loadInitVim": false,
  "oni.useDefaultConfig": true,
  "autoClosingPairs.enabled": true,
  "commandline.mode": true,
  "wildmenu.mode": true,
  "learning.enabled": true,
  "achievements.enabled": true,
  "editor.textMateHighlighting.enabled": false
}
