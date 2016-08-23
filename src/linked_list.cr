class LinkedList(A)
  include Enumerable(A)

  def initialize
    @head = Node(A).new
    @tail = @head
  end

  def initialize(*values)
    @head = Node(A).new
    @tail = @head
    values.each do |value|
      append(value)
    end
  end

  def append(value : A)
    new_node = Node(A).new(value)
    @tail.next = new_node
    @tail = new_node
  end

  def push(value : A)
    append(value)
  end

  def <<(value : A)
    append(value)
  end

  def unshift(value : A)
    new_top = Node(A).new(value)
    new_top.next = @head.next
    @head.next = new_top
  end

  def shift
    return if @head.next.nil?

    first = @head.next.not_nil!
    @head.next = first.next
    first.value
  end

  def peek
    @tail.value
  end

  def pop
    return nil if @head == @tail

    last = @tail
    current = @head
    while current.next != last
      current = current.next.not_nil!
    end

    current.next = nil
    @tail = current
    last.value
  end

  def each(&block)
    current = @head
    while !current.next.nil?
      current = current.next.not_nil!
      yield current.value
    end
  end

  def +(list : LinkedList)
    unless list.empty?
      @tail.next = list.head.next
      @tail = list.tail
    end
    self
  end

  def empty?
    @head == @tail
  end

  protected def head
    @head
  end

  protected def tail
    @tail
  end

  class Node(T)
    @next = nil

    def initialize(@value : (T | Nil) = nil)
    end

    def value
      @value
    end

    def next
      @next
    end

    def next=(next_node : Node(T) | Nil)
      @next = next_node
    end
  end
end