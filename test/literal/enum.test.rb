# frozen_string_literal: true

Color = Literal::Enum(Integer).define do
	Red(0)
	Green(1)
	Blue(3)
end

test "the enum class is frozen" do
	assert Color.frozen?
end

test "the enum class is enumerable" do
	expect(Color).to_be_an Enumerable
	expect(Color.map(&:value)) == [0, 1, 3]
end

test "type checking" do
	expect {
		Literal::Enum(Integer).define do
			Red("red")
		end
	}.to_raise(Literal::TypeError)
end

test "you can't add members after the initial definition" do
	expect {
		Color::Yellow(4)
	}.to_raise(NoMethodError)
end

test "you can't use the same name twice" do
	expect {
		Literal::Enum(Integer).define do
			Red(0)
			Red(1)
		end
	}.to_raise(ArgumentError)
end

test "you can't use the same value twice" do
	expect {
		Literal::Enum(Integer).define do
			Red(0)
			Green(0)
		end
	}.to_raise(ArgumentError)
end

test "the enum members are frozen" do
	assert Color.all?(&:frozen?)
end

test "values" do
	expect(Color.values) == [0, 1, 3]
end

test "predicates" do
	assert Color::Red.red?
	refute Color::Green.red?
	refute Color::Blue.red?
end

test "values are frozen" do
	Example = Literal::Enum(String).define do
		Foo(+"foo")
	end

	assert Example::Foo.value.frozen?
end

test "casting a value" do
	expect(Color[0]) == Color::Red
	expect(Color[1]) == Color::Green
	expect(Color[3]) == Color::Blue
end
