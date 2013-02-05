module PagSeguro
  class Item < Hashie::Dash
    property :id, :required => true
    property :description, :required => true
    property :amount, :required => true
    property :quantity, :required => true, :default => 1
    property :redirect_url
    property :shipping_cost
    property :weight

    def to_xml(options = {})
      builder = options[:builder] || Builder::XmlMarkup.new()
      builder.item do |item|
        item.id id
        item.description description
        item.amount ("%.2f" % amount)
        item.quantity quantity
        item.shippingCost shipping_cost if shipping_cost
        item.weight weight if weight
        item.redirectURL redirect_url if redirect_url
      end
    end
  end
end
