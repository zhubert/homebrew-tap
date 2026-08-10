class Zwm < Formula
  desc "Tiling window manager for macOS"
  homepage "https://github.com/zhubert/zwm"
  url "https://github.com/zhubert/zwm/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "07f931ad84c3254b75cbd42df3c0666d1a07127ae943ac7389f6d3408e5c3376"
  version "1.0.3"

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
