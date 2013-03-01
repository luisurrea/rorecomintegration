class Staticpage < ActiveRecord::Base
  attr_accessible :name, :description
  
  before_save :create_content
  
  
  private
  def create_content
      self.description = BlueCloth.new(self.description).to_html unless self.description.blank?
    end
end
