class Tokencoach < Formula
  desc "Cost analytics for Claude Code sessions"
  homepage "https://github.com/zhubert/tokencoach"
  version "0.0.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.2/tokencoach_darwin_arm64.tar.gz"
      sha256 "70cd3599559fb39b931e3e9dced5bce61b1a70ad28dd900668596eba14afffe1"
    else
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.2/tokencoach_darwin_amd64.tar.gz"
      sha256 "8f4beb4ff2a21ef6286b0f4a1b24c7387646b22fa7e033283d8ec01f94d4aca8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.2/tokencoach_linux_arm64.tar.gz"
      sha256 "f2f237d11fa1009b7366871c600457c357c3ef6cac245f2942126abad444de3f"
    else
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.2/tokencoach_linux_amd64.tar.gz"
      sha256 "728e41f8af275ec214aba676f9625f6eb49cb6e94c7fb02dc368185ec17f4d8f"
    end
  end

  def install
    bin.install "tokencoach"
  end
end
