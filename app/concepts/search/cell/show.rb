module Search
  module Cell
    class Show < Trailblazer::Cell
      def custom
        model[:words]
      end
    end
  end
end
