class Tokencoach < Formula
  desc "Cost analytics for Claude Code sessions"
  homepage "https://github.com/zhubert/tokencoach"
  version "0.0.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.1/tokencoach_darwin_arm64.tar.gz"
      sha256 "7ebbea7c5379ee56e1894e161a4d8846b68de682572932ff7a22cde81f2421ce"
    else
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.1/tokencoach_darwin_amd64.tar.gz"
      sha256 "3cd17543c90334c1c0106cd4414f81584eefba1b06c75343c0d1051c3b4b51c0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.1/tokencoach_linux_arm64.tar.gz"
      sha256 "31c7277faadc4a81418e52812f8e141a099f50c923ac8c75a7fbbbe1bde597a9"
    else
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.1/tokencoach_linux_amd64.tar.gz"
      sha256 "3df0f5a22b9f7700b92ecbab8448859d50e2f8080382916e3e11489f57d8f789"
    end
  end

  def install
    bin.install "tokencoach"
  end
end
