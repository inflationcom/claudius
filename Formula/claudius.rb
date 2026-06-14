# Homebrew formula for claudius.
#
# Publish via a tap:
#   1. Create a repo named  homebrew-tap  on your GitHub account.
#   2. Tag a release here:   git tag v0.1.0 && git push --tags
#   3. Fill in `url` + `sha256` below (sha256: `brew fetch` or
#      `curl -sL <url> | shasum -a 256`), then copy this file into the tap repo
#      as Formula/claudius.rb.
#
# Users then install with:  brew install OWNER/tap/claudius
class Claudius < Formula
  desc "Launcher and session manager for Claude Code"
  homepage "https://github.com/OWNER/claudius"
  url "https://github.com/OWNER/claudius/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "REPLACE_WITH_TARBALL_SHA256"
  license "MIT"

  depends_on "jq"

  def install
    bin.install "claudius"
  end

  test do
    assert_match "claudius", shell_output("#{bin}/claudius --version")
  end
end
