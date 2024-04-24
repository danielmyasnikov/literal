# frozen_string_literal: true

# @api private
Literal::Types::AnyType = Literal::Singleton.new do
	def initialize
		freeze
	end

	def inspect = "_Any"

	def ===(value)
		!(nil === value)
	end

	def ==(other)
		equal?(other)
	end
end
