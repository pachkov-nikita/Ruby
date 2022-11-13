class Abstraction
  def initialize(shop)
    @shop = shop
  end

  def operation
    "Abstraction \n#{@shop.operation_implementation}"
  end
end

class MyPet < Abstraction
  def operation
    "MyPet \n#{@shop.operation_implementation}"
  end
end

class PetShop
  def operation_implementation
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class PetShopA < PetShop
  def operation_implementation
    "PetShopA: the result\n"
  end
end

class PetShopB < PetShop
  def operation_implementation
    "PetShopB: the result"
  end
end

def client_code(abstraction)
  print abstraction.operation
end

shop1 = PetShopA.new
shop2 = PetShopB.new

pet1 = Abstraction.new(shop1)
pet2 = MyPet.new(shop2)

client_code(pet1)
client_code(pet2)
