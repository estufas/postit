class AddVoteableToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :voteable_id, :integer
  end
end
