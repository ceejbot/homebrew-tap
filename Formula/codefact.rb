class Codefact < Formula
    desc "a command-line tool for keeping a fresh CodeArtifact auth token"
    homepage "https://api.github.com/repos/ceejbot/codefact"
    version "1.0.3"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/codefact/releases/download/v1.0.3/codefact-aarch64-apple-darwin.tar.gz"
        sha256 "33f03058b295929273f6561cb417dc0206f47f47fa4c740cc3d810cc280739a3"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/codefact/releases/download/v1.0.3/codefact-x86_64-apple-darwin.tar.gz"
        sha256 "22e9d6262e0786f2a824f8daa8c13185e1db78e7699bfe560a2cee63134e7c0f"
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
        bin.install "codefact" if OS.mac? && Hardware::CPU.arm?
        bin.install "codefact" if OS.mac? && Hardware::CPU.intel?

        install_binary_aliases!
        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
