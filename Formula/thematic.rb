class Thematic < Formula
    desc "Convert themes between VSCode and Zed formats"
    homepage "https://github.com/ceejbot/thematic"
    version "0.1.2"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/thematic/releases/download/v0.1.2/thematic-aarch64-apple-darwin.tar.gz"
        sha256 "8f50eb8db65d33e409f1f03ade7187d3a4612e6d77ef0d75e9152a89a0ca0a0e"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/thematic/releases/download/v0.1.2/thematic-x86_64-apple-darwin.tar.gz"
        sha256 "814c50b06e185d45efd349d3d64a29ebf263c5365aa0657d6c2bf74140adbde7"
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
        bin.install "thematic" if OS.mac? && Hardware::CPU.arm?
        bin.install "thematic" if OS.mac? && Hardware::CPU.intel?

        install_binary_aliases!
        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
