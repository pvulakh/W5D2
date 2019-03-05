# == Schema Information
#
# Table name: subs
#
#  id           :bigint(8)        not null, primary key
#  title        :string           not null
#  description  :text             not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ApplicationRecord
    validates :title, :description, :moderator_id, presence: true
    belongs_to :moderator,
        class_name: :User,
        primary_key: :id,
        foreign_key: :moderator_id
    
    has_many :post_subs
    has_many :posts,
        through: :post_subs,
        source: :post
end
