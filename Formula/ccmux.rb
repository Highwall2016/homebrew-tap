# To use this tap:
#   brew tap Highwall2016/tap https://github.com/Highwall2016/homebrew-tap
#   brew install ccmux
class Ccmux < Formula
  desc "Control tmux sessions from your phone"
  homepage "https://ccmux.com"
  # Update url and sha256 after running scripts/make-release.sh
  url "https://github.com/Highwall2016/ccmux/releases/download/v0.1.0/ccmux-0.1.0.tar.gz"
  sha256 "REPLACE_WITH_SHA256_FROM_MAKE_RELEASE"
  license "MIT"
  head "https://github.com/Highwall2016/ccmux.git", branch: "main"

  depends_on "go" => :build

  # The source tarball is created by scripts/make-release.sh and contains a
  # pre-built vendor/ directory so builds are fully offline.
  def install
    # Disable go.work (present at repo root) so -mod=vendor works at the
    # module level and picks up agent/vendor/ which includes the vendored
    # backend package (via the replace directive resolved at vendor time).
    ENV["GOWORK"] = "off"
    cd "agent" do
      system "go", "build",
             "-trimpath",
             "-ldflags", "-s -w",
             "-mod=vendor",
             "-o", bin/"ccmux",
             "./cmd/ctl"
      system "go", "build",
             "-trimpath",
             "-ldflags", "-s -w",
             "-mod=vendor",
             "-o", bin/"ccmux-agent",
             "./cmd/agent"
    end
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
    # ccmux exits 1 with usage on --help, match the banner
    output = shell_output("#{bin}/ccmux --help 2>&1", 1)
    assert_match "control tmux sessions from your phone", output
  end
end
