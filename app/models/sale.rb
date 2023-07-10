class Sale < ApplicationRecord

  #AR Scope (active record)
  def self.active
    where("sales.starts_on <= ? AND sales.ends_on >= ?",
      Date.current, Date.current)
  end

  def finished?
    
    ends_on != nil && ends_on < Date.current
    
  end

  def upcoming?
    starts_on != nil &&
    starts_on > Date.current
  end

  def active?
    !upcoming? && !finished?
  end

end
