class McmMetaHelper < Formula
  version "1.0.2"
  on_macos do
    on_arm do
      url "https://github.com/ceejbot/mcm-meta-helper/releases/download/1.0.2/mcm-meta-helper-aarch64-apple-darwin.tar.xz"
      sha256 "20415ab632b130c7158c7c58851cb22e70b0a3d3d53d0af43a1a670dd26fc1c0"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/ceejbot/mcm-meta-helper/releases/download/1.0.2/mcm-meta-helper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "299765d6651d3dbfbdac3afceda9989809d6136e2f678e18bd0e58d7df075e51"
    end
  end
  license "Parity-7.0.0"

  def install
    on_macos do
      on_arm do
        bin.install "mcm-meta-helper"
      end
    end
    on_linux do
      on_intel do
        bin.install "mcm-meta-helper"
      end
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
