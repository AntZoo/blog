docpad generate --env static
chmod -R og+Xr out
rsync -rvzpe 'ssh -p 22 -i /cygdrive/c/Users/azujev/.ssh/id_rsa' --size-only --delete --exclude-from=".deployignore" "out/" "blogger@do.thezujev.com:/var/www/blog"
