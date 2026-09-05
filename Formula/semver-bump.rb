class SemverBump < Formula
    desc "A command-line tool for bumping semver-compliant version numbers"
    homepage "https://github.com/ceejbot/semver-bump"
    version "2.0.2"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/semver-bump/releases/download/v2.0.2/semver-bump-aarch64-apple-darwin.tar.gz"
        sha256 "dd27354864ac6d241060dbd47f88ccea8947f477fbb8ac84022c3a92626a2743"
    end
    if OS.linux? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/semver-bump/releases/download/v2.0.2/semver-bump-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "8d111432f1a4e0558c31d1f6996f26b7b639bfbe8eacdaf8dda340b71a0eb590"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/semver-bump/releases/download/v2.0.2/semver-bump-x86_64-apple-darwin.tar.gz"
        sha256 "2d82a972e6b6f0bf2769c27fa55c3fd0894b811dd18293359f158f92fc568fd5"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/semver-bump/releases/download/v2.0.2/semver-bump-x86_64-unknown-linux-gnu.tar.gz"
        sha256 "24afcb6a97b945ffd422719767ed2a02067394692f62e4fc770b2b100084f297"
    end

    def install
        if OS.mac? && Hardware::CPU.arm?
            bin.install "semver-bump"
        end
        if OS.linux? && Hardware::CPU.arm?
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
