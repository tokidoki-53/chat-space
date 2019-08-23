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
                  keys: ['ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDRohfToSaJ8yQOMe7d3EsNKe7UHvCSdqnNUtYfrEdTrcty/3accgWWsFktS8ip52cBRFiFPNLhmy4yhEI27b4XYw0aVGMB07qDu+wQ3mpakZzYnx1PUBCu/tKn63oZdW8H9NY9t/RaKmo9KypMoZzYfCSRLMsrpkvcQs0E8vW9hqqIa4fz698PhVALiX+AgoITbuOHLoKIwBwBeBUORtmwwimHd8J6rF0CC4+OxArLh5gmlbVBO8o4n/gmtTZsMhxDqKrpjoRpnQlBVHLv7y6QOj2PzVM1yoXkT/XK17/huPl2BNkTRRp1nxetmlNEQLBtac4eokGdzN19fDw0WC1Jh6HlsnmRK++DNrRTlyCXdxVOxEmF+poRnsaLVmGf5i7fpSxOMJwPzpxWdTpjcn389eIGaasxrNes9UNRAOqpC4Yl3srAEyVLPHl9uBewRE3L9JLLHbS4AeAYbozdZoqSFk3GdVERA8MkkxB3NtY3RT3oVuItr72XjnkvSaV5AzXuqH6Ck3qTw4ZEsJ6GdrAZ/qfK+VUyW+dAqYEi/6elzG+X5TCd/6dvOLVcOaVWigYvgG6KBStPt7Y4NtAUg4wwz7ePUnm/0lJCoGURiNInKqK34WhfhX15b+I4XdheJEMbWCoJ2OpkjO5lnxiIz74tLAOagho3a8iekA69fHLFlQ== ec2-user@ip-172-31-45-238']
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