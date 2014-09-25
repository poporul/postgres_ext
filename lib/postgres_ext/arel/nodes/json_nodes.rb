require 'arel/nodes/equality'

class JsonString < String
  def object_delimiter
    "->".to_sym
  end

  def scalar_delimiter
    "->>".to_sym
  end
end

module Arel
  module Nodes
    class JsonPull < Arel::Nodes::Equality
      def initialize(left, right)
        left.name = JsonString.new(left.name)
        right = right.to_s

        super(left, right)
      end
    end

    class JsonPullIn < Arel::Nodes::In
      def initialize(left, right)
        left.name = JsonString.new(left.name)
        super(left, right)
      end
    end
  end
end
