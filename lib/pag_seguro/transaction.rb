module PagSeguro
  class Transaction < Hashie::Mash
    module STATUS
      PENDING     = "1"
      ON_ANALYSIS = "2"
      PAYED       = "3" 
      AVAILABLE   = "4"
      DISPUTED    = "5"
      REFUNDED    = "6"
      CANCELED    = "7"
    end
    
    def success?
      self.status == STATUS::PAYED || self.status == STATUS::AVAILABLE
    end

    def pending?
      self.status == STATUS::PENDING || self.status == STATUS::ON_ANALYSIS
    end

    def failed?
      self.status == STATUS::CANCELED || self.status == STATUS::REFUNDED
    end
  end
end
