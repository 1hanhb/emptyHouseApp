class Home < ApplicationRecord


has_attached_file :avatar, :styles => {
  :small => "900x900!",
  :medium => "570x570!"
}, default_url: "/images/:style/missing.png"

validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/



end
