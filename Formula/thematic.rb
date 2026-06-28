class Thematic < Formula
    desc "Convert themes between VSCode and Zed formats"
    homepage "https://github.com/ceejbot/thematic"
    version "0.2.0"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/thematic/releases/download/v0.2.0/thematic-aarch64-apple-darwin.tar.gz"
        sha256 "8df0b4e1d6b0befb97139097e0490509779f991e62b4a1e84638133ab8515d6a"
    end
    if OS.linux? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/thematic/releases/download/v0.2.0/thematic-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "2a7a2ac6f252169235d7b058c1ee280a6965982c8f6498e59d11f272ff6db712"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/thematic/releases/download/v0.2.0/thematic-x86_64-apple-darwin.tar.gz"
        sha256 "611ca12e7844ce34694f96f4c078fb90ac80ea8233c147724e905303998f179f"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/thematic/releases/download/v0.2.0/thematic-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "92a6b7be3e2d4006043c391d3f1f5e53d2d36563209688bf88d04ee400bd1738"
    end

    def install
        if OS.mac? && Hardware::CPU.arm?
            bin.install "thematic"
        end
        if OS.linux? && Hardware::CPU.arm?
            bin.install "thematic"
        end
        if OS.mac? && Hardware::CPU.intel?
            bin.install "thematic"
        end
        if OS.linux? && Hardware::CPU.intel?
            bin.install "thematic"
        end

        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
