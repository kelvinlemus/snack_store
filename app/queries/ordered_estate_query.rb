class OrderedEstateQuery
  SORT_OPTIONS = %w(by_likes_count by_name)

  module Scopes
    def by_name(direction)
      order(name: direction)
    end

    def by_likes_count(direction)
      order(likes_count: direction)
    end
  end

  def initialize(relation=Product.all, params={})
    @relation = relation.extending(Scopes)
    @params = params
  end

  def all
    @relation = @relation.public_send(sort_by, direction)

    if @params[:name_cont].present?
     @relation = @relation.where("name ILIKE ?", "%#{@params[:name_cont]}%")
    end
    @relation
  end

private
  def sort_by
    @params[:sort].presence_in(SORT_OPTIONS) || :by_name
  end

  def direction
    @params[:direction] == "asc" ? :asc : :desc
  end
end