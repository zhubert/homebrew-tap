class Plural < Formula
  desc "TUI tool for managing multiple concurrent Claude Code sessions in isolated Git worktrees"
  homepage "https://github.com/zhubert/plural"
  head "https://github.com/zhubert/plural.git", branch: "main"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "-o", bin/"plural", "."
  end

  test do
    assert_match "plural", shell_output("#{bin}/plural --help 2>&1", 1)
  end
end
