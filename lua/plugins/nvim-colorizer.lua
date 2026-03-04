return {
    'catgoose/nvim-colorizer.lua',
    event = "BufReadPre",
    opts = {
        -- opts to setup table
        user_default_options = {
            css = true,
            tailwind = true,
            tailwind_opts = {}
        }
    }
}