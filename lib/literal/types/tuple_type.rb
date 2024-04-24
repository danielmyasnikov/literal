# frozen_string_literal: true

# @api private
class Literal::Types::TupleType
	def initialize(*types)
		@types = types
	end

	def inspect = "_Tuple(#{@types.map(&:inspect).join(', ')})"

	def ===(value)
		Array === value && value.size == @types.size && @types.each_with_index.all? { |t, i| t === value[i] }
	end

	def ==(other)
		self.class == other.class && @types == other.types
	end

	protected

	attr_reader :types
end
