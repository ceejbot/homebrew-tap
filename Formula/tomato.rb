# typed: false
# frozen_string_literal: true

class Tomato < Formula
  desc "🍅 A command-line tool to get and set values in toml files while preserving comments and formatting."
  homepage "https://github.com/ceejbot/tomato"
  version "0.5.0"
  license "BlueOak-1.0.0"

  on_macos do
	if Hardware::CPU.intel?
	  url "https://github.com/ceejbot/tomato/releases/download/0.5.0/tomato-toml-x86_64-apple-darwin.tar.xz"
	  sha256 "d8791c4f2774e0a33d7243428c11de4dc391688354bda0651fbcb889a9eca2aa"

	  def install
	  	bin.install "tomato" => "tomato"
		generate_completions_from_executable(bin/"tomato", "completions")
	  end
	end
	if Hardware::CPU.arm?
	  url "https://github.com/ceejbot/tomato/releases/download/0.5.0/tomato-toml-aarch64-apple-darwin.tar.xz"
	  sha256 "eb5f8f3bb0529039b74500f63cb423e8188594be81ec95e1c4d079c9f772f19c"

	  def install
		bin.install "tomato" => "tomato"
		generate_completions_from_executable(bin/"tomato", "completions")
	  end
	end
  end

  on_linux do
	if Hardware::CPU.intel?
	  url "https://github.com/ceejbot/tomato/releases/download/0.5.0/tomato-toml-x86_64-unknown-linux-gnu.tar.xz"
	  sha256 "b19bda495264a02a2eb24ee82d2cf0fe7fe7639d2d0a028b7ceac336cd8e6cd7"

	  def install
		bin.install "tomato" => "tomato"
		generate_completions_from_executable(bin/"tomato", "completions")
	  end
	end
  end
end
