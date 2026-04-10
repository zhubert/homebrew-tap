class Tokencoach < Formula
  desc "Cost analytics for Claude Code sessions"
  homepage "https://github.com/zhubert/tokencoach"
  version "0.0.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.4/tokencoach_darwin_arm64.tar.gz"
      sha256 "ea6e7e9d92ce22e53f24cc974add8f63c2238996b8cd9c360e7a3a1d5c13e594"
    else
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.4/tokencoach_darwin_amd64.tar.gz"
      sha256 "5a4aeec93c0d945e8acf41ee066366d91bc6caf1a013c7f74f5d8602aea05523"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.4/tokencoach_linux_arm64.tar.gz"
      sha256 "163f8fbc9292741200cf67ece36b3ad51c73442875d2411367b4f212cdf7ff50"
    else
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.4/tokencoach_linux_amd64.tar.gz"
      sha256 "f9a75ea2e688539231ea8fa4928ee53b6d80cca85d4d0b37eac90d97ab7eab37"
    end
  end

  def install
    bin.install "tokencoach"
  end
end
