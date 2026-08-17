class Zwm < Formula
  desc "Tiling window manager for macOS"
  homepage "https://github.com/zhubert/zwm"
  url "https://github.com/zhubert/zwm/archive/refs/tags/v1.1.3.tar.gz"
  sha256 "bcdb280f2173385c9548e3ebaa696d01cb7c87b60e311583f754c08578a8aa47"
  version "1.1.3"

  depends_on :macos

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"

    # Install server as app bundle (for Accessibility TCC grouping)
    app_bundle = prefix/"ZWM.app"
    mkdir_p app_bundle/"Contents/MacOS"
    mkdir_p app_bundle/"Contents/Resources"
    cp buildpath/".build/release/zwm-server", app_bundle/"Contents/MacOS/zwm-server"
    cp "resources/Info.plist", app_bundle/"Contents/Info.plist"

    # Sign with a stable identity if one exists locally, so the Accessibility /
    # Input Monitoring grants survive future `brew upgrade`s instead of being
    # invalidated by a new ad-hoc cdhash each time.
    signing_identity = "Zack's Window Manager Signing"
    identities = Utils.safe_popen_read("security", "find-identity", "-v", "-p", "codesigning")
    has_identity = identities.include?(signing_identity)

    if !has_identity && $stdin.tty?
      print "Create a local code-signing identity so Accessibility/Input " \
            "Monitoring grants survive future upgrades? [Y/n] "
      answer = $stdin.gets.to_s.strip
      if answer.empty? || answer =~ /\Ay/i
        system "bash", "#{buildpath}/scripts/create-signing-cert.sh"
        identities = Utils.safe_popen_read("security", "find-identity", "-v", "-p", "codesigning")
        has_identity = identities.include?(signing_identity)
      end
    end

    if has_identity
      system "codesign", "--force", "--sign", signing_identity, "--identifier", "com.zhubert.zwm",
             "--timestamp=none", app_bundle
    else
      opoo "No '#{signing_identity}' identity found — leaving ad-hoc signature. " \
           "Accessibility/Input Monitoring must be re-granted after every upgrade. " \
           "Run the zwm repo's scripts/create-signing-cert.sh once to fix this."
    end

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
