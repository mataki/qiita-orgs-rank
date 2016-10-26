class Member < ActiveRecord::Base
  belongs_to :organization

  validates :slug, presence: true

  def qiita_page
    "http://qiita.com/#{self.slug}"
  end
end
