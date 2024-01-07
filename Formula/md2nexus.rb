# typed: false
# frozen_string_literal: true

class Md2nexus < Formula
    desc "🍅 A command-line tool to get and set values in toml files while preserving comments and formatting."
    homepage "https://github.com/ceejbot/md2nexus"
    version "0.2.1"
    license "GPL-3.0"

    on_macos do
        if Hardware::CPU.arm?
            url "https://github.com/ceejbot/md2nexus/releases/download/0.2.1/md2nexus-aarch64-apple-darwin.tar.xz"
            sha256 "1229b0e6adda50232237021a1cb153f458473ea5395a64c68a95cd0c989b0db7"

            def install
              bin.install "md2nexus" => "md2nexus"
              generate_completions_from_executable(bin/"md2nexus", "--completions")
            end
          end
        end
        if Hardware::CPU.intel?
        url "https://github.com/ceejbot/md2nexus/releases/download/0.2.1/md2nexus-x86_64-apple-darwin.tar.xz"
        sha256 "e2d6a27ffb6936430564c6a2120f6e1458293576ff93635559999d7fc844f171"

        def install
            bin.install "md2nexus" => "md2nexus"
            generate_completions_from_executable(bin/"md2nexus", "--completions")
        end
      end

    on_linux do
      if Hardware::CPU.intel?
        url "https://github.com/ceejbot/md2nexus/releases/download/0.2.1/md2nexus-x86_64-unknown-linux-gnu.tar.xz"
        sha256 "6c393f56614046121c4191192c7d355ebdef41a179dc588dd6e0a384f030368d"

        def install
          bin.install "md2nexus" => "md2nexus"
          generate_completions_from_executable(bin/"md2nexus", "--completions")
        end
      end
    end
  end
