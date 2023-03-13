class CargoRelease < Formula
  desc "Cargo subcommand `release`: everything about releasing a rust crate"
  homepage "https://github.com/crate-ci/cargo-release"
  url "https://github.com/crate-ci/cargo-release/archive/refs/tags/v0.24.5.tar.gz"
  sha256 "15cf892e78ca1090260ef4d498df1d8936696321b20584050a0f89387b438c08"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/crate-ci/cargo-release.git", branch: "master"

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "50717b1871328810c544705bf4dff2efc53fcc7deca4a3d74e44cbc45164ba99"
    sha256 cellar: :any,                 arm64_monterey: "cb2d2e73499bc29250d7659e5e0b4c4fe77fa2f0384f9d1693b5a700643e229a"
    sha256 cellar: :any,                 arm64_big_sur:  "f72a5aa0937dd69dadbd0177d4bc749feefc9805892d31b7542b2a685e01762d"
    sha256 cellar: :any,                 ventura:        "e5b8ac7829f5b39d5bf1e69ae4da8a713db959b4ad2e5d490db920efed12533e"
    sha256 cellar: :any,                 monterey:       "3149e8fcd5f75fa0555a3cf2505af65c264358e3550250f6f9d8b331d9c16e3c"
    sha256 cellar: :any,                 big_sur:        "7b6a0e30908203212465fe79915ff35d62c144eaa3b4087eb26f5777359e421a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a1beacf529d00526c4bbddfc2a099fb0d51890753ba5f5fe43d097c9ea4d7c75"
  end

  depends_on "pkg-config" => :build
  depends_on "libgit2"
  depends_on "libssh2"
  depends_on "openssl@1.1"
  depends_on "rust" # uses `cargo` at runtime

  def install
    ENV["LIBGIT2_SYS_USE_PKG_CONFIG"] = "1"
    ENV["LIBSSH2_SYS_USE_PKG_CONFIG"] = "1"
    # Ensure the correct `openssl` will be picked up.
    ENV["OPENSSL_DIR"] = Formula["openssl@1.1"].opt_prefix
    ENV["OPENSSL_NO_VENDOR"] = "1"

    # Remove the `vendored-libgit2` feature to ensure no vendoring will happen.
    inreplace "Cargo.toml",
      %r{git2 = { version = "(.+?)", features = \["vendored-libgit2"\], default-features = false }},
      'git2 = { version = "\\1", features = [], default-features = false }'

    system "cargo", "install", *std_cargo_args
  end

  # TODO: Add this method to `brew`.
  def check_binary_linkage(binary, library)
    binary.dynamically_linked_libraries.any? do |dll|
      next false unless dll.start_with?(HOMEBREW_PREFIX.to_s)

      File.realpath(dll) == File.realpath(library)
    end
  end

  test do
    system "cargo", "new", "hello_world", "--bin"
    cd "hello_world" do
      assert_match "tag = true", shell_output("cargo release config 2>&1").chomp
    end

    [
      Formula["libgit2"].opt_lib/shared_library("libgit2"),
      Formula["libssh2"].opt_lib/shared_library("libssh2"),
      Formula["openssl@1.1"].opt_lib/shared_library("libssl"),
      Formula["openssl@1.1"].opt_lib/shared_library("libcrypto"),
    ].each do |library|
      assert check_binary_linkage(bin/"cargo-release", library),
             "No linkage with #{library.basename}! Cargo is likely using a vendored version."
    end
  end
end
