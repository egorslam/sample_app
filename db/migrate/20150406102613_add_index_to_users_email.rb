class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	add_index :users, :email, unique: true #метод add_index для добавления индекса на столбце email таблицы users. Индекс сам по себе не обеспечивает уникальность, но это делает опция unique: true.
  end
end
