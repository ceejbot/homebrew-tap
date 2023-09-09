# typed: false
# frozen_string_literal: true

class Tomato < Formula
  desc "🍅 A command-line tool to get and set values in toml files while preserving comments and formatting."
  homepage "https://github.com/ceejbot/tomato"
  version "0.4.0"
  license "BlueOak-1.0.0"

  on_macos do
	if Hardware::CPU.intel?
	  url "https://github.com/ceejbot/tomato/releases/download/0.4.0/tomato-toml-x86_64-apple-darwin.tar.xz"
	  sha256 "138be0297319f7c6a501eb5b52af7a1c97c27c4b073d8790bc54ff604e916cbb"

	  def install
	  	bin.install "tomato" => "tomato"
		generate_completions_from_executable(bin/"tomato", "completions")
	  end
	end
	if Hardware::CPU.arm?
	  url "https://github.com/ceejbot/tomato/releases/download/0.4.0/tomato-toml-aarch64-apple-darwin.tar.xz"
	  sha256 "a69a00e93d33fc1a595ca7c39e4ccfc71f519374b5082e5482fca4fab7a50177"

	  def install
		bin.install "tomato" => "tomato"
		generate_completions_from_executable(bin/"tomato", "completions")
	  end
	end
  end

  on_linux do
	if Hardware::CPU.intel?
	  url "https://github.com/ceejbot/tomato/releases/download/0.4.0/tomato-toml-x86_64-unknown-linux-gnu.tar.xz"
	  sha256 "a40394c35269fbd0f9a00c7454bb00811cb6228cfdb90e9e4e1f42237821053c"

	  def install
		bin.install "tomato" => "tomato"
		generate_completions_from_executable(bin/"tomato", "completions")
	  end
	end
  end
end
