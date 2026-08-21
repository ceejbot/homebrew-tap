class CcStatuslineRs < Formula
    desc "An opinionated ANSI statusline for Claude Code"
    homepage ""
    version "0.7.0"
    license "Apache-2.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.7.0/cc-statusline-rs-aarch64-apple-darwin.tar.gz"
        sha256 "fab0ca6bc5cbd9b31a6bf1d9c2444e8a43607f79688d56a1eefa88e75ae5f9ac"
    end
    if OS.linux? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.7.0/cc-statusline-rs-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "51e5213472e25eb9db3356103f064bf5142f7abd0cb0d727d5f318151cdf5756"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.7.0/cc-statusline-rs-x86_64-apple-darwin.tar.gz"
        sha256 "6cfd2ac63c2e8010e4e45f4491db03777ca8a4add8b58151adb8a7436e939ec7"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/cc-statusline-rs/releases/download/v0.7.0/cc-statusline-rs-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "f00d07e463e0471f53a79727e7530e4e7f05e938edcdce72c15a252bcafe3501"
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
