class Zwm < Formula
  desc "Tiling window manager for macOS"
  homepage "https://github.com/zhubert/zwm"
  url "https://github.com/zhubert/zwm/releases/download/v1.2.1/zwm-v1.2.1-macos-arm64.tar.gz"
  sha256 "739f613be6f90a51f6b2247a9d32b140a4c131e2fba0511f6558be6ee43c05a8"
  version "1.2.1"
  license "MIT"

  depends_on :macos
  depends_on arch: :arm64

  # This ships a prebuilt bundle that was code-signed at release time rather than
  # building from source. brew cannot sign anything itself: its build sandbox
  # denies reads of ~/Library/Keychains, so the signing identity is invisible
  # there. An ad-hoc signature would key the Accessibility grant to a cdhash that
  # changes every version, forcing a re-grant on each upgrade. Signing once,
  # upstream, gives a stable designated requirement so the grant persists.
  #
  # Formula rather than cask on purpose: formulae don't set the quarantine
  # attribute, so a self-signed bundle never faces a Gatekeeper prompt, and
  # `service` keeps `brew services` working (casks have no launchd support).
  def install
    prefix.install "ZWM.app"
    bin.install "zwm"
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

      The bundle is signed with a stable identity, so this grant survives future
      upgrades. If you are coming from a version installed before ZWM was signed,
      you need to re-grant Accessibility once more.
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/zwm --help 2>&1", 1)
  end
end
