mkdir -p ~/.gem
echo ":github: Bearer $GITHUB_TOKEN" > ~/.gem/credentials
chmod 0600 ~/.gem/credentials

output=`gem push --k github --host "https://rubygems.pkg.github.com/$GITHUB_REPOSITORY_OWNER" *.gem`

if [ $? -eq 0 ] || [ `echo $output | grep -c 'already been pushed'` -eq 1 ]; then
  echo $output
  exit 0
else
  echo $output
  exit 1
fi
