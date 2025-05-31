class Codefact < Formula
    desc "A tool for keeping you logged into CodeArtifact, nearly hands-free."
    homepage "https://api.github.com/repos/ceejbot/codefact"
    version "1.0.2"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/codefact/releases/download/v1.0.2/codefact-aarch64-apple-darwin.tar.gz"
        sha256 "0e0d03a2f787f6d875ff02ce91cf495cc95878ace96b9a9c8f3073a6a9688b44"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/codefact/releases/download/v1.0.2/codefact-x86_64-apple-darwin.tar.gz"
        sha256 "1f93ce0f338d205c460f2f4c2c3c38e6ed9bdfa82252d9d7ed43babc49d771fd"
    end

    BINARY_ALIASES = {
        "aarch64-apple-darwin":     {},
        "x86_64-apple-darwin":      {},
        "x86_64-pc-windows-gnu":    {},
        "x86_64-unknown-linux-gnu": {},
    }.freeze

    def target_triple
        cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
        os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"
        "#{cpu}-#{os}"
    end

    def install_binary_aliases!
        BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
            dests.each do |dest|
            bin.install_symlink bin/source.to_s => dest
            end
        end
    end

    def install
        bin.install "codefact" if OS.mac? && Hardware::CPU.arm?
        bin.install "codefact" if OS.mac? && Hardware::CPU.intel?

        install_binary_aliases!

        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
