local lvJSHook = [[
Hooks.Example = {
  // Callbacks
  mounted()      { this.appendEvent("Mounted") },
  beforeUpdate() { this.appendEvent("Before Update") },
  updated()      { this.appendEvent("Updated") },
  destroyed()    { this.appendEvent("Destroyed") },
  disconnected() { this.appendEvent("Disconnected") },
  reconnected()  { this.appendEvent("Reconnected") },

  // Custom Helper
  appendEvent(name) {
    console.log(name)
    let li = document.createElement("li")
    li.innerText = name
    this.el.querySelector("#example-events").appendChild(li)
  }
}
]]

return {
  { prefix = "lv:hook", body = lvJSHook, description = "LiveView JS Hook" },
}
