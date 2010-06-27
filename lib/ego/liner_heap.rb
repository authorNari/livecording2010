module EGO
  class LinerHeap < Heap
    def initialize(gc)
      super
      @objects = [nil]
    end

    def alloc(klass)
      address = empty_address
      @objects[address] = klass.new
      return address
    end

    private
    def empty_address
      @objects.each_with_index do |o, i|
        return i if o == nil
      end
      return @objects.size
    end
  end
end
