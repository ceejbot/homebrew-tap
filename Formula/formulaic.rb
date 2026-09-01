class Formulaic < Formula
    desc "Update a Homebrew tap formula for a project from a manifest or Cargo.toml."
    homepage "https://github.com/ceejbot/formulaic"
    version "0.8.1"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.8.1/formulaic-aarch64-apple-darwin.tar.gz"
        sha256 "5d3b548ba577336c7c64cc68bbe22e51b04f96fcd0186f407e9954bcd45db4f5"
    end
    if OS.linux? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.8.1/formulaic-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "4adb1da840e4a6ae559c28166a59c5e6e98597d76b7ee9d393330e0a9d0a97db"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.8.1/formulaic-x86_64-apple-darwin.tar.gz"
        sha256 "7db62c7afaadf3665c61f28872b22de3f1beae1873eaeb8f82faa6f91cf3bb61"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.8.1/formulaic-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "0c2db7d20e09f3448876cdce6d6d4942ce48c841d355ecb4c6a113c2c602d09a"
    end

    def install
        if OS.mac? && Hardware::CPU.arm?
            bin.install "formulaic"
        end
        if OS.linux? && Hardware::CPU.arm?
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
