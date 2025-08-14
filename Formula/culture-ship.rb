class CultureShip < Formula
    desc "Iain M. Banks's Culture ship names in a library."
    homepage ""
    version "0.4.0"
    license "BlueOak-1.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/gsv-culture-ships/releases/download/v0.4.0/culture-ship-aarch64-apple-darwin.tar.gz"
        sha256 "329e8de19d59e91ac6c378ebe6d8b4253dd30c2f0408425e4cf9b4b686d98b8c"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/gsv-culture-ships/releases/download/v0.4.0/culture-ship-x86_64-apple-darwin.tar.gz"
        sha256 "54fd3ec137f5e4b8b48430916f743d1b14402c718f2d2d23fa9f37885eaebee2"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/gsv-culture-ships/releases/download/v0.4.0/culture-ship-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "c0632097c56da7ee31f6e5e754ac29b05936b0617f8673aa01ed3fbc35d0c13e"
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
