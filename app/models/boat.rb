class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  @my_table = Boat.arel_table

  def self.first_five
    limit(5)
  end

  def self.dinghy
    Boat.where(@my_table[:length].lt(20))
  end

  def self.ship
    Boat.where(@my_table[:length].gt(20))
  end

  def self.last_three_alphabetically
    order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain: nil)
  end

  def self.sailboats
    includes(:classifications).where(classifications: {name: 'Sailboat'})
  end

  def self.with_three_classifications
    joins(:boat_classifications).group(:name).having('count(name) = 3')
  end


end
