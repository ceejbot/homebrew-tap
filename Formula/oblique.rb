class Oblique < Formula
    desc "Brian Eno and Peter Schmidt's Oblique Strategies in a library."
    homepage ""
    version "0.1.0"
    license "ISC"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/oblique/releases/download/v0.1.0/oblique-aarch64-apple-darwin.tar.gz"
        sha256 "a6fd2039c9c452d8f3df5e67a5aef7bc511b82cf2c9e306663d4c56ac26a1d3f"
    end
    if OS.linux? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/oblique/releases/download/v0.1.0/oblique-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "d6f3ae6cc176b42c1521262d9c0e0d024e78ddedfb2ce8fef3bc9a48664c057d"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/oblique/releases/download/v0.1.0/oblique-x86_64-apple-darwin.tar.gz"
        sha256 "9330124336e094236afd4ed80ca17cdbc793c8fd56b292a30969e23a49504ce6"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/oblique/releases/download/v0.1.0/oblique-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "97003dadd981fd3164045ab4809f3e42ca6f5703db2749042f2ba20fc2ac76dd"
    end

    def install
        if OS.mac? && Hardware::CPU.arm?
            bin.install "oblique"
        end
        if OS.linux? && Hardware::CPU.arm?
            bin.install "oblique"
        end
        if OS.mac? && Hardware::CPU.intel?
            bin.install "oblique"
        end
        if OS.linux? && Hardware::CPU.intel?
            bin.install "oblique"
        end

        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
