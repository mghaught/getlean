class User < ActiveRecord::Base
  devise :registerable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  named_scope :veteran, lambda { {:conditions => ["sign_in_count > 3 AND created_at < ?", 1.week.ago]} }
  named_scope :active, lambda { {:conditions => ["current_sign_in_at > ?", 1.week.ago]} }
  named_scope :starts, lambda { {:conditions => ["created_at > ?", 3.days.ago]} }
  named_scope :pro, :conditions => ["pro = ?", true]
  
  has_many :flings, :foreign_key => "flinger_id"

  validates_presence_of :name, :message => "cannot go nameless"
end
