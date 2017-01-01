# discourse-topic-to-github

This plugin can transfer discourse post and reply to 
Github issue. When you write topic or reply, this plugin
sends your post to GitHub repository automatically.
But now it cannot detect modifying posts.

## Installing
1. **SHOULD READ THIS ARTICLE** https://meta.discourse.org/t/install-a-plugin/19157
2. This plugin uses [octokit](https://github.com/octokit/octokit.rb). 
Add this `gem "octokit", "~> 4.0"` line to `Gemfile` at discourse root directory.
3. Run `bundle install` at terminal.

## LICENSE
MIT

