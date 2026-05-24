# To use this tap:
#   brew tap Highwall2016/tap https://github.com/Highwall2016/homebrew-tap
#   brew install ccmux
class Ccmux < Formula
  desc "Control tmux sessions from your phone"
  homepage "https://ccmux.com"
  license "MIT"
  version "0.1.10"

  # Pre-compiled binaries — no Go required.
  # Update urls and sha256s after running scripts/make-release.sh.
  on_macos do
    on_arm do
      url "https://github.com/Highwall2016/homebrew-tap/releases/download/v0.1.10/ccmux-0.1.10-darwin-arm64.tar.gz"
      sha256 "a6c8ac94c4dd38c6431b30e869a5a78e6bf8a124dfbf7ae95d05f7a47ae04534"
    end
    on_intel do
      url "https://github.com/Highwall2016/homebrew-tap/releases/download/v0.1.10/ccmux-0.1.10-darwin-amd64.tar.gz"
      sha256 "039723d927946f61a918fd94a95ac74b823efc7ebfea9b88afef7fa511679a59"
    end
  end

  def install
    bin.install "ccmux"
    bin.install "ccmux-agent"
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
