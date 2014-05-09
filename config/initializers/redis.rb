$redis = Redis.new()
$redis = Redis::Namespace.new("atomic_digester-#{Rails.env}", redis: $redis)
