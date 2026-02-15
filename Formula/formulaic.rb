class Formulaic < Formula
    desc "Update a Homebrew tap formula for a Rust project from its latest github release."
    homepage "https://github.com/ceejbot/formulaic"
    version "0.6.0"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.6.0/formulaic-aarch64-apple-darwin.tar.gz"
        sha256 "93ec4812ae16d6787938a452033dd870bc1260df4af4c6324a559c018efb2fa8"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.6.0/formulaic-x86_64-apple-darwin.tar.gz"
        sha256 "bb97f4a098ccb2c1dbc2436668b81703ca7d2f001a9692a913ffb0cd98b409e9"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.6.0/formulaic-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "153e01086ddc756ea08aa9007bc05a0d37cab8de7f1df3bba383d96c9895a24f"
    end

    BINARY_ALIASES = {
        "aarch64-apple-darwin":     {},
        "x86_64-apple-darwin":      {},
        "aarch64-unknown-linux-gnu": {},
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
        bin.install "formulaic" if OS.linux? && Hardware::CPU.intel?

        install_binary_aliases!
        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
