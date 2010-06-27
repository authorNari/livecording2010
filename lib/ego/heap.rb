module EGO
  class Heap
    def initialize(gc)
      @gc = gc
    end

    # オブジェクト生成
    #
    # === 引数
    # * klass - 生成したいクラスを指定
    #
    # === 戻り値
    # heapのindex(address)
    def alloc(klass)
      raise NotImplementedError
    end

    # オブジェクト取得
    def [](address)
      raise NotImplementedError
    end
  end
end
