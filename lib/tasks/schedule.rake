desc '更新処理'
task fetch: :environment do
  Organization.fetch
end
