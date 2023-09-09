# typed: false
# frozen_string_literal: true

class Md2nexus < Formula
    desc "🍅 A command-line tool to get and set values in toml files while preserving comments and formatting."
    homepage "https://github.com/ceejbot/md2nexus"
    version "0.2.0"
    license "GPL-3.0"
  
    on_macos do
      if Hardware::CPU.intel?
        url "https://github.com/ceejbot/md2nexus/releases/download/0.2.0/md2nexus-x86_64-apple-darwin.tar.xz"
        sha256 "ddfb02949530247347e4f4a2531c4846861f634c00035b55ea057caf41657818"
  
        def install
            bin.install "md2nexus" => "md2nexus"
            generate_completions_from_executable(bin/"md2nexus", "--completions")
        end
      end
      if Hardware::CPU.arm?
        url "https://github.com/ceejbot/md2nexus/releases/download/0.2.0/md2nexus-x86_64-apple-darwin.tar.xz"
        sha256 "3e8ab1696063e8ada75ae80d4829f1c3b710d5ab63dbf417c028bf5edac9df9b"
  
        def install
          bin.install "md2nexus" => "md2nexus"
          generate_completions_from_executable(bin/"md2nexus", "--completions")
        end
      end
    end
  
    on_linux do
      if Hardware::CPU.intel?
        url "https://github.com/ceejbot/md2nexus/releases/download/0.2.0/md2nexus-x86_64-unknown-linux-gnu.tar.xz"
        sha256 "0c1b429762db982e7ec3c63c68c904c030ec7ed5a9e1bc125efc0e98d9202a72"
  
        def install
          bin.install "md2nexus" => "md2nexus"
          generate_completions_from_executable(bin/"md2nexus", "--completions")
        end
      end
    end
  end
  