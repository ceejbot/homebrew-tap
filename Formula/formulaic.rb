class Formulaic < Formula
    desc "Update a Homebrew tap formula for a Rust project from its latest github release."
    homepage "https://api.github.com/repos/ceejbot/formulaic"
    version "0.2.0"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.2.0/formulaic-aarch64-apple-darwin.tar.gz"
        sha256 "c60d5923a790a17a536128a7eabbddf282f69fde3630d5bbf679fb95347a7136"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.2.0/formulaic-x86_64-apple-darwin.tar.gz"
        sha256 "3ead336c378a0c26325940f1d16f81a9d6fea2700d39c0d87f0af68674270ccc"
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
        bin.install "formulaic" if OS.mac? && Hardware::CPU.arm?
        bin.install "formulaic" if OS.mac? && Hardware::CPU.intel?

        install_binary_aliases!
        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
