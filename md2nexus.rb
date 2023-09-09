# typed: false
# frozen_string_literal: true

class Md2nexus < Formula
    desc "🍅 A command-line tool to get and set values in toml files while preserving comments and formatting."
    homepage "https://github.com/ceejbot/md2nexus"
    version "0.1.0"
    license "BlueOak-1.0.0"
  
    on_macos do
      if Hardware::CPU.intel?
        url "https://github.com/ceejbot/md2nexus/releases/download/v0.1.0/_intel_darwin.tar.gz"
        sha256 "977bd9c5fcfeb1c2096b73c4f719a931380f73087f53d713e775aa179b9c515b    "
  
        def install
            bin.install "md2nexus" => "md2nexus"
          bash_completion.install "completions.bash" => "md2nexus"
          zsh_completion.install "completions.zsh" => "_md2nexus"
          fish_completion.install "completions.fish" => "md2nexus"
        end
      end
      if Hardware::CPU.arm?
        url "https://github.com/ceejbot/md2nexus/releases/download/v0.1.0/md2nexus_aarch64_darwin.tar.gz"
        sha256 "15b1c2de31c4798601aa819a1a57de2b4ee5aae9356b6ddff2ecfc2b2b53bf46"
  
        def install
          bin.install "md2nexus" => "md2nexus"
          bash_completion.install "completions.bash" => "md2nexus"
          zsh_completion.install "completions.zsh" => "_md2nexus"
          fish_completion.install "completions.fish" => "md2nexus"
        end
      end
    end
  
    on_linux do
      if Hardware::CPU.intel?
        url "https://github.com/ceejbot/md2nexus/releases/download/v0.1.0/_amd64_linux.tar.gz"
        sha256 "2f67f0f185d765147a0bb31607326aa03b442cd4caab6790a534d55cd01f4f86"
  
        def install
          bin.install "md2nexus" => "md2nexus"
          bash_completion.install "completions.bash" => "md2nexus"
          zsh_completion.install "completions.zsh" => "_md2nexus"
          fish_completion.install "completions.fish" => "md2nexus"
        end
      end
      if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
        url "https://github.com/ceejbot/md2nexus/releases/download/v0.1.0/_arm64_linux.tar.gz"
        sha256 "9f06b064f905fd3dc67c886423e128404d2455aba6a1c09cb0ce8f3507dd75db"
  
        def install
          bin.install "md2nexus" => "md2nexus"
          bash_completion.install "completions.bash" => "md2nexus"
          zsh_completion.install "completions.zsh" => "_md2nexus"
          fish_completion.install "completions.fish" => "md2nexus"
        end
      end
    end
  end
  