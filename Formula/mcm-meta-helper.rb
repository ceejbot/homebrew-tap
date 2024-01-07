class McmMetaHelper < Formula
  version "1.0.0"
  on_macos do
    on_arm do
      url "https://github.com/ceejbot/mcm-meta-helper/releases/download/1.0.0/mcm-meta-helper-aarch64-apple-darwin.tar.xz"
      sha256 "b3626b28eb796b47bf28b0a8a2c0b1671682c6d73b8726c935b8bcd9d2115d0e"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/ceejbot/mcm-meta-helper/releases/download/1.0.0/mcm-meta-helper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7ceba0100aad721a4cee3b51999d567b013384d090d30ce1b2a4a1f1160b1560"
    end
  end
  license "Parity-7.0.0"

  def install
    if Hardware::CPU.type == :arm
      bin.install "mcm-meta-helper"
    else
      bin.install 
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
