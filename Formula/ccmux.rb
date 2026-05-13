# To use this tap:
#   brew tap Highwall2016/tap https://github.com/Highwall2016/homebrew-tap
#   brew install ccmux
class Ccmux < Formula
  desc "Control tmux sessions from your phone"
  homepage "https://ccmux.com"
  license "MIT"
  version "0.1.0"

  # Pre-compiled binaries — no Go required.
  # Update urls and sha256s after running scripts/make-release.sh.
  on_macos do
    on_arm do
      url "https://github.com/Highwall2016/homebrew-tap/releases/download/v0.1.0/ccmux-0.1.0-darwin-arm64.tar.gz"
      sha256 "b213e8088eb50be050692d2b5c43fb05236840d3ad8891d1e3672d31961ad88b"
    end
    on_intel do
      url "https://github.com/Highwall2016/homebrew-tap/releases/download/v0.1.0/ccmux-0.1.0-darwin-amd64.tar.gz"
      sha256 "a5e3e45800d026db73d0905c31a50adf6c8ff7de5c640e96de0518a8a098542a"
    end
  end

  def install
    bin.install "ccmux"
    bin.install "ccmux-agent"
    (etc/"ccmux").mkpath
    (etc/"ccmux").install ".env.agent"
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
