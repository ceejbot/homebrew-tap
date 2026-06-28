class Tale < Formula
    desc "A tail-compatible tool for pretty-printing ndjson files, especially logs."
    homepage "https://github.com/ceejbot/tale"
    version "0.3.2"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/tale/releases/download/v0.3.2/tale-aarch64-apple-darwin.tar.gz"
        sha256 "707007325fb7578d907f2ceed31b6637a9380607ca47de6fef96fac1f792f30f"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/tale/releases/download/v0.3.2/tale-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "6b1cce1d533def8dd1bb3badf55d214f21fc988e0c6bc9d50ad66bfc34836ed6"
    end

    def install
        if OS.mac? && Hardware::CPU.arm?
            bin.install "tale"
        end
        if OS.linux? && Hardware::CPU.intel?
            bin.install "tale"
        end

        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
