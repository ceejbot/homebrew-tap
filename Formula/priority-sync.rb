class PrioritySync < Formula
  version "1.0.0"
  on_macos do
    on_arm do
      url "https://github.com/ceejbot/priority-sync/releases/download/1.0.0/priority-sync-aarch64-apple-darwin.tar.xz"
      sha256 "ca4227430bac5203adaa2b1f4b4ec746a9c369fa97db7d7bb2697d5e0ea10bbb"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/ceejbot/priority-sync/releases/download/1.0.0/priority-sync-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "15f91019162478c882ebff68cfe5b181c7a7f772f59549f93e7054336bfcfa10"
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
