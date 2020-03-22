class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :token_hash
      t.string :customer_name

      t.timestamps
    end
  end
end
