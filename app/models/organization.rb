class Organization < ActiveRecord::Base
  has_many :members

  validates :slug, :name, presence: true

  class << self
    def fetch
      organizations = fetch_organizations
      organizations.each(&:fetch).each(&:fetch_members)
    end

    def fetch_organizations
      index_page = Mechanize.new.get('http://qiita.com/organizations')
      index_page.search('.organization-list h2 a').map do |a|
        Organization.find_or_create_by!(slug: a.attributes["href"].value.match(/\/organizations\/(.*)/)[1], name: a.text)
      end
    end
  end

  def qiita_page
    "http://qiita.com/organizations/#{self.slug}"
  end

  def fetch
    org_page = Mechanize.new.get(qiita_page)
    self.post_count = org_page.search('.organization-stats li:nth-child(1) .count').text.to_i
    self.stock_count = org_page.search('.organization-stats li:nth-child(2) .count').text.to_i
    self.save!
  end

  def fetch_members
    member_page = Mechanize.new.get("http://qiita.com/organizations/#{self.slug}/members")
    member_page.search('.organization-members-list .row').map do |mdom|
      a = mdom.search("h3 a")
      member = self.members.find_or_initialize_by(slug: a.text)
      member.post_count, member.stock_count = mdom.search('p').text.scan(/\d+/)
      member.save!
      member
    end
  end
end
