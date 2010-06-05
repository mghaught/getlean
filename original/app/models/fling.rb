class Fling < ActiveRecord::Base
  
  belongs_to :flinger, :class_name => "User"
  belongs_to :payload


  after_create :fling_by_email

protected

  def fling_by_email
    FlingMailer.deliver_fling_email(self) 
  end
  
end
