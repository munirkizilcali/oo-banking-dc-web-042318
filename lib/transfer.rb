class Transfer
  # your code here
  attr_reader :sender, :receiver, :amount
  attr_accessor :status
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid? 
    if sender.valid? && receiver.valid?
      true
    else
      false
    end
  end

  def execute_transaction
    if (self.valid? && sender.balance >= self.amount && self.status == "pending")
      sender.balance -= self.amount
      receiver.balance += self.amount
      self.status = "complete"
    elsif !sender.valid? || sender.balance < self.amount
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    else
      self.status = "rejected"
    end
  end

  def reverse_transfer
    if self.status == "complete"
      sender.balance += self.amount
      receiver.balance -= self.amount
      self.status = "reversed"
    end
  end
end
