class CreateBasics < ActiveRecord::Migration[5.1]
  def change
    create_table :basics do |t|
      t.string :age
      t.string :education
      t.string :marriage
      t.string :house
      t.string :job
      t.string :job_title
      t.string :longevity
      t.string :income

      t.timestamps
    end
  end
end
