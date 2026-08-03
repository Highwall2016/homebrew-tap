# To use this tap:
#   brew tap Highwall2016/tap https://github.com/Highwall2016/homebrew-tap
#   brew install ccmux
class Ccmux < Formula
  desc "Control tmux sessions from your phone"
  homepage "https://ccmux.com"
  license "MIT"
  version "--help"

  # Pre-compiled binaries — no Go required.
  # Update urls and sha256s after running scripts/make-release.sh.
  on_macos do
    on_arm do
      url "https://github.com/Highwall2016/homebrew-tap/releases/download/v--help/ccmux---help-darwin-arm64.tar.gz"
      sha256 "25f52886145fcbf878372271fc8d8287a781889cc4e00ce378ca288413bc13ea"
    end
    on_intel do
      url "https://github.com/Highwall2016/homebrew-tap/releases/download/v--help/ccmux---help-darwin-amd64.tar.gz"
      sha256 "18c5b23fbc39749463c70cf2c340d6b0b228f9639d26c1948c36a3eebfb8bf3a"
    end
  end

  def install
    bin.install "ccmux"
    bin.install "ccmux-agent"
    prefix.install "CCMux.app" if OS.mac? && File.directory?("CCMux.app")
  end

  # ccmux-agent runs in the background and streams your terminal sessions to
  # the mobile app. It requires credentials — run `ccmux auth login` first.
  service do
    run [opt_bin/"ccmux-agent"]
    keep_alive({ successful_exit: false })
    log_path var/"log/ccmux-agent.log"
    error_log_path var/"log/ccmux-agent.log"
    environment_variables PATH: std_service_path_env, HOME: Dir.home
  end

  def caveats
    <<~EOS
      Get started in two steps:

        1. Install:  (already done)

        2. Authenticate:
             ccmux auth login

           This opens a browser to sign in and starts ccmux-agent automatically.
           Your device will then appear in the ccmux mobile app.

      Desktop app:
        open #{opt_prefix}/CCMux.app

      To show it in /Applications:
        ln -sfn #{opt_prefix}/CCMux.app /Applications/CCMux.app

      ─────────────────────────────────────────────────────
      Optional — auto-start the agent on every login:
        brew services start ccmux

      Run this AFTER `ccmux auth login` so credentials exist.
      To stop the service: brew services stop ccmux
      Agent logs: #{var}/log/ccmux-agent.log
    EOS
  end

  test do
    output = shell_output("#{bin}/ccmux --help 2>&1", 1)
    assert_match "control tmux sessions from your phone", output
  end
end
