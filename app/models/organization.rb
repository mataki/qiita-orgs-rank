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
      index_page.search('.organizationsList_orgName a').map do |a|
        Organization.find_or_create_by!(slug: a.attributes["href"].value.match(/\/organizations\/(.*)/)[1], name: a.text)
      end
    end
  end

  def qiita_page
    "http://qiita.com/organizations/#{self.slug}"
  end

  def fetch
    org_page = Mechanize.new.get(qiita_page)
    self.post_count = org_page.search('.organizationHeader_stats .organizationHeader_stats_container:nth-child(1) .organizationHeader_stats_value').text.to_i
    self.stock_count = org_page.search('.organizationHeader_stats .organizationHeader_stats_container:nth-child(2) .organizationHeader_stats_value').text.to_i
    self.save!
  rescue => e
    logger.info "[Error] fetch: #{self.id}"
  end

  def fetch_members
    member_page = Mechanize.new.get("http://qiita.com/organizations/#{self.slug}/members")
    member_page.search('.organizationMemberList_item').map do |mdom|
      a = mdom.search(".organizationMemberList_memberProfile a")
      member = self.members.find_or_initialize_by(slug: a.text)
      member.post_count, member.stock_count = mdom.search('.organizationMemberList_memberStats').map{|d| d.text.scan(/\d+/).first }
      member.save!
      member
    end
  rescue => e
    logger.info "[Error] fetch_members: #{self.id} #{e}"
  end
end
