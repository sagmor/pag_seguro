module PagSeguro
  class Payment < Hashie::Dash
    attr_accessor :client

    property :currency, :required => true, :default => "BRL"
    property :items, :required => true
    property :reference
    property :redirect_url
    property :extra_amount
    property :max_uses
    property :max_age
    # property :sender # Not supported yet
    # property :shipping # Not supported yet

    def initialize(attributes)
      self.item = attributes[:item] if attributes[:item]
      self.items = attributes[:items] if attributes[:items]
      super(attributes.except(:items, :item))
    end

    def items=(items)
      self[:items] = items && items.map{ |i| Item.new(i) }
    end

    def item=(item)
      self.items = [item]
    end

    def to_xml(options={})
      builder = Builder::XmlMarkup.new( )
      builder.instruct! :xml, :encoding => "UTF-8"
      builder.checkout do |checkout|
        checkout.currency currency
        checkout.items do |items|
          self.items.each{ |i| i.to_xml(:builder => items) }
        end
        checkout.reference reference if reference
        checkout.redirectURL redirect_url if redirect_url
        checkout.extraAmount extra_amount if extra_amount
        checkout.maxUses max_uses || 1
        checkout.maxAge max_age if max_age
      end
      builder.shipping do |shipping|
        shipping.type 3
      end
    end

    def code
      if @code.nil?
        response = client.post "checkout", self.to_xml
        @code = response["checkout"]["code"]
      end

      @code
    end
  end
end
