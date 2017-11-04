class CreateVoltronDefenderErrors < ActiveRecord::Migration
  def change
    create_table :voltron_defender_errors do |t|
      t.string :status
      t.string :error
      t.string :file
      t.string :line
      t.text :trace
      t.text :headers

      t.timestamps null: false
    end
  end
end
