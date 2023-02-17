class Protobuf < Formula
  desc "Protocol buffers (Google's data interchange format)"
  homepage "https://protobuf.dev/"
  url "https://github.com/protocolbuffers/protobuf/releases/download/v22.0/protobuf-22.0.tar.gz"
  sha256 "e340f39fad1e35d9237540bcd6a2592ccac353e5d21d0f0521f6ab77370e0142"
  license "BSD-3-Clause"
  head "https://github.com/protocolbuffers/protobuf.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_ventura:  "3c5d748539ceda50335ecea31041934e3b4d3d927c10ee1f3996db6fac79fb2e"
    sha256 cellar: :any,                 arm64_monterey: "fdc3ded19005c755de4a5c29aa23c868cf24f45623b49587dda98a93d2fe0f70"
    sha256 cellar: :any,                 arm64_big_sur:  "d70aa6ab732457192ec4e4b3c7ad27e4b378c5c450221f0d608b98d38e52596d"
    sha256 cellar: :any,                 ventura:        "fc99214087c90571c8d9dd7d36e30af49a89beb996359b3b234f31002e4b0c00"
    sha256 cellar: :any,                 monterey:       "44db5f3a73f9e3d9725e90e8fcaa73b1929be24f04efb20b79e1b288ef7d704e"
    sha256 cellar: :any,                 big_sur:        "d64e264d07b331a8043c35d608de0871e9df4f9a9b208d5d8060b956f110baed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b24e37fc94949837ae10ab0dff5caf1af2022b3b3ec9b918789478ff4bf6f686"
  end

  depends_on "cmake" => :build
  depends_on "python@3.10" => [:build, :test]
  depends_on "python@3.11" => [:build, :test]
  depends_on "abseil"

  uses_from_macos "zlib"

  # Fix unexported symbols on arm64.
  patch do
    on_arm do
      url "https://github.com/protocolbuffers/protobuf/commit/2ce56399e30db62e45869c6fd2d2bbacbb81a7ed.patch?full_index=1"
      sha256 "8cd14300c654ffed14b2f0d70c213fa39ae24dee7c6157f50263dd92808d8f77"
    end
  end

  def pythons
    deps.map(&:to_formula)
        .select { |f| f.name.match?(/^python@\d\.\d+$/) }
        .map { |f| f.opt_libexec/"bin/python" }
  end

  def install
    # Keep `CMAKE_CXX_STANDARD` in sync with the same variable in `abseil.rb`.
    cmake_args = %w[
      -Dprotobuf_BUILD_LIBPROTOC=ON
      -Dprotobuf_BUILD_SHARED_LIBS=ON
      -Dprotobuf_INSTALL_EXAMPLES=ON
      -Dprotobuf_BUILD_TESTS=OFF
      -Dprotobuf_ABSL_PROVIDER=package
      -DCMAKE_CXX_STANDARD=17
    ]

    system "cmake", "-S", ".", "-B", "build", *cmake_args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    pkgshare.install "editors/proto.vim"
    elisp.install "editors/protobuf-mode.el"

    ENV.append_to_cflags "-I#{include}"
    ENV.append_to_cflags "-L#{lib}"
    ENV["PROTOC"] = bin/"protoc"

    cd "python" do
      # Keep C++ standard in sync with `abseil.rb`.
      inreplace "setup.py", "extra_compile_args.append('-std=c++14')",
                            "extra_compile_args.append('-std=c++17')"
      pythons.each do |python|
        system python, *Language::Python.setup_install_args(prefix, python), "--cpp_implementation"
      end
    end
  end

  test do
    testdata = <<~EOS
      syntax = "proto3";
      package test;
      message TestCase {
        string name = 4;
      }
      message Test {
        repeated TestCase case = 1;
      }
    EOS
    (testpath/"test.proto").write testdata
    system bin/"protoc", "test.proto", "--cpp_out=."

    pythons.each do |python|
      system python, "-c", "import google.protobuf"
    end
  end
end
