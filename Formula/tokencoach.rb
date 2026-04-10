class Tokencoach < Formula
  desc "Cost analytics for Claude Code sessions"
  homepage "https://github.com/zhubert/tokencoach"
  version "0.0.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.5/tokencoach_darwin_arm64.tar.gz"
      sha256 "f7c92ff35c86dedf13377063a7afb156794b9beb75e01d8ec3fd5e68957338e2"
    else
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.5/tokencoach_darwin_amd64.tar.gz"
      sha256 "84dcf213a22e7fd795263b72c18e91b27aa8048face4799c5aa491ae560e9875"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.5/tokencoach_linux_arm64.tar.gz"
      sha256 "71108c90470a854f572fc57e3194bf63d1fa7c95d39b82b2b2710ec8677cadbf"
    else
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.5/tokencoach_linux_amd64.tar.gz"
      sha256 "86961b22da0f5e4511bdbb8394bc3de14e9df6bc14582225db263ae7a98994ca"
    end
  end

  def install
    bin.install "tokencoach"
  end
end
