cask "ccmux" do
  arch arm: "arm64", intel: "amd64"

  version "0.1.24"
  sha256 arm:   "d82978a0af2d75a2bf4d0e94e691d5f036030fa9211fe83c7eb8306e78a4e1bf",
         intel: "87194020769834a4baad4dfa57f1418ce9ffa0a17f7ea0dfa8a59e1c6833ea67"

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
