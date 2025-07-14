class Thematic < Formula
    desc "Convert themes between VSCode and Zed formats"
    homepage "https://github.com/ceejbot/thematic"
    version "0.1.3"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/thematic/releases/download/v0.1.3/thematic-aarch64-apple-darwin.tar.gz"
        sha256 "e6bee3d6b1adf7016d534816f1deb31887e802a2743f127bbbccc98aa44c897d"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/thematic/releases/download/v0.1.3/thematic-x86_64-apple-darwin.tar.gz"
        sha256 "2cad2c2c8fe0126d9b2845a9f1839d5400a106f3e43b475487f685038660aca5"
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
