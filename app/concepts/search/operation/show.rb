require 'trailblazer/operation'

module Search
  module Operation
    class Show < Trailblazer::Operation
      step    :main_search
      step    :check_amount
      step    :type_n_designed
      step    :negative_word?
      step    :negative_search
      fail    :show_error

      ITEM_NOT_FOUND = 'Not found!'.freeze
      JSON_FILE = JSON.parse(File.read('data.json'))

      def main_search(ctx, _options)         #main search logic implemented in this method
        search_word = ctx[:params].downcase
        ctx[:words] = []
        JSON_FILE.each do |line|
          ctx[:words] << line if line.values.map(&:downcase).grep(Regexp.new(search_word)).any? ||
                                 line.values.map(&:downcase).grep(Regexp.new(reverse_string(search_word))).any?
        end
      end

      def reverse_string(word)               #this method transforms to reverse string (lisp common == common lisp)
        word.split.reverse.join(' ')
      end

      def check_amount(ctx, _options)       #this method checks if search word include only 1 word and returns in next method (type_n_designed) to avoid errors 
        return if ctx[:params].split.length == 1

        true
      end

      def type_n_designed(ctx, _options)   #this method finds result that matchs in different fields
        search_word = ctx[:params].downcase
        ctx[:words] = []
        JSON_FILE.each do |i|
          ctx[:words] << i if search_word.split.any? { |w| i['Type'].downcase.split(', ').include? w } &&
                              search_word.split.any? { |w| i['Designed by'].downcase.split.include? w } ||
                              search_word.split(/\W+/)[-2..-1].join(' ')
                                         .split.all? { |w| i['Designed by'].downcase.split.include? w }
        end
      end

      def negative_word?(ctx, _options)   #this method checks if search word include negative symbol
        ctx[:params].split.last.include?('-')
      end

      def negative_search(ctx, _options)  #this method finds negative results that matchs in different fields
        search_word = ctx[:params].downcase
        ctx[:words] = []
        new_words = search_word.tr('-', '').split
        JSON_FILE.each do |i|
          ctx[:words] << i if new_words.all? { |w| i['Type'].downcase.split(', ').exclude? w } &&
                              new_words.any? { |w| i['Designed by'].downcase.split.include? w }
        end
      end

      def show_error(_options, ctx)
        ctx[:words] << ITEM_NOT_FOUND     #this method returns 'not found' if search result is empty
      end
    end
  end
end
