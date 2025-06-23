class Thematic < Formula
    desc "Convert themes between VSCode and Zed formats"
    homepage "https://github.com/ceejbot/thematic"
    version "0.1.1"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/thematic/releases/download/v0.1.1/thematic-aarch64-apple-darwin.tar.gz"
        sha256 "6cc625a27e68a3e04c408ec356e0a3180d6c81f0644fa21d6a5971a901baf7f5"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/thematic/releases/download/v0.1.1/thematic-x86_64-apple-darwin.tar.gz"
        sha256 "cf0199db8d4fc045e11a4b829649f0afab865b1e0084e2941defeb1cf16e87b6"
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
