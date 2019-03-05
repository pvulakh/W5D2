# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub_id     :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
    validates :title, :user_id, presence: true
    #validates_presence_of :subs

    belongs_to :user
    has_many :post_subs 

    has_many :subs, 
        through: :post_subs, 
        source: :sub
end
