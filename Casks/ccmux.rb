cask "ccmux" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.23"
  sha256 arm:   "68fa63337ec13865517f97aea51987fd9c4e64f20105e4d5612dfff2cdab312a",
         intel: "a2ba0831cdb3ce9a0f2cc7a28653f1d03eacbf44575a5e23b7bf5ef17f8ab073"

  url "https://github.com/Highwall2016/homebrew-tap/releases/download/v#{version}/ccmux-#{version}-darwin-#{arch}.tar.gz"
  name "CCMux"
  desc "Desktop dashboard and CLI for ccmux terminal sessions"
  homepage "https://ccmux.com"

  depends_on macos: ">= :ventura"

  app "CCMux.app"
  binary "#{appdir}/CCMux.app/Contents/Resources/bin/ccmux"
  binary "#{appdir}/CCMux.app/Contents/Resources/bin/ccmux-agent"

  caveats <<~EOS
    Sign in from Terminal after installation:
      ccmux auth login
  EOS
end
