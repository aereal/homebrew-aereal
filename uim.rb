require 'formula'

class Uim < Formula
  homepage 'http://code.google.com/p/uim/'
  url 'http://uim.googlecode.com/files/uim-1.8.6.tar.bz2'
  sha1 '43b9dbdead6797880e6cfc9c032ecb2d37d42777'

  depends_on 'pkg-config' => :build
  depends_on 'intltool' => :build
  depends_on 'gettext'

  def install
    ENV.append 'CFLAGS', '-g -O0'
    ENV.append 'CXXFLAGS', '-g -O0'
    system "./configure",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
