# frozen_string_literal: true

class Literal::Structish
	extend Literal::Attributable

	protected attr_reader :attributes

	def to_h
		@attributes.dup
	end

	def ==(other)
		case other
		when Literal::Structish
			@attributes == other.attributes
		else
			false
		end
	end

	alias_method :eql?, :==

	def [](key)
		@attributes[key]
	end

	def []=(key, value)
		type = @literal_attributes[key].type

		if type === value
			@attributes[key] = value
		else
			raise Literal::TypeError.expected(value, to_be_a: type)
		end
	end

	def deconstruct
		@attributes.values
	end

	def deconstruct_keys(keys)
		h = to_h
		keys ? h.slice(*keys) : h
	end
end
