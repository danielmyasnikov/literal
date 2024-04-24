# frozen_string_literal: true

# @api private
class Literal::Types::IsType
	def initialize(*predicates)
		@predicates = predicates
	end

	def inspect = "_Is(#{predicates.map(&:inspect).join(', ')})"

	def ===(value)
		@predicates.all? { |predicate| value.public_send(predicate) }
	end

	def ==(other)
		self.class == other.class && @predicates == other.predicates
	end

	protected

	attr_reader :predicates
end
