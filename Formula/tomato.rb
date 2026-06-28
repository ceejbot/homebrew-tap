class Tomato < Formula
    desc "🍅 A command-line tool to get and set values in toml files while preserving comments and formatting."
    homepage "https://github.com/ceejbot/tomato"
    version "1.1.0"
    license "BlueOak-1.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/tomato/releases/download/v1.1.0/tomato-aarch64-apple-darwin.tar.gz"
        sha256 "3bbadb941fa984753b84f8ddd09e72d8d126d1d5ee3857fba118b6250c9a1428"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/tomato/releases/download/v1.1.0/tomato-x86_64-apple-darwin.tar.gz"
        sha256 "868e64bc3dae04b5cd28d078c27f7c60e791bc1742089600042774a2201590bc"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/tomato/releases/download/v1.1.0/tomato-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "a3f9e5b2701a0d9bfd06745d61ab9fd7bc651e219dfddea4a08e47b4c3656b28"
    end

    def install
        if OS.mac? && Hardware::CPU.arm?
            bin.install "tomato"
        end
        if OS.mac? && Hardware::CPU.intel?
            bin.install "tomato"
        end
        if OS.linux? && Hardware::CPU.intel?
            bin.install "tomato"
        end

        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
