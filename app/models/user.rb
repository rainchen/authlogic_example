class User < ActiveRecord::Base
  acts_as_authentic
  
  has_attached_file :avatar,
                            :styles => { :original => ["48x48>", :jpg]},
                            :url  => "/:attachment/:class/:id_partition.:extension",
                            :path => ":rails_root/public/:attachment/:class/:id_partition.:extension",
                            :default_url => '/images/rails.png'
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/gif', 'image/png', 'text/plain'], :if => lambda{|instance| !instance.avatar.original_filename.blank? } # text/plain is for png files
  validates_attachment_size :avatar, :less_than => 1.megabytes, :if => lambda{|instance| !instance.avatar.original_filename.blank? }
  attr_protected :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at

end
