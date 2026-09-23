-- 1. Install VimTeX using lazy.nvim
return {
    "lervag/vimtex",
    lazy = false, -- MUST be false for inverse search to work
    init = function()
      -- 2. General VimTeX configurations
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_syntax_enabled = 1
      
      -- 3. Set Okular as the general PDF viewer
      vim.g.vimtex_view_general_viewer = "okular"
      vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
      
      -- 4. Tell VimTeX to use neovim-remote for server communication
      vim.g.vimtex_compiler_progname = "nvr"

      vim.g.vimtex_compiler_latexmk = {
        build_dir = "",
        options = {
          "-pdf",
          "-interaction=nonstopmode",
          "-synctex=1",
          "-auxdir=aux",
          "-outdir=pdf",
        },
      }
    end
}

