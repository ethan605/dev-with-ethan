#!/usr/bin/env ruby

=begin
Setup instructions:

  * Pygments: `sudo pip install Pygments`
  * Python image libraries: `sudo pip install pillow`
  * Custom fonts:
    
    - Install any `.ttf` font into either "~/Library/Fonts/", '/Library/Fonts/' or '/System/Library/Fonts'
    - Replace `CUSTOM_FONT_NAME` with font's file name (whitespaces included), in this case is `Hack-Regular.ttf` -> CUSTOM_FONT_NAME = 'Hack-Regular'
    - Replace `CUSTOM_FONT_SIZE` with desired font size

=end

require "pathname"
require "fileutils"

CUSTOM_FONT_NAME = "Hack-Regular"
CUSTOM_FONT_SIZE = 15

def convert_snippet(snippet_file, image_file)
  pathname = Pathname.new(snippet_file)
  puts "\tPygmentizing snippet file #{pathname.basename}"

  `pygmentize -f img \
    -P "font_name=#{CUSTOM_FONT_NAME}" \
    -P "font_size=#{CUSTOM_FONT_SIZE}" \
    -o #{image_file} #{snippet_file}`
end

def process_all
  Dir["posts/*"].each {|dir_name|
    puts "Scanning directory #{dir_name}"

    image_dir = Pathname.new(dir_name).sub("posts/", "images/")
    FileUtils.mkdir_p(image_dir)

    Dir["#{dir_name}/*"].each {|snippet_file|
      pathname = Pathname.new(snippet_file)
      image_file = image_dir + pathname.basename.sub(pathname.extname, ".png")
      convert_snippet(snippet_file, image_file)
    }
  }
end

process_all