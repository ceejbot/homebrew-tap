require "download_strategy"
require "utils/formatter"
require "utils/github"
require "system_command"

class Tomato < Formula
    desc "🍅 A command-line tool to get and set values in toml files while preserving comments and formatting."
    homepage "https://github.com/ceejbot/tomato"
    version "0.5.1"
    license "BlueOak-1.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/tomato/releases/download/v0.5.1/tomato-aarch64-apple-darwin.tar.gz"
        sha256 "10837e772d4e836035d4e7bfe2462136c3669534090aeb8c8f2cf65a0eb75c2d"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/tomato/releases/download/v0.5.1/tomato-x86_64-apple-darwin.tar.gz"
        sha256 "312e6198b129b5e412d1817b6f88bf3595821566817023ac2a1eac5db12f2aaa"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/tomato/releases/download/v0.5.1/tomato-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "f9c5c4841922185d3c9c560c5f1fa8d729c9bb5190dae96fc0e870a7bef4fbeb"
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
        bin.install "tomato" if OS.mac? && Hardware::CPU.arm?
        bin.install "tomato" if OS.mac? && Hardware::CPU.intel?
        bin.install "tomato" if OS.linux? && Hardware::CPU.intel?

        install_binary_aliases!
        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
