class Formulaic < Formula
    desc "Update a Homebrew tap formula for a project from a manifest or Cargo.toml."
    homepage "https://github.com/ceejbot/formulaic"
    version "0.7.0"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.7.0/formulaic-aarch64-apple-darwin.tar.gz"
        sha256 "11d0d9c461e1e52c69c4774285e96af6229bcf1a1a4aad1521f1cd78eb2afdda"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.7.0/formulaic-x86_64-apple-darwin.tar.gz"
        sha256 "c5f509d78e393a7b75b01309015d1edc8860595bfd235e755594381673d1436b"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.7.0/formulaic-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "9f3e0475f3b85ea699f5415b1062ef4a414666beb2bd3f70a4177c94acc68f0e"
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
        if OS.mac? && Hardware::CPU.arm?
            bin.install "formulaic"
        end
        if OS.mac? && Hardware::CPU.intel?
            bin.install "formulaic"
        end
        if OS.linux? && Hardware::CPU.intel?
            bin.install "formulaic"
        end

        install_binary_aliases!
        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
