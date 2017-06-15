class Home < ApplicationRecord

belongs_to :user
has_many :comments

has_attached_file :avatar, :styles => {
  :small => "900x900!",
  :medium => "570x570!"
}, default_url: "/images/:style/missing.png"

validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

validates :title, length: { minimum: 4, maximum: 20 ,message: "제목은 최소 4자 - 최대 20자 입니다." }
validates :houseAddress, presence: { message: "주소를 입력해 주십시오." }
validates :detailedAddress, presence: { message: "상세주소를 입력해 주십시오." }
validates :housingDeposit, numericality: { greater_than_or_equal_to: 0, message: "보증금을 0 이상 입력해 주십시오." }
validates :monthlyFee, presence: { greater_than_or_equal_to: 0, message: "월세를 0 이상 입력해 주십시오." }
validates :avatar, presence: { message: "사진을 등록해 주십시오." }


end
