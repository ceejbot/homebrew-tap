class SemverBump < Formula
  desc "A command-line tool for bumping semver-compliant version numbers"
  homepage "https://github.com/ceejbot/semver-bump"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ceejbot/semver-bump/releases/download/1.0.0/semver-bump-aarch64-apple-darwin.tar.xz"
      sha256 "7edf2d6113de3fe0d5a451dcf771408d71f7b6ebd54e18fd8b321d4cf246c971"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ceejbot/semver-bump/releases/download/1.0.0/semver-bump-x86_64-apple-darwin.tar.xz"
      sha256 "71c37fbb635ba1d9c5e5c8d95c40bdf444ef3582eb03c633c1e74889b731002a"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/ceejbot/semver-bump/releases/download/1.0.0/semver-bump-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "6aae3c406ece92319eeeb8acfe12b1179f405954be9a6cd009bf324de124c4f2"
  end
  license "Parity-7.0.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "semver-bump" if OS.mac? && Hardware::CPU.arm?
    bin.install "semver-bump" if OS.mac? && Hardware::CPU.intel?
    bin.install "semver-bump" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
