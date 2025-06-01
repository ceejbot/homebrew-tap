require "download_strategy"
require "utils/github/artifacts"
require "utils/formatter"
require "utils/github"
require "system_command"

class GitHubCliDownloadStrategy < GitHubArtifactDownloadStrategy
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
			  	# Use gh CLI to download the release asset
			  	system_command("gh", args: [
				   		"release", "download",
						"-R", "#{@owner}/#{@repo}",
				   		"--pattern", "#{@filename}",
						"-D", "#{temporary_path}"
				     ], print_stderr: true)
			rescue ErrorDuringExecution
        		raise "GitHub CLI download failed for: #{url}"
      		end
			cached_location.dirname.mkpath
			
			# Find the downloaded file in the temporary path
			downloaded_file = Dir["#{temporary_path}/*"].first
			
			if downloaded_file
				FileUtils.mv(downloaded_file, cached_location)
			else
				raise "Downloaded file not found in #{temporary_path}"
			end
		end

		symlink_location.dirname.mkpath
    	FileUtils.ln_s cached_location.relative_path_from(symlink_location.dirname), symlink_location, force: true
	end
end

class FormulaicTest < Formula
    desc "update homebrew tap formulas for Rust projects from the latest github release"
    homepage "https://api.github.com/repos/ceejbot/formulaic"
    version "0.1.1"
    license "Parity-7.0.0"
    if OS.mac? && Hardware::CPU.arm?
        url    "https://github.com/ceejbot/formulaic/releases/download/main/formulaic-x86_64-apple-darwin.tar.gz", using: GitHubCliDownloadStrategy
        sha256 "5baa3355c92c703bf8bfb958c6a998ee1f5e404f4caf68da859a609a6d963d93"
    end
    if OS.mac? && Hardware::CPU.intel?
        url    "https://github.com/ceejbot/formulaic/releases/download/main/formulaic-x86_64-apple-darwin.tar.gz", using: GitHubCliDownloadStrategy
        sha256 "7315455c51131320f210bbfeafd7cc249fd3e4cf7f2148ba116c3cdaea8a1b2b"
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
        bin.install "formulaic" if OS.mac? && Hardware::CPU.arm?
        bin.install "formulaic" if OS.mac? && Hardware::CPU.intel?

        install_binary_aliases!
        doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
        leftover_contents = Dir["*"] - doc_files
        pkgshare.install(*leftover_contents) unless leftover_contents.empty?
    end
end
