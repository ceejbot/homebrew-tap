class Tomato < Formula
    desc "🍅 A command-line tool to get and set values in toml files while preserving comments and formatting."
    homepage "https://github.com/ceejbot/tomato"
    version "1.0.0"
    license "BlueOak-1.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/tomato/releases/download/v1.0.0/tomato-aarch64-apple-darwin.tar.gz"
        sha256 "ab1d277508da7d1f0b9e1ecdf84c85adc57ccde2950319168b787f8b8e2d7eab"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/tomato/releases/download/v1.0.0/tomato-x86_64-apple-darwin.tar.gz"
        sha256 "5ed3dd483ece52381e01f5aef9d25a59b5794b9a4b0e990d7bbd1d59911349c7"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/tomato/releases/download/v1.0.0/tomato-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "6e072a0624387066c2ac7724508bd22c7acc4acd9ab1c928054841cebb2f4859"
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
        bin.install "tomato" if OS.mac? && Hardware::CPU.arm?
        bin.install "tomato" if OS.mac? && Hardware::CPU.intel?
        bin.install "tomato" if OS.linux? && Hardware::CPU.intel?

        install_binary_aliases!
        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
