# config valid for current version and patch releases of Capistrano
# config valid only for current version of Capistrano
# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
lock '~> 3.11.0'

# Capistranoのログの表示に利用する
set :application, 'chat-space'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:tokidoki-53/chat-space.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1' #カリキュラム通りに進めた場合、2.5.1か2.3.1です

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['AAAAB3NzaC1yc2EAAAADAQABAAACAQC6tqfUGQLyZ+FzimMK/JsjbL0qUZ8NghJyNISQUhSE+gr+nYnYMYu38f6Ntv9abB8lwL/dwId4rA7zHoerMmCLaBpL48CCgs9Qrvawksrk61LljrDCZeVBtiNA70M7kdYd8D9aWNzpapORjmwnTF4aM5j7JTYZlGXlvC+/yf4IbpSjr9Qw3lDuk7wIhb1dNURbUzFsvzSy+EUTTO4XQF/bVeCVeK0TNR1+JmOCphmr4vVPiyUwtCq5DoWT3EoNjKkuKz3xgA0dnWW2R2u4JIZ7Qlh7U3Dh5zEAAFj8U/GG0PGamieDvlvHD0GP/4HV1MdsGg2Wa3Q5abj7wY/XKYssZHpJq32fTACVZnZP5PnpyQlbOusjP2Ouia6UWRdEoRAWhQFHmbmsX+E+OjQy1ZhBxcGlIE7OnhL4JU5lX7D8y/s0D5Z+QLN3QuK2lEzG9fUnJHoS4kFn6lurV7ost/mGSrPiftmOuNseF0eSiiGaIZ4NOc6ImojBxc8lRaJstx3TYgZhyL1vqg75zhUiaL9WhqdLcmyPqL7fG2vkjvmX+8B5IM582Ir1sTb6IHT7xbHtts2anjCAKJEA9aKPzrcCabl8vg+wl9SzFjrYtKpupp1xMsocCQDEus2a7BXy3nSn8FqdkozzjjK21XHH0s2XH1rt519IgalEhPWEAFc88w']
                  # ※例：~/.ssh/key_pem.pem

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end