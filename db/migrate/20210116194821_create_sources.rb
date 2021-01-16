class CreateSources < ActiveRecord::Migration[6.1]
  def change
    create_table :sources do |t|
      t.string :original_url
      t.string :shortened_url

      t.timestamps
    end
  end
end
