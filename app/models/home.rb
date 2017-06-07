class Home < ApplicationRecord

belongs_to :user

has_attached_file :avatar, :styles => {
  :small => "900x900!",
  :medium => "570x570!"
}, default_url: "/images/:style/missing.png"

validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

validates :title, presence: { message: "제목을 입력해 주십시오." }
validates :houseAddress, presence: { message: "주소를 입력해 주십시오." }
validates :housingDeposit, presence: { message: "보증금을 입력해 주십시오." }
validates :monthlyFee, presence: { message: "월세를 입력해 주십시오." }
validates :avatar, presence: { message: "사진을 등록해 주십시오." }


end
