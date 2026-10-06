class CcStatuslineRs < Formula
    desc "An opinionated ANSI statusline for Claude Code"
    homepage ""
    version "0.7.1"
    license "Apache-2.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.7.1/cc-statusline-rs-aarch64-apple-darwin.tar.gz"
        sha256 "f2333815090a8c07d6f3d45619b9008a2b0cd8b0b7e32df8d04fafddb1cef355"
    end
    if OS.linux? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.7.1/cc-statusline-rs-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "1836a57e330bb395ef487bed3cb95aef0a4a486d01c50198439ab18eb9c39644"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.7.1/cc-statusline-rs-x86_64-apple-darwin.tar.gz"
        sha256 "f367b6e76455fc82d1c8e72a6b738828ac3f4d34a703189c4ca5ed21fcc62d2f"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.7.1/cc-statusline-rs-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "240a1bef6475a949bdeedef69c6f89a061d752df8c3a0f2ba02386fdc327105d"
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
