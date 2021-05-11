#!/bin/sh
#
# This script rewrites watchface_theme_list.json
# with local watch faces and any Github repository
# using my-ttgo-watch-face topic.
#
github_repos()
{
  curl -s -H "Accept: application/vnd.github.v3+json" https://api.github.com/search/repositories?q=topic:my-ttgo-watch-face | \
  jq '[.items[] | {name: .name, url: .html_url, download: (.html_url + "/releases/latest/download/watchface.tar.gz")}]'
}
github_repos | jq --tab -s '.[0] + .[1]' local_watchface_theme_list.json - > watchface_theme_list.json