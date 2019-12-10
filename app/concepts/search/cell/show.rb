module Search
  module Cell
    class Show < Trailblazer::Cell
      def result
        model[:words]
      end
    end
  end
end
