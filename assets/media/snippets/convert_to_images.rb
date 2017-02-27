#!/usr/bin/env ruby

=begin
Setup instructions:

  * Pygments: `sudo pip install Pygments`
  * Python image libraries: `sudo pip install pillow`

=end

require 'pathname'
require 'fileutils'

Dir['posts/*'].each {|dir_name|
  puts "Scanning directory #{dir_name}"

  image_dir = Pathname.new(dir_name).sub('posts/', 'images/')
  FileUtils.mkdir_p(image_dir)

  Dir[dir_name + '/*'].each {|snippet_file|
    pathname = Pathname.new(snippet_file)
    image_file = image_dir + pathname.basename.sub(pathname.extname, '.png')

    puts "\tPygmentizing snippet file #{pathname.basename}"
    `pygmentize -o #{image_file} #{snippet_file}`
  }
}
