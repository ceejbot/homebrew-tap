class DotGraffle < Formula
    desc "graphviz to OmniGraffle and back."
    homepage "https://github.com/ceejbot/dot-graffle"
    version "0.1.0"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/dot-graffle/releases/download/v0.1.0/dot-graffle-aarch64-apple-darwin.tar.gz"
        sha256 "cd31d435bfc61edf8df1ae7fe7649a2c244e7481806f8fdaebb6b17c7a7511b3"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/dot-graffle/releases/download/v0.1.0/dot-graffle-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "84cf8e2f8115f5afdb6d32e8879029efd2e5a800b7c6293b054ff48e98665331"
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
            bin.install "dot-graffle"
        end
        if OS.linux? && Hardware::CPU.intel?
            bin.install "dot-graffle"
        end

        install_binary_aliases!
        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
