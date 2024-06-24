class Filter
  attr_reader :params, :model

  def initialize(params, model)
    @params = params
    @model = model
  end

  def apply(records = nil)
    records = records || model.where(nil)
    records = records.where('average_price > ?', params[:greater]) if params[:greater].present?
    records = records.where('average_price < ?', params[:lower]) if params[:lower].present?

    records
  end
end
