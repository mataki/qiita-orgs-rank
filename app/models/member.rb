class Member < ActiveRecord::Base
  belongs_to :organization

  def qiita_page
    "http://qiita.com/#{self.slug}"
  end
end
