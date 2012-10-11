require 'formula'

class Ncurses < Formula
  homepage 'http://www.gnu.org/software/ncurses/'
  url 'http://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz'
  version '5.9'
  sha1 '3e042e5f2c7223bffdaac9646a533b8c758b65b5'

  def install
    ENV['CFLAGS'] = '-arch i386 -arch x86_64'
    ENV['LDFLAGS'] = '-arch i386 -arch x86_64'

    system './configure',
      '--enable-widec',
      '--enable-overwrite',
      '--enable-ext-color',
      '--enable-pc-files',
      '--enable-warnings',
      '--with-shared',
      "--prefix=#{prefix}",
      "--mandir=#{man}"
    system "make install"
  end

  def patches
    "http://lists.gnu.org/archive/html/bug-ncurses/2011-04/txtkWQqiQvcZe.txt"
  end

  # def test
  #   system "false"
  # end
end
