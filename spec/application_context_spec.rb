require_relative '../lib/depinjeng'

module Depinjeng
  describe ApplicationContext do
    describe '#get' do
      it 'should return an instantiated class' do
        class Foo
        end

        setup_hash = {
          foo: {
            class: Foo
          }
        }

        expect(ApplicationContext.new(setup_hash).get(:foo)).to be_instance_of Foo
      end

      it 'should return an instantiated class with injected dependency' do
        class Bar
          attr_accessor :baz

          def initialize(baz)
            @baz = baz
          end
        end

        class Baz
        end

        setup_hash = {
          bar: {
            class: Bar,
            dependencies: [:baz]
          },
          baz: {
            class: Baz
          }
        }

        ac = ApplicationContext.new(setup_hash)
        bar = ac.get(:bar)
        expect(bar.baz).to be_instance_of Baz
      end

      it 'should return turtles all the way down' do
        class A
          attr_accessor :b

          def initialize(b)
            @b = b
          end
        end

        class B
          attr_accessor :c

          def initialize(c)
            @c = c
          end
        end

        class C
        end

        setup_hash = {
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

        ac = ApplicationContext.new(setup_hash)
        a = ac.get(:a)
        expect(a.b.c).to be_instance_of C
      end

      it 'multiple dependencies' do
        class D
          attr_accessor :e, :f

          def initialize(e, f)
            @e = e
            @f = f
          end
        end

        class E
        end

        class F
        end

        setup_hash = {
          d: {
            class: D,
            dependencies: [:e, :f]
          },
          e: {
            class: E
          },
          f: {
            class: F
          }
        }

        ac = ApplicationContext.new(setup_hash)
        d = ac.get(:d)
        expect(d.e).to be_instance_of E
        expect(d.f).to be_instance_of F
      end

      it 'should the same instance when requested multiple times' do
        class Foo
        end

        setup_hash = {
          foo: {
            class: Foo
          }
        }

        application_context = ApplicationContext.new(setup_hash)
        foo = application_context.get(:foo)

        expect(application_context.get(:foo)).to be foo
      end

      it 'should return a new instance when scoped as prototype' do
        class Foo
        end

        setup_hash = {
          foo: {
            class: Foo,
            scope: :prototype
          }
        }

        application_context = ApplicationContext.new(setup_hash)
        foo = application_context.get(:foo)

        expect(application_context.get(:foo)).to_not be foo
      end
    end
  end
end