cask "ccmux" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.25"
  sha256 arm:   "53fd33b21cd19f29ccca6d4cfd5ea3637c86f8c84cccc148e228b69c6d6f5775",
         intel: "8ceea3050354b0fa3024cf2a7bc5eee50011b7d5bb8f5a3113f960deeb33bb12"

  url "https://github.com/Highwall2016/homebrew-tap/releases/download/v#{version}/ccmux-#{version}-darwin-#{arch}.tar.gz"
  name "CCMux"
  desc "Desktop dashboard and CLI for ccmux terminal sessions"
  homepage "https://ccmux.com"

  depends_on macos: :ventura

  app "CCMux.app"
  binary "#{appdir}/CCMux.app/Contents/Resources/bin/ccmux"
  binary "#{appdir}/CCMux.app/Contents/Resources/bin/ccmux-agent"

  caveats <<~EOS
    Sign in from Terminal after installation:
      ccmux auth login
  EOS
end
