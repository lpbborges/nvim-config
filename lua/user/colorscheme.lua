local status_ok, onedark = pcall(require, "onedarkpro")

if not status_ok then
    return
end

onedark.setup {
    style = "onedark_vivid",
    transparent = true
}

onedark.load()
