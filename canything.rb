require 'formula'

class Canything < Formula
  homepage 'http://filmlang.org/soft/canything'
  head 'git://github.com/keiji0/canything.git'

  depends_on 'ncurses'

  def install
    system 'make'
    bin.install 'canything'
  end

  def test
    system 'make test'
  end
end
