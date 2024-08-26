module DomainExceptions
  class ProductDeletionError < StandardError
    def initialize(msg = "Cannot delete product as it's referenced by cart items")
      super
    end
  end
  # Add other custom exceptions here as needed
end