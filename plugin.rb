# name: discourse-topic-to-github
# about: This discourse plugin can copy topic and reply to GitHub issues
# version: 0.0.1
# authors: Taehwan Kim

require 'octokit'

enabled_site_setting :topic_transfer_enabled

file_name = "./topic_by_issue.json"

after_initialize do
  if File.exists?(file_name)
    file = File.read(file_name, "r")
    topic_by_issue = JSON.parse(file.read)
  else
    topic_by_issue = Hash.new
  end

  DiscourseEvent.on(:post_created) do |post_ids|
    post_id = post_ids[:id]
    post = Post.find_by({id: post_id})
    topic = post.topic
    access_token = SiteSetting.github_access_token
    repo_name = SiteSetting.github_repo_name

    if SiteSetting.github_enterprise_enabled
      Octokit.configure do |c|
        c.api_endpoint = "#{SiteSetting.github_enterprise_hostname}/api/v3/"
      end
    end

    client = Octokit::Client.new(:access_token => access_token)

    if post.is_first_post?
      issue = client.create_issue(repo_name, title=topic.title, body=post.raw)
      topic_by_issue[post.topic_id] = issue[:number]
    else
      issue_num = topic_by_issue[post.topic_id]
      client.add_comment(repo_name, number=issue_num, comment=post.raw)
    end

    File.open(file_name, "w") do |f|
      f.write(topic_by_issue.to_json)
    end
  end
end
