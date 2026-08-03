cask "ccmux" do
  arch arm: "arm64", intel: "amd64"

  version "--help"
  sha256 arm:   "25f52886145fcbf878372271fc8d8287a781889cc4e00ce378ca288413bc13ea",
         intel: "18c5b23fbc39749463c70cf2c340d6b0b228f9639d26c1948c36a3eebfb8bf3a"

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
