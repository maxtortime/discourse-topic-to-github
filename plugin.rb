# name: basic-plugin
# about: A super simple plugin to demonstrate how plugins work
# version: 0.0.1
# authors: Taehwan Kim

after_initialize do
  DiscourseEvent.on(:post_created) do |post_ids|
    post_id = post_ids[:id]
    post = Post.find_by({id: post_id})

=begin
TODO:
# is_first_post == true
1. post이므로 곧바로 issue를 create 한다.
2. post가 만들어지고 issue가 create 될때 topic_id를 key로 하고 issue number를
value로 해서 가지고 있는다.
3. https://developer.github.com/v3/issues/#create-an-issue
보내야할 json 형식
{
  "title": post.title
  "body": post.raw # 어떻게 될지 모르겠지만 일단 raw를 보내보자
}
4. 보내고 난 후 response로 날아오는 number를 잘 챙겨서 2번을 수행한다

# is_first_post == false
1. reply이므로 위에 2번에서 만든 dict 에서 topic_id 를 이용해 issue number를 찾는다
2. https://developer.github.com/v3/issues/comments/#create-a-comment
3. 해당 issue number 에 아래 json 형식대로 전송한다
{
  "body": post.raw
}
=end

    topic = post.topic

    puts "maxtortime #{topic.title}"
    puts "maxtortime #{post.is_first_post?}, #{post.topic_id}"
    puts "maxtortime #{post_id}: #{post.raw}"

  end
end
