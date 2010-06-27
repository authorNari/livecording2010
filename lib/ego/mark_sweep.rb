# Mark&SweepアルゴリズムのGC
module EGO
  class MarkSweep < GC
    def initialize
      super
      @heap = LinerHeap.new(self)
    end

    class Object
      attr_reader :marked

      def initialize
        @marked = false
      end

      # @api public
      def children
        raise NotImplementedError
      end

      def mark
        return if @marked
        @marked = true
        children.each{|o| o.mark }
      end
    end

    # GC開始
    def start
      mark_phase
      sweep_phase
    end

    private
    def mark_phase
      roots.each{|address| @heap[address].mark }
    end

    def sweep_phase
      @heap.obj_visit do |obj, obj_heap, i|
        return if obj.nil? || obj.marked
        obj_heap[i] = nil
      end
    end
  end
end
