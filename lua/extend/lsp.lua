return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig_status, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_status then
      return
    end

    local binary_format = package.cpath:match("%p[\\|/]?%p(%a+)")
    local os_type = ""
    local path = ""

    if binary_format == "so" then
      function os.name()
        path = "/home/alexp"
        os_type = "linux"
      end
    elseif binary_format == "dylib" then
      function os.name()
        path = "/Users/alexp"
        os_type = "mac"
      end
    end

    if os_type == "mac" then
      lspconfig["snyk_ls"].setup({
        init_options = {
          activateSnykCode = "true",
          activateSnykIac = "false",
          activateSnykCodeQuality = "false",
          cliPath = "/Users/alexp/.nix-profile/bin/snyk",
          automaticAuthentication = "true",
          manageBinariesAutomatically = "false",
          integrationName = "neovim",
          integrationVersion = "0.10.0",
          path = "/usr/local/bin",
          token = os.getenv("SNYK_TOKEN"),
          trustedFolders = {
            "/Users/alexp/Repos", -- for MacOS
            "/home/alexp/Repos", -- for Linux
          },
        },
      })
    end
  end,
}
