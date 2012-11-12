require 'formula'

class Refe < Formula
  url 'http://doc.ruby-lang.org/archives/201208/ruby-refm-1.9.3-dynamic-20120829.tar.gz'
  homepage 'http://redmine.ruby-lang.org/projects/rurema/'
  sha1 '28ab71616a4bce4ac76df3a3f79ab17b8a6fccf6'
  version '20120829'

  def options
    [
      ['--1.8.7', 'search the 1.8.7 manuals by default.']
    ]
  end

  def install
    refe_cmds = Dir.glob('refe-*[^.cmd]')
    refe_cmds.each do |cmd|
      inreplace cmd do |s|
        s.gsub! /^cd.*$/, ''
        s.gsub! /bitclust\//, "#{prefix}/bitclust/"
        s.gsub! /-d\s*/, "-d #{prefix}/"
      end
    end
    bin.install ['server.rb', *refe_cmds]
    (bin + 'refe').tap do |f|
      f.write refe_command
      f.chmod 0755
    end
    prefix.install %w(bitclust/ db-1_8_7/ db-1_9_3/)
  end

  def refe_command
    default_version = ARGV.include?('--1.8.7') ? '1_8_7' : '1_9_3'
    <<-REFE.gsub /^\s+/, ''
    #!/bin/sh
    exec ruby -Ke -I #{prefix}/bitclust/lib #{prefix}/bitclust/bin/refe.rb -d #{prefix}/db-#{default_version} "$@"
    REFE
  end
end
