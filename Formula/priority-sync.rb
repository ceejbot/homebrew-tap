class PrioritySync < Formula
  version "1.0.0"
  on_macos do
    on_arm do
      url "https://github.com/ceejbot/priority-sync/releases/download/1.0.0/priority-sync-aarch64-apple-darwin.tar.xz"
      sha256 "1e7e0a19b14a07b143d6663847c33f239f013edd08f390dbd8548811cdc603b6"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/ceejbot/priority-sync/releases/download/1.0.0/priority-sync-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bc000666ebc08eb133f55b47f799fae4f3fe5b6237a4d0b8aa064ae945e7da80"
    end
  end
  license "Parity-7.0.0"

  def install
    on_macos do
      on_arm do
        bin.install "priority-sync"
      end
    end
    on_linux do
      on_intel do
        bin.install "priority-sync"
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
