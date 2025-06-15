class Formulaic < Formula
    desc "Update a Homebrew tap formula for a Rust project from its latest github release."
    homepage "https://github.com/ceejbot/formulaic"
    version "0.4.0"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.4.0/formulaic-aarch64-apple-darwin.tar.gz"
        sha256 "6000a6abb581578b298ec57528268ae2bbca119572833901329bf2e978d3f5d3"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.4.0/formulaic-x86_64-apple-darwin.tar.gz"
        sha256 "aed94de8afb66e85e8ffd075edc79103cf7955f12e5b5f4db792044ff75554f9"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/formulaic/releases/download/v0.4.0/formulaic-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c31af0cc7b91d84ae8785d57cb7349d4695cd386753ed9e2429a54f9d445bdc7"
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
        bin.install "formulaic" if OS.linux? && Hardware::CPU.intel?

        install_binary_aliases!
        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
