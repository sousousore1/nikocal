class Term
  attr_reader :from
  attr_reader :now
  attr_reader :to

  def initialize(from, to)
    @from = from
    @now = Time.now
    @to = to
  end

  def within_the_priod
    @from <= Time.now && Time.now <= @to
  end
end
