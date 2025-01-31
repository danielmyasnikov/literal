# frozen_string_literal: true

class Person < Literal::Data
	prop :name, String
end

class Empty < Literal::Data
end

test "properties have readers by default" do
	person = Person.new(name: "John")
	expect(person.name) == "John"
end

test "data objects are frozen" do
	person = Person.new(name: "John")
	expect(person).to_be(:frozen?)
end

test "immutable attributes are not duplicated" do
	name = "John"
	person = Person.new(name:)

	expect(person.name).to_be(:frozen?)
	expect(person.name).to_equal?(name)
end

test "to_h" do
	person = Person.new(name: "John")
	expect(person.to_h) == { name: "John" }
end

test "can be deconstructed" do
	person = Person.new(name: "John")
	expect(person.deconstruct) == ["John"]
end

test "can be deconstructed with keys" do
	person = Person.new(name: "John")
	expect(person.deconstruct_keys([:name])) == { name: "John" }
end

test "can be used as a hash key" do
	person = Person.new(name: "John")
	person2 = Person.new(name: "Bob")
	hash = { person => "John", person2 => "Bob" }
	expect(hash[person]) == "John"
	expect(hash[person2]) == "Bob"
	expect(hash[Person.new(name: "John")]) == "John"
end

test "empty" do
	empty = Empty.new
	expect(empty.to_h) == {}

	other = Empty.new
	expect(empty) == other
	expect(empty).to_eql?(other)
	expect(empty.hash) == other.hash

	other_empty = Class.new(Literal::Data).new
	expect(empty) != other_empty
	expect(empty).not_to_eql?(other_empty)
	expect(empty.hash) != other_empty.hash
end
