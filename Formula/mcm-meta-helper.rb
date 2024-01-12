class McmMetaHelper < Formula
  version "1.0.1"
  on_macos do
    on_arm do
      url "https://github.com/ceejbot/mcm-meta-helper/releases/download/1.0.1/mcm-meta-helper-aarch64-apple-darwin.tar.xz"
      sha256 "4d81ceaf2afe76c35bd717c4b69fe2ad5a8eb98d62e0a4b8f41b5c30c7c8ca95"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/ceejbot/mcm-meta-helper/releases/download/1.0.1/mcm-meta-helper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1321e776a8344f441f0f1ef6391cfec40288d8ce7411e3968ef6c60b816375f1"
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
