class Zwm < Formula
  desc "Tiling window manager for macOS"
  homepage "https://github.com/zhubert/zwm"
  url "https://github.com/zhubert/zwm/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "a06292705d50c7c64c001463de14aba4f90a574bdbbf6fa1cba925cedcb6ba20"
  version "0.4.0"

  depends_on :macos

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"

    # Install server as app bundle (for Accessibility TCC grouping)
    app_bundle = prefix/"ZWM.app"
    mkdir_p app_bundle/"Contents/MacOS"
    mkdir_p app_bundle/"Contents/Resources"
    cp buildpath/".build/release/zwm-server", app_bundle/"Contents/MacOS/zwm-server"
    cp "resources/Info.plist", app_bundle/"Contents/Info.plist"

    # Install CLI
    bin.install ".build/release/zwm"
  end

  service do
    run [opt_prefix/"ZWM.app/Contents/MacOS/zwm-server"]
    keep_alive true
    log_path var/"log/zwm.log"
    error_log_path var/"log/zwm.log"
  end

  def caveats
    <<~EOS
      ZWM requires Accessibility permissions:
        System Settings → Privacy & Security → Accessibility
        Grant access to: #{opt_prefix}/ZWM.app/Contents/MacOS/zwm-server

      Start the service with:
        brew services start zwm
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/zwm --help 2>&1", 1)
  end
end
