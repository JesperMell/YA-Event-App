class Application < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description

      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end

    create_table :event_users do |t|
      t.integer :user_id
      t.integer :event_id

      t.string :description

      t.timestamps
    end

    create_table :comments do |t|
      t.integer :user_id
      t.integer :event_id

      t.string :content

      t.timestamps
    end
  end
end
