require 'formula'

class Screen <Formula
  url 'http://ftp.gnu.org/gnu/screen/screen-4.0.3.tar.gz'
  homepage 'http://www.gnu.org/software/screen'
  md5 '8506fd205028a96c741e4037de6e3c42'
  version '4.00.03'

  head 'git://git.savannah.gnu.org/screen.git', :branch => 'master'

  def patches
    if ARGV.build_head?
      [
        'http://gist.github.com/raw/619709/204445d49cbf06e0cfe609325b06ee11c794f34b/screen-mac-pbcopy.patch',
        'http://gist.github.com/raw/626040/be6a04f0e64c56185ba5850415ac59dad4cd62a0/screen-utf8-nfd.patch'
      ]
    else
      [
        'http://trac.macports.org/raw-attachment/ticket/20862/screen-4.0.3-snowleopard.patch',
        'http://gist.github.com/raw/619709/6ba149734cbb3b24033b16110c1d71302b101e64/screen-mac-pbcopy.patch',
        'http://gist.github.com/raw/632245/7adc4a7b85f66dcc7cbb1839d5c10d295567b287/screen-utf8-nfd.patch'
      ]
    end
  end

  def install
    cd 'src'

    if ARGV.build_head?
      system "autoconf"
      system "autoheader"
    end

    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}", "--infodir=#{info}",
                          "--enable-colors256"
    system "make"
    system "make install"
  end
end
