class SearchController < ApplicationController
  def index
    search_word = params[:text]
    if search_word.present?
      result = Search::Operation::Show.call(params: search_word)
      render html: cell(Search::Cell::Show, result)
    else
      render html: cell(Search::Cell::Index, result)
    end
  end
end
