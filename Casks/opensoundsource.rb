cask "opensoundsource" do
  version "0.1.0"
  sha256 "3393bab48b699cce6fbaf2a0fd2fdcf7e97cb8fd391b06385793c22d35c1b523"

  url "https://github.com/Highwall2016/open-soundsource/releases/download/v#{version}/OpenSoundSource-#{version}.zip"
  name "OpenSoundSource"
  desc "Per-app audio routing for macOS"
  homepage "https://github.com/Highwall2016/open-soundsource"

  depends_on macos: ">= :sonoma"

  app "OpenSoundSource.app"

  postflight do
    # Install the virtual audio driver if bundled
    driver_src = "#{staged_path}/OpenSoundSourceDriver.driver"
    driver_dst = "/Library/Audio/Plug-Ins/HAL/OpenSoundSourceDriver.driver"
    if Dir.exist?(driver_src)
      system_command "/bin/cp", args: ["-R", driver_src, driver_dst], sudo: true
      system_command "/usr/bin/killall", args: ["coreaudiod"], sudo: true
    end
  end

  uninstall_postflight do
    driver_path = "/Library/Audio/Plug-Ins/HAL/OpenSoundSourceDriver.driver"
    if Dir.exist?(driver_path)
      system_command "/bin/rm", args: ["-rf", driver_path], sudo: true
      system_command "/usr/bin/killall", args: ["coreaudiod"], sudo: true
    end
  end

  zap trash: [
    "~/Library/Preferences/com.open-soundsource.OpenSoundSource.plist",
    "~/Library/Caches/com.open-soundsource.OpenSoundSource",
  ]

  caveats <<~EOS
    OpenSoundSource requires Screen Recording permission to capture audio from
    other applications. macOS will prompt you on first launch.

    Go to System Settings → Privacy & Security → Screen Recording and enable
    OpenSoundSource.
  EOS
end
