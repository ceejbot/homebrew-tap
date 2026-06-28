class SemverBump < Formula
    desc "A command-line tool for bumping semver-compliant version numbers"
    homepage "https://github.com/ceejbot/semver-bump"
    version "2.0.1"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/semver-bump/releases/download/v2.0.1/semver-bump-aarch64-apple-darwin.tar.gz"
        sha256 "a64e950cf6d5d5ca05971608197c568f2e137c47fd8dce7c83f61832d07ef4ab"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/semver-bump/releases/download/v2.0.1/semver-bump-x86_64-apple-darwin.tar.gz"
        sha256 "cd55ed27a661b387949a55c44a858938a005c88f19af1bc29764b7794fb44e4b"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/semver-bump/releases/download/v2.0.1/semver-bump-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "28fdbc24a642e667047f5eba74c281fbeb1a4c85a6a4c50da26dda549c28f2c6"
    end

    def install
        if OS.mac? && Hardware::CPU.arm?
            bin.install "semver-bump"
        end
        if OS.mac? && Hardware::CPU.intel?
            bin.install "semver-bump"
        end
        if OS.linux? && Hardware::CPU.intel?
            bin.install "semver-bump"
        end

        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
