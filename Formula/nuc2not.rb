class Nuc2not < Formula
  desc "Migrate a Nuclino workspace to Notion pages."
  homepage "https://github.com/ceejbot/nuc2not"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ceejbot/nuc2not/releases/download/0.2.2/nuc2not-aarch64-apple-darwin.tar.xz"
      sha256 "8214a9e1bc6aeda322822a0c79b3f0e4748e9746e76bc0bb2defe51bf35889f3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ceejbot/nuc2not/releases/download/0.2.2/nuc2not-x86_64-apple-darwin.tar.xz"
      sha256 "53005a9066074814306485bfe9a2fb0bf5f0cf275f7a6e43c6105979dd343439"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/ceejbot/nuc2not/releases/download/0.2.2/nuc2not-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "abea26b06dc9f5960ab3a33b3342739583b992e700365464349bba9cbe62d746"
  end
  license "Parity-7.0.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
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
    bin.install "nuc2not" if OS.mac? && Hardware::CPU.arm?
    bin.install "nuc2not" if OS.mac? && Hardware::CPU.intel?
    bin.install "nuc2not" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
