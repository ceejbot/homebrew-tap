class Tale < Formula
    desc "A tail-compatible tool for pretty-printing ndjson files, especially logs."
    homepage "https://github.com/ceejbot/tale"
    version "0.2.1"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/tale/releases/download/v0.2.1/tale-aarch64-apple-darwin.tar.gz"
        sha256 "3295b815c72e950a062127faf4ec0d0246004422d7c336a09f0e653051c62097"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/tale/releases/download/v0.2.1/tale-x86_64-apple-darwin.tar.gz"
        sha256 "cf8ae7dbead6d0ce8048b43c36ec1ec25bc4f12bf9760d52d7df31616db46aed"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/tale/releases/download/v0.2.1/tale-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "bba9627247821c153b91a161ceef08f138ec4d5d344aca0ace5048d14caf02d9"
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
        bin.install "tale" if OS.mac? && Hardware::CPU.arm?
        bin.install "tale" if OS.mac? && Hardware::CPU.intel?
        bin.install "tale" if OS.linux? && Hardware::CPU.intel?

        install_binary_aliases!
        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
