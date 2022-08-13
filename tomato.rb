# typed: false
# frozen_string_literal: true

class Tomato < Formula
  desc "🍅 A command-line tool to get and set values in toml files while preserving comments and formatting."
  homepage "https://github.com/ceejbot/tomato"
  version "0.2.0"
  license "BlueOak-1.0.0"

  on_macos do
	if Hardware::CPU.intel?
	  url "https://github.com/ceejbot/tomato/releases/download/v0.2.0/tomato_intel_darwin.tar.gz"
	  sha256 "3339e67aadbff60298b5ebc5a378c9b5543e6b0b9ea1db9f1a59e41ce7f8eb0e"

	  def install
	  	bin.install "tomato_intel_darwin" => "tomato"
		bash_completion.install "completions/tomato.bash" => "tomato"
		zsh_completion.install "completions/tomato.zsh" => "_tomato"
		fish_completion.install "completions/tomato.fish"
	  end
	end
	if Hardware::CPU.arm?
	  url "https://github.com/ceejbot/tomato/releases/download/v0.2.0/tomato_aarch64_darwin.tar.gz"
	  sha256 "f0fc70a21e4b85663535896365598c7b248f161221542e3475a3a9ae0c6bbbfd"

	  def install
		bin.install "tomato_aarch64_darwin" => "tomato"
		bash_completion.install "completions/tomato.bash" => "tomato"
		zsh_completion.install "completions/tomato.zsh" => "_tomato"
		fish_completion.install "completions/tomato.fish"
	  end
	end
  end

  on_linux do
	if Hardware::CPU.intel?
	  url "https://github.com/ceejbot/tomato/releases/download/v0.2.0/tomato_amd64_linux.tar.gz"
	  sha256 "db6ffefdaef6b97d2fce2b9f9f1d56a42c7c45aa5ba86458b72ff08179199ac4"

	  def install
		bin.install "tomato_amd64_linux" => "tomato"
		bash_completion.install "completions/tomato.bash" => "tomato"
		zsh_completion.install "completions/tomato.zsh" => "_tomato"
		fish_completion.install "completions/tomato.fish"
	  end
	end
	if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
	  url "https://github.com/ceejbot/tomato/releases/download/v0.2.0/tomato_arm64_linux.tar.gz"
	  sha256 "354be1b2132526f8bcd061a3e8934d220bb0cc1a69567406d4bac00ca84d0829"

	  def install
		bin.install "tomato_arm64_linux" => "tomato"
		bash_completion.install "completions/tomato.bash" => "tomato"
		zsh_completion.install "completions/tomato.zsh" => "_tomato"
		fish_completion.install "completions/tomato.fish"
	  end
	end
  end
end
