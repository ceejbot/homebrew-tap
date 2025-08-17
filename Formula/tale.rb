class Tale < Formula
    desc "A tail-compatible tool for pretty-printing ndjson files, especially logs."
    homepage "https://github.com/ceejbot/tale"
    version "0.2.0"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/tale/releases/download/v0.2.0/tale-aarch64-apple-darwin.tar.gz"
        sha256 "b43f97301b60976dca1ba75f7d6d5814f7e275ed28cf38912d27f34b1be7ede2"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/tale/releases/download/v0.2.0/tale-x86_64-apple-darwin.tar.gz"
        sha256 "c94ae55443e0419d5879c12010e95ab65b42e5f33685d367d716d8fca56ccc46"
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

        install_binary_aliases!
        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
