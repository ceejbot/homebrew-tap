class CcStatuslineRs < Formula
    desc "An opinionated ANSI statusline for Claude Code"
    homepage ""
    version "0.6.1"
    license "Apache-2.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.6.1/cc-statusline-rs-aarch64-apple-darwin.tar.gz"
        sha256 "3eca05eeaf56235fec1e9ca18a2bbd8d01b30c30aeccb9642f647b293aaf09c4"
    end
    if OS.linux? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.6.1/cc-statusline-rs-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "41b49f594754d13af77727674558c3c669d6dc2149b657a7e4be04273017c58f"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.6.1/cc-statusline-rs-x86_64-apple-darwin.tar.gz"
        sha256 "50845ed2838830e9e16d19c3c38c831f54ee5c788ea4f21a069d89e5026e1fed"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.6.1/cc-statusline-rs-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "d2dc94f5f58b04c58c839d5d9056fb68c7192d8a357db70d9152e046817f9ab9"
    end

    def install
        if OS.mac? && Hardware::CPU.arm?
            bin.install "cc-statusline-rs"
        end
        if OS.linux? && Hardware::CPU.arm?
            bin.install "cc-statusline-rs"
        end
        if OS.mac? && Hardware::CPU.intel?
            bin.install "cc-statusline-rs"
        end
        if OS.linux? && Hardware::CPU.intel?
            bin.install "cc-statusline-rs"
        end

        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
