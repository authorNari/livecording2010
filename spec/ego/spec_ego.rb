$: << File.join(File.dirname(__FILE__), "../../../lib")
require "ego"

class ChildMockObject < EGO::MarkSweep::Object
  def initialize
    super
  end

  def children
    @childs = []
  end
end

class MockObject < EGO::MarkSweep::Object
  def initialize
    super
    @childs = []
    @childs << ChildMockObject.new
  end

  def children
    @childs
  end
end

LinerHeap = EGO::LinerHeap

describe EGO do
  it "LinerHeap#allocはオブジェクトを生成してアドレスを返す" do
    liner_heap = LinerHeap.new(EGO::GC.new)
    liner_heap.alloc(MockObject).should == 0
    liner_heap.alloc(MockObject).should == 1
  end

  it "MarkSweep::Object#markはオブジェクト、子オブジェクトをマークできる" do
    o = MockObject.new
    o.mark
    o.marked.should == true
    o.children[0].marked.should == true
  end

  it "MarkSweep#start後にルートに登録されているオブジェクトは削除されない" do
    gc = EGO::MarkSweep.new
    liner_heap = gc.heap
    address = liner_heap.alloc(MockObject)
    gc.add_roots{ [address] }
    gc.start
    liner_heap[address].should_not == nil
  end

  it "MarkSweep#start後にルートに登録されていないオブジェクトは削除されている" do
    gc = EGO::MarkSweep.new
    liner_heap = gc.heap
    address1 = liner_heap.alloc(MockObject)
    address2 = liner_heap.alloc(ChildMockObject)
    gc.start
    liner_heap[address1].should == nil
    liner_heap[address2].should == nil

    address1 = liner_heap.alloc(MockObject)
    address1.should == 0
  end
end
