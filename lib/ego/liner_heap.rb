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

    # オブジェクト取得
    def [](address)
      @objects[address]
    end

    def obj_visit(&block)
      @objects.each_with_index do |o, i|
        block.call(o, @objects, i)
      end
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
