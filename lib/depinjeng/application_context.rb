module Depinjeng
  class ApplicationContext

    def initialize(definitions)
      @definitions = definitions
      @singleton_cache = {}
    end

    def get(name)
      {
        prototype: method(:create)
      }.fetch(
        scope_strategy(name),
        method(:singleton)
      ).call(name)
    end

    def scope_strategy(name)
      definition(name)[:scope]
    end

    private

    attr_reader :definitions

    def singleton(name)
      @singleton_cache.fetch(name) do |key|
        @singleton_cache[key] = create(name)
      end
    end

    def create(name)
      dependencies = definition(name).fetch(:dependencies, [])

      arguments = dependencies.map do |dependency_name|
        create(dependency_name)
      end

      definition(name).fetch(:class).new(*arguments)
    end

    def definition(name)
      definitions.fetch(name)
    end
  end
end