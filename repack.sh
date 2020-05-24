TARGET=`ls -1 *.gem`

tar xf $TARGET

gzip -d -c metadata.gz  | \
  grep -v  'github_repo' | \
  sed "s!allowed_push_host.*!allowed_push_host: https://rubygems.pkg.github.com!"  | \
  sed "s!metadata:.*!metadata:\n  github_repo: ssh://github.com/$GITHUB_REPOSITORY!" | \
  gzip -c > metadata.gz.new
mv -f metadata.gz.new metadata.gz

text="---
SHA256:
  metadata.gz: $(sha256sum metadata.gz | cut -f 1 -d ' ')
  data.tar.gz: $(sha256sum data.tar.gz | cut -f 1 -d ' ')
SHA512:
  metadata.gz: $(sha512sum metadata.gz | cut -f 1 -d ' ')
  data.tar.gz: $(sha512sum data.tar.gz | cut -f 1 -d ' ')"

echo "$text" | gzip -c > checksums.yaml.gz.new
mv -f checksums.yaml.gz.new checksums.yaml.gz

chmod 0444 metadata.gz data.tar.gz checksums.yaml.gz
tar cf $TARGET metadata.gz data.tar.gz checksums.yaml.gz