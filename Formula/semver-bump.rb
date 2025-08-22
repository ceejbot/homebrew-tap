class SemverBump < Formula
    desc "A command-line tool for bumping semver-compliant version numbers"
    homepage "https://github.com/ceejbot/semver-bump"
    version "2.0.0"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/semver-bump/releases/download/v2.0.0/semver-bump-aarch64-apple-darwin.tar.gz"
        sha256 "1cf3c76a3bfe01afe5fc6b362905dd576ad283f104bc55a455722cfad2e55686"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/semver-bump/releases/download/v2.0.0/semver-bump-x86_64-apple-darwin.tar.gz"
        sha256 "6689185edcf256e3d11281a22aff74f0db1c750c4f17ca33f2a44560b5bab356"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/semver-bump/releases/download/v2.0.0/semver-bump-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "8a1e5b9626685455acc9b0d8b7f2e787135b6afea97825ed6dade5b83b764fb9"
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
        bin.install "semver-bump" if OS.mac? && Hardware::CPU.arm?
        bin.install "semver-bump" if OS.mac? && Hardware::CPU.intel?
        bin.install "semver-bump" if OS.linux? && Hardware::CPU.intel?

        install_binary_aliases!
        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
