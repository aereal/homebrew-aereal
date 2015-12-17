class FrameworkPythonRequirement < Requirement
  fatal true

  satisfy do
    q = `python -c "import distutils.sysconfig as c; print(c.get_config_var('PYTHONFRAMEWORK'))"`
    !q.chomp.empty?
  end

  def message
    "Python needs to be built as a framework."
  end
end

class MacvimAereal < Formula
  desc "GUI for vim, made for OS X"
  homepage "https://github.com/macvim-dev/macvim"
  url "https://github.com/macvim-dev/macvim/archive/snapshot-87.tar.gz"
  version "7.4-87"
  sha256 "e3afd326fac86e89c0363be834625f29c400e7bd7597acfa18ed9e0fb18975d9"

  head "https://github.com/macvim-dev/macvim.git"

  depends_on :xcode => :build
  depends_on "luajit"
  depends_on :python
  depends_on FrameworkPythonRequirement

  def install
    ENV.delete("PYTHONPATH")

    ENV["ARCHFLAGS"] = "-arch #{MacOS.preferred_arch}"

    ENV.clang if MacOS.version >= :lion

    ENV.prepend "LDFLAGS", `python-config --ldflags`.chomp
    ENV.prepend "CFLAGS", `python-config --cflags`.chomp
    framework_script = <<-EOS.undent
      import distutils.sysconfig
      print distutils.sysconfig.get_config_var("PYTHONFRAMEWORKPREFIX")
    EOS
    framework_prefix = `python -c '#{framework_script}'`.strip
    unless framework_prefix == "/System/Library/Frameworks"
      ENV.prepend "LDFLAGS", "-F#{framework_prefix}"
      ENV.prepend "CFLAGS", "-F#{framework_prefix}"
    end

    args = %W[
      --with-features=huge
      --with-macarchs=#{MacOS.preferred_arch}
      --with-tlib=ncurses
      --with-compiledby="aereal w/Homebrew"
      --with-local-dir=#{HOMEBREW_PREFIX}
      --disable-mzschemeinterp
      --disable-tclinterp
      --enable-multibyte
      --enable-perlinterp=dynamic
      --enable-rubyinterp=dynamic
      --enable-pythoninterp=dynamic
      --enable-luainterp=dynamic
      --with-lua-prefix=#{HOMEBREW_PREFIX}
      --with-luajit
    ]

    unless MacOS::CLT.installed?
      args << "--with-developer-dir=#{MacOS::Xcode.prefix}/Platforms/MacOSX.platform/Developer"
      args << "--with-macsdk=#{MacOS.version}"
    end

    system "./configure", *args

    inreplace "src/MacVim/icons/Makefile", "$(MAKE) -C makeicns", ""
    inreplace "src/MacVim/icons/make_icons.py", "dont_create = False", "dont_create = True"

    system "make"

    prefix.install "src/MacVim/build/Release/MacVim.app"
    inreplace "src/MacVim/mvim", %r{^# VIM_APP_DIR=\/Applications$},
                                 "VIM_APP_DIR=#{prefix}"
    bin.install "src/MacVim/mvim"

    executables = %w[mvimdiff mview mvimex gvim gvimdiff gview gvimex]
    executables.each { |e| bin.install_symlink "mvim" => e }
  end
end
