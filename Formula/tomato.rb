require "download_strategy"
require "utils/formatter"
require "utils/github"
require "system_command"

class GitHubCliDownloadStrategy < CurlDownloadStrategy
	require "utils/formatter"
	require "utils/github"
	require "system_command"

	def initialize(url, name, version, **meta)
	    super
	    # Extract owner and repo from the URL
	    # Example: https://github.com/ceejbot/formulaic/releases/download/main/formulaic-aarch64-apple-darwin.tar.gz
	    match_data = %r{^https?://github\.com/(?<owner>[^/]+)/(?<repo>[^/]+)/releases/download}.match(@url)
	    return unless match_data

	    @owner = match_data[:owner]
	    @repo = match_data[:repo]
	    @filename = File.basename(@url)
	end

	def fetch(timeout: nil)
		ohai "Downloading #{url} using GitHub CLI"
		if cached_location.exist?
		    puts "Already downloaded: #{cached_location}"
		else
			begin
			  	# Create the temporary directory
			  	temporary_path.dirname.mkpath

			  	# Use gh CLI to download the release asset
			  	system_command("/opt/homebrew/bin/gh", args: [
				   		"release", "download",
						"-R", "#{@owner}/#{@repo}",
				   		"--pattern", "#{@filename}",
						"-D", "#{temporary_path}"
				     ], print_stderr: true)
			rescue ErrorDuringExecution
        		raise GitHubCliDownloadStrategyError, "GitHub CLI download failed for: #{url}"
      		end
			cached_location.dirname.mkpath

			# Find the downloaded file in the temporary path
			downloaded_file = Dir["#{temporary_path}/*"].first

			if downloaded_file
				FileUtils.mv(downloaded_file, cached_location)
			else
				raise GitHubCliDownloadStrategyError, "Downloaded file not found in #{temporary_path}"
			end
		end

		symlink_location.dirname.mkpath
    	FileUtils.ln_s cached_location.relative_path_from(symlink_location.dirname), symlink_location, force: true
	end
end

class Tomato Toml < Formula
    desc "🍅 A command-line tool to get and set values in toml files while preserving comments and formatting."
    homepage "https://github.com/ceejbot/tomato"
    version "0.5.1"
    license "BlueOak-1.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/tomato/releases/download/v0.5.1/tomato-aarch64-apple-darwin.tar.gz", using: GitHubCliDownloadStrategy
        sha256 "10837e772d4e836035d4e7bfe2462136c3669534090aeb8c8f2cf65a0eb75c2d"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/tomato/releases/download/v0.5.1/tomato-x86_64-apple-darwin.tar.gz", using: GitHubCliDownloadStrategy
        sha256 "312e6198b129b5e412d1817b6f88bf3595821566817023ac2a1eac5db12f2aaa"
    end
    if OS.linux? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/tomato/releases/download/v0.5.1/tomato-x86_64-unknown-linux-gnu.tar.gz", using: GitHubCliDownloadStrategy
        sha256 "f9c5c4841922185d3c9c560c5f1fa8d729c9bb5190dae96fc0e870a7bef4fbeb"
    end

    BINARY_ALIASES = {
        "aarch64-apple-darwin":     {},
        "x86_64-apple-darwin":      {},
        "x86_64-pc-windows-gnu":    {},
        "x86_64-unknown-linux-gnu": {},
    }.freeze

    def target_triple
        cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
        os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"
        "#{cpu}-#{os}"
    end

    def install_binary_aliases!
        BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
            dests.each do |dest|
            bin.install_symlink bin/source.to_s => dest
            end
        end
    end

    def install
        bin.install "tomato" if OS.mac? && Hardware::CPU.arm?
        bin.install "tomato" if OS.mac? && Hardware::CPU.intel?
        bin.install "tomato" if OS.linux? && Hardware::CPU.intel?

        install_binary_aliases!
        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
