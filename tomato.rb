# typed: false
# frozen_string_literal: true

class Tomato < Formula
  desc "🍅 A command-line tool to get and set values in toml files while preserving comments and formatting."
  homepage "https://github.com/ceejbot/tomato"
  version "0.3.0"
  license "BlueOak-1.0.0"

  on_macos do
	if Hardware::CPU.intel?
	  url "https://github.com/ceejbot/tomato/releases/download/v0.3.0/tomato_intel_darwin.tar.gz"
	  sha256 "343c45d5d1432cb8ffeebba25d8fc48ae403ee75b6dd7593cd7d989302b5a10c"

	  def install
	  	bin.install "tomato" => "tomato"
		bash_completion.install "completions.bash" => "tomato"
		zsh_completion.install "completions.zsh" => "_tomato"
		fish_completion.install "completions.fish" => "tomato"
	  end
	end
	if Hardware::CPU.arm?
	  url "https://github.com/ceejbot/tomato/releases/download/v0.3.0/tomato_aarch64_darwin.tar.gz"
	  sha256 "206f267186b00e1569b3a66604d06818ab463df30fe70343560873e592f36163"

	  def install
		bin.install "tomato" => "tomato"
		bash_completion.install "completions.bash" => "tomato"
		zsh_completion.install "completions.zsh" => "_tomato"
		fish_completion.install "completions.fish" => "tomato"
	  end
	end
  end

  on_linux do
	if Hardware::CPU.intel?
	  url "https://github.com/ceejbot/tomato/releases/download/v0.3.0/tomato_amd64_linux.tar.gz"
	  sha256 "715a74b7ac71bda4b897bd67c55a475f47e0d94674d9c487e0950e3dcc603b54"

	  def install
		bin.install "tomato" => "tomato"
		bash_completion.install "completions.bash" => "tomato"
		zsh_completion.install "completions.zsh" => "_tomato"
		fish_completion.install "completions.fish" => "tomato"
	  end
	end
	if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
	  url "https://github.com/ceejbot/tomato/releases/download/v0.3.0/tomato_arm64_linux.tar.gz"
	  sha256 "a40e0c7572340ce2788bb8e4e47c518f893404dc66ce0d38ea704599c52d5a38"

	  def install
		bin.install "tomato" => "tomato"
		bash_completion.install "completions.bash" => "tomato"
		zsh_completion.install "completions.zsh" => "_tomato"
		fish_completion.install "completions.fish" => "tomato"
	  end
	end
  end
end
