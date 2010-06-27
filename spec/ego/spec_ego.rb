$: << File.join(File.dirname(__FILE__), "../../../lib")
require "ego"

class MockObject
end

LinerHeap = EGO::LinerHeap

describe EGO do
  describe "LinerHeap#alloc" do
    it "オブジェクトを生成してアドレスを返す" do
      liner_heap = LinerHeap.new(EGO::GC.new)
      liner_heap.alloc(MockObject).should == 0
      liner_heap.alloc(MockObject).should == 1
    end
  end
end
