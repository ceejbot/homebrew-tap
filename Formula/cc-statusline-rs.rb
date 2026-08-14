class CcStatuslineRs < Formula
    desc "An opinionated ANSI statusline for Claude Code"
    homepage ""
    version "0.6.0"
    license "Apache-2.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.6.0/cc-statusline-rs-aarch64-apple-darwin.tar.gz"
        sha256 "93c0f457c3cd5a12e392778055e7778c3fe941a43b5159ef4ad6eed7c0316a66"
    end
    if OS.linux? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.6.0/cc-statusline-rs-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "829e58222f80276025f76d06e2773852fbbcbe121d45ab785ff2b869073af56d"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.6.0/cc-statusline-rs-x86_64-apple-darwin.tar.gz"
        sha256 "2efb472250ed810e0fcecfa9b75351913abbce89cf5f4efe018b403bd2840d0c"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.6.0/cc-statusline-rs-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a2b8311193e1b9dd1066b90342960752b9290d80971fbbba05f30d181860b682"
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
