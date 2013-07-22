require "formula"

class YumDoc < Formula
  sha1 '8ec5d339e4518a7908fd4db0721740288a3d8b6c'
  url 'http://yum.baseurl.org/download/3.4/yum-3.4.3.tar.gz'
  version '3.4.3'

  def install
    cd "docs" do
      inreplace "Makefile" do |m|
        m.gsub! %r{/usr}, ""
      end

      ENV["DESTDIR"] = prefix
      system "make install"
    end
  end
end
