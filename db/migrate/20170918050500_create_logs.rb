class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.date :dia
      t.time :hora
      t.string :contexto
      t.integer :tipo
      t.text :mensagem

      t.timestamps
    end
  end
end
