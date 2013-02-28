class Staticpage < ActiveRecord::Base
  attr_accessible :string, :text
  
  before_save :create_content
  
  
  private
  def create_content
      self.description = BlueCloth.new(self.description_markup).to_html unless self.description_markup.blank?
    end
end
