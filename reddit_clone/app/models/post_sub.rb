class PostSub < ApplicationRecord
    #validates :sub_id, :post_id, presence: true 

    belongs_to :sub
    belongs_to :post
end 