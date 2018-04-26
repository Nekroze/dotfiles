
import * as React from "/opt/Oni/resources/app/node_modules/react"
import * as Oni from "/opt/Oni/resources/app/node_modules/oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("config activated")

    // Input
    //
    // Add input bindings here:
    //
    oni.input.bind("<c-enter>", () => console.log("Control+Enter was pressed"))

    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")

    oni.editors.anyEditor.onModeChanged.subscribe((newMode) => {
        if (newMode === "insert") {
            oni.configuration.setValues({"vim.setting.relativenumber": false})
        } else {
            oni.configuration.setValues({"vim.setting.relativenumber": true})
        }
    })

}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("config deactivated")
}

export const configuration = {
    "ui.colorscheme": "solarized8_dark",
    "editor.fontFamily": "Fira Code",
    "oni.hideMenu": true,
    "language.go.languageServer.rootFiles": [".git"],
    "language.go.languageServer.command": "go-langserver",
    "language.go.languageServer.arguments": ["-gocodecompletion", "-freeosmemory", "false"],
}
