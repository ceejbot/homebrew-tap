# typed: false
# frozen_string_literal: true

class Tomato < Formula
  desc "🍅 A command-line tool to get and set values in toml files while preserving comments and formatting."
  homepage "https://github.com/ceejbot/tomato"
  version "0.1.0"
  license "BlueOak-1.0.0"

  on_macos do
	if Hardware::CPU.intel?
	  url "https://github.com/ceejbot/tomato/releases/download/v0.1.0/tomato_intel_darwin"
	  sha256 "064e2c6551e105ee62728b2e43158c9231aeb8b7904b0d3d1f3de6569ae6d3dd"

	  def install
	  	bin.install "tomato_intel_darwin" => "tomato"
	  end
	end
	if Hardware::CPU.arm?
	  url "https://github.com/ceejbot/tomato/releases/download/v0.1.0/tomato_aarch64_darwin"
	  sha256 "d2d8ee99214c861f1d99181b048ce3b2fa450a909624679e92ea93ed206b80f3"

	  def install
		bin.install "tomato_aarch64_darwin" => "tomato"
	  end
	end
  end

  on_linux do
	if Hardware::CPU.intel?
	  url "https://github.com/ceejbot/tomato/releases/download/v0.1.0/tomato_amd64_linux"
	  sha256 "baf2b6e75d734a9064418f4dc2353483e76c58592e7433db77a99123cb79b1af"

	  def install
		bin.install "tomato_amd64_linux" => "tomato"
	  end
	end
	if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
	  url "https://github.com/ceejbot/tomato/releases/download/v0.1.0/tomato_arm64_linux"
	  sha256 "2d5ee6ecfd24930bc319274a51ff6d47318e91f17360979bb4392f090fd5c032"

	  def install
		bin.install "tomato_arm64_linux" => "tomato"
	  end
	end
  end
end
