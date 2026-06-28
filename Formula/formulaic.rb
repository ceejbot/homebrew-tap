class Formulaic < Formula
    desc "Update a Homebrew tap formula for a project from a manifest or Cargo.toml."
    homepage "https://github.com/ceejbot/formulaic"
    version "0.8.0"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.8.0/formulaic-aarch64-apple-darwin.tar.gz"
        sha256 "ea54800e52243b23c50b441e1ddfc63e8bde96a0c9361de4b95594766366ffe7"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.8.0/formulaic-x86_64-apple-darwin.tar.gz"
        sha256 "27412b69312a34208f759be982e072002040ef52f8ab7fdad859240111b5fb44"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.8.0/formulaic-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "e05e0889e910fc67bcf58c5fe1eb08ef27fec947f151e39a0c66d96ae7725fbf"
    end

    def install
        if OS.mac? && Hardware::CPU.arm?
            bin.install "formulaic"
        end
        if OS.mac? && Hardware::CPU.intel?
            bin.install "formulaic"
        end
        if OS.linux? && Hardware::CPU.intel?
            bin.install "formulaic"
        end

        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
