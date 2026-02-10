class CultureShip < Formula
    desc "Iain M. Banks's Culture ship names in a library."
    homepage ""
    version "0.5.0"
    license "BlueOak-1.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/gsv-culture-ships/releases/download/v0.5.0/culture-ship-aarch64-apple-darwin.tar.gz"
        sha256 "ffae98b2c8d91d849de8c99902349309dbcf3760204fe29c12c1b36d3e492f46"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/gsv-culture-ships/releases/download/v0.5.0/culture-ship-x86_64-apple-darwin.tar.gz"
        sha256 "e7d7d9f1c71f5a1477eee00d090ff0e3b1855b4b2ab990aeba07818c70a83533"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/gsv-culture-ships/releases/download/v0.5.0/culture-ship-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "7c0fa48e4fe0afa5ed948f42e9342644fba2cb58cde83acecc2223e5a23cd60c"
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
        bin.install "culture-ship" if OS.mac? && Hardware::CPU.arm?
        bin.install "culture-ship" if OS.mac? && Hardware::CPU.intel?
        bin.install "culture-ship" if OS.linux? && Hardware::CPU.intel?

        install_binary_aliases!
        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
