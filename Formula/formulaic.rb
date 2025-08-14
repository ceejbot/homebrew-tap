class Formulaic < Formula
    desc "Update a Homebrew tap formula for a Rust project from its latest github release."
    homepage "https://github.com/ceejbot/formulaic"
    version "0.5.0"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.5.0/formulaic-aarch64-apple-darwin.tar.gz"
        sha256 "1eb0631b8e5db6cf2745f39b88f006d9d17af7be59b0a2b39024b54d6a143912"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.5.0/formulaic-x86_64-apple-darwin.tar.gz"
        sha256 "bd4a19b8249ff211f136fdc8addfa7338bae10e4a8d8300de994de8e5a14a65c"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.5.0/formulaic-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "ee103f005358a85aadbd0e9d8bea6bdf7a00c6f3c1017d1bf259d1fe1cba45ad"
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
