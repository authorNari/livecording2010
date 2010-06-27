# the egoism gc for eco!!
module EGO
  class GC
    attr_reader :heap
    def initialize
      @root_blocks = []
    end

    # GC開始
    def start
      raise NotImplementedError
    end

    # rootsの追加
    #
    # === 引数
    # * &block - heapのindex(address)のarrayを返す
    def add_roots(&block)
      @root_blocks << block
    end

    private
    def roots
      return @root_blocks.map{|rb| rb.call }.flatten
    end
  end
end

require "ego/mark_sweep"
require "ego/heap"
require "ego/liner_heap"
