# frozen_string_literal: true

require "open-uri"
require "nokogiri"
require "capybara/cuprite"
require "ferrum"

PASSPHRASE = {
  " "=>" ",
  " "=>"",
  "0"=>"0",
  "1"=>"1",
  "."=>"2",
  "Z"=>"3",
  "4"=>"4",
  "2"=>"5",
  "\n"=>"\n",
  ","=>"\n",
  "/"=>",",
  "N"=>"'",
  "I"=>".",
  "b"=>";",
  "`"=>"?",
  "a"=>"…",
  "T"=>"-",
  "M"=>"—",
  "3"=>":",
  "["=>"%",
  "U"=>"(",
  "V"=>")",
  "8"=>"/",
  "5"=>"A",
  "P"=>"B",
  "^"=>"D",
  "]"=>"E",
  "R"=>"F",
  "S"=>"H",
  "D"=>"I",
  "_"=>"K",
  "Q"=>"G",
  "!"=>"M",
  "c"=>"N",
  "="=>"O",
  "Y"=>"P",
  "X"=>"S",
  "7"=>"R",
  "O"=>"T",
  "\\"=>"U",
  "6"=>"V",
  ">"=>"W",
  "d"=>"X",
  "&"=>"Z",
  "\""=>"a",
  "*"=>"b",
  "("=>"c",
  "<"=>"d",
  ")"=>"e",
  "E"=>"f",
  "+"=>"g",
  "@"=>"h",
  "?"=>"i",
  "K"=>"j",
  "$"=>"k",
  "B"=>"l",
  "G"=>"m",
  "-"=>"n",
  "A"=>"o",
  "F"=>"p",
  "L"=>"q",
  "#"=>"r",
  "9"=>"s",
  ":"=>"t",
  "'"=>"u",
  "H"=>"v",
  "C"=>"w",
  "J"=>"x",
  ";"=>"y",
  "W"=>"z"
}

Capybara.javascript_driver = :cuprite
Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(app, window_size: [1200, 800])
end

url = "https://www.scribd.com/document/399594551/2015-06-22-MARK-S-VISION"

browser = Ferrum::Browser.new(browser_options: { 'no-sandbox': nil })
browser.go_to(url)
encrypted_string = browser.css(".ff0").map do |paragraph|
  paragraph.css(".a").map(&:inner_text).join("\n")
end.join("\n")
browser.quit

decrypted = encrypted_string.split("").map { |char| PASSPHRASE[char] || "**#{char}**" }.join
puts decrypted
