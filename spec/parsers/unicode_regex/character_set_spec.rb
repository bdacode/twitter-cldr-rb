# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

include TwitterCldr::Parsers

describe UnicodeRegexParser::CharacterSet do
  describe "#to_set" do
    it "should return a set containing codepoints for the given general property" do
      char_set = UnicodeRegexParser::CharacterSet.new("Zs")
      char_set.to_set.to_a(true).should == [
        32, 160, 5760, 6158, 8192..8202, 8239, 8287, 12288
      ]
    end

    it "should return a set containing codepoints for the given named property" do
      char_set = UnicodeRegexParser::CharacterSet.new("Sentence_Break=Sp")
      char_set.to_set.to_a(true).should == [
        9, 11..12, 32, 160, 5760, 8192..8202, 8239, 8287, 12288
      ]
    end

    it "should raise an exception when given an invalid property name or value" do
      lambda do
        UnicodeRegexParser::CharacterSet.new("Foobar=Sp").to_set
      end.should raise_error(UnicodeRegexParserError)

      lambda do
        UnicodeRegexParser::CharacterSet.new("Sentence_Break=Foo").to_set
      end.should raise_error(UnicodeRegexParserError)
    end
  end
end
