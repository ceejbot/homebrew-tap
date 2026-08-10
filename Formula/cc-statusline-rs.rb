class CcStatuslineRs < Formula
    desc "An opinionated ANSI statusline for Claude Code"
    homepage ""
    version "0.5.0"
    license "Apache-2.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.5.0/cc-statusline-rs-aarch64-apple-darwin.tar.gz"
        sha256 "ff31da518eee0eb4deb60eccf0e907c1e64d5fcbf1f600c156ba6d2e9c2e9e1d"
    end
    if OS.linux? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.5.0/cc-statusline-rs-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "b40acef10be643f087923927671290d998f4a895aba8271ac46fc259f1b56a64"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.5.0/cc-statusline-rs-x86_64-apple-darwin.tar.gz"
        sha256 "7601b893c4e7277ca294ddb95f9cbcf6317416d5a8c4c89b614cef26d34d76ee"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.5.0/cc-statusline-rs-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "800cf7e2dff8452faaada845c3bbff2e1b5b74609d3849c8811fcc7aaeef9484"
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
