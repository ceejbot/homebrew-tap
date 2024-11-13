class SemverBump < Formula
  desc "A command-line tool for bumping semver-compliant version numbers"
  homepage "https://github.com/ceejbot/semver-bump"
  version "1.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ceejbot/semver-bump/releases/download/1.0.1/semver-bump-aarch64-apple-darwin.tar.xz"
      sha256 "3415b3fadd135565d120ff5b0a1ef7967afaece63f959f4e059903b386cafd06"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ceejbot/semver-bump/releases/download/1.0.1/semver-bump-x86_64-apple-darwin.tar.xz"
      sha256 "70605249ae118813250e5e95f5f452b97da070c9a7c305c5a96d3a33a64ccfb6"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/ceejbot/semver-bump/releases/download/1.0.1/semver-bump-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "644af381411d23dd253e6f66e7dd4adbad669eb768b0bc821b244c8d479c3063"
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
