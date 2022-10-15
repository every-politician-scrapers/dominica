#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    field :name do
      Name.new(
        full: texts.first,
        prefixes: %w[Hon. Ms. Mr. Dr.],
      ).short
    end

    field :position do
      texts.drop(1)
    end

    private

    def texts
      noko.css('.catItemIntroText p').map(&:text).map(&:tidy).reject(&:empty?)
    end
  end

  class Members
    def member_container
      noko.css('.catItemBody')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
