require_relative '../lib/depinjeng'

class A
  attr_accessor :b

  def initialize(b)
    @b = b
  end

  def call
    'Hello from a! ' + b.call
  end
end

class B
  attr_accessor :c

  def initialize(c)
    @c = c
  end

  def call
    'Hello from b! ' + c.call
  end
end

class C
  def call
    'Hello from c!'
  end
end

class Barrista
  attr_accessor :beverage

  def initialize(beverage)
    @beverage = beverage
  end

  def call
    beverage.call
  end
end

class Coffee
  attr_accessor :cream

  def initialize(cream = Proc.new{})
    @cream = cream
  end

  def call
    "coffee #{cream.call}"
  end

end

class HotChocolate
  def call
    "hot chocolate rocks!"
  end
end

class Cream
  def initialize(sugar = Proc.new{})
    @sugar = sugar
  end

  def call
    "cream #{@sugar.call}"
  end
end

class Sugar
  def call
    "sugar"
  end
end


setup_hash = {
  barrista: {
    class: Barrista,
    dependencies: [:coffee]
  },
  lew: {
    class: Barrista,
    dependencies: [:coffee_cream]
  },
  david: {
    class: Barrista,
    dependencies: [:hot_chocolate]
  },
  black_coffee: {
    class: Coffee
  },
  coffee: {
    class: Coffee,
    dependencies: [:cream]
  },
  hot_chocolate: {
    class: HotChocolate
  },
  coffee_cream: {
    class: Coffee,
    dependencies: [:cream_no_sugar]
  },
  cream: {
    class: Cream,
    dependencies: [:sugar]
  },
  cream_no_sugar: {
    class: Cream,
  },
  sugar: {
    class: Sugar,
  },
  a: {
    class: A,
    dependencies: [:b]
  },
  b: {
    class: B,
    dependencies: [:c]
  },
  c: {
    class: C
  }
}

a = Depinjeng::ApplicationContext.new(setup_hash).get(:david)
a_prime = A.new(B.new(C.new))

puts a.call

puts a_prime.call