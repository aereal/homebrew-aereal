require 'formula'

class Refe < Formula
  url 'http://doc.ruby-lang.org/archives/201107/ruby-refm-1.9.2-dynamic-20110729.tar.gz'
  homepage 'http://redmine.ruby-lang.org/projects/rurema/'
  md5 '537f4f50272cea1ae20f5e08a025aa51'

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
    prefix.install %w(bitclust/ db-1_8_7/ db-1_9_2/)
  end

  def refe_command
    default_version = ARGV.include?('--1.8.7') ? '1_8_7' : '1_9_2'
    <<-REFE.gsub /^\s+/, ''
    #!/bin/sh
    exec ruby -Ke -I #{prefix}/bitclust/lib #{prefix}/bitclust/bin/refe.rb -d #{prefix}/db-#{default_version} "$@"
    REFE
  end
end
