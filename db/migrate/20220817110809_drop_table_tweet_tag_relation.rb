class DropTableTweetTagRelation < ActiveRecord::Migration[6.1]
  def change
    drop_table :tweet_tag_relations
  end
end
