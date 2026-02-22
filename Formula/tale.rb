class Tale < Formula
    desc "A tail-compatible tool for pretty-printing ndjson files, especially logs."
    homepage "https://github.com/ceejbot/tale"
    version "0.3.0"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/tale/releases/download/v0.3.0/tale-aarch64-apple-darwin.tar.gz"
        sha256 "a496591a09c7606b15582c0a279392fe3dd476749579ce96fbaf5a99700e7c1c"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/tale/releases/download/v0.3.0/tale-x86_64-apple-darwin.tar.gz"
        sha256 "079c7b333d5005f6dd14d515a68f6dc61d70b9f0751d296068ba15f992ab678b"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/tale/releases/download/v0.3.0/tale-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "692836e8ec6d8b910f40d5cd28c00d99844f56952aaffe48c4dd92f099443bc2"
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
