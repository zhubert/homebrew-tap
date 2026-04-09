class Tokencoach < Formula
  desc "Cost analytics for Claude Code sessions"
  homepage "https://github.com/zhubert/tokencoach"
  version "0.0.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.3/tokencoach_darwin_arm64.tar.gz"
      sha256 "ff38842e88821821a384724d13314848b846a3365b915219c3eb1a03f6291840"
    else
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.3/tokencoach_darwin_amd64.tar.gz"
      sha256 "210ccbe031a817a8ac34d815b334f6adccabf135de2ce46a763e2a271a016164"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.3/tokencoach_linux_arm64.tar.gz"
      sha256 "e9bbf260bd3fddc109235bed6af6be208846e5f798c2ea314b4e070880fab7ea"
    else
      url "https://github.com/zhubert/tokencoach/releases/download/v0.0.3/tokencoach_linux_amd64.tar.gz"
      sha256 "4efc0b0a916eb35e7d07fcfdc92d8cf8d2d4da242a232300777c599be441bc9c"
    end
  end

  def install
    bin.install "tokencoach"
  end
end
