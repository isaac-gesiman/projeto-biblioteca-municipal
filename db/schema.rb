# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_08_18_144958) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bibliotecarios", force: :cascade do |t|
    t.string "cpf", null: false
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "nome", null: false
    t.string "password_digest", null: false
    t.boolean "primeiro_acesso", default: true, null: false
    t.string "telefone", null: false
    t.datetime "updated_at", null: false
    t.index ["cpf"], name: "index_bibliotecarios_on_cpf", unique: true
    t.index ["email"], name: "index_bibliotecarios_on_email", unique: true
  end

  create_table "categorias", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "nome", null: false
    t.datetime "updated_at", null: false
    t.index ["nome"], name: "index_categorias_on_nome", unique: true
  end

  create_table "emprestimos", force: :cascade do |t|
    t.bigint "bibliotecario_id", null: false
    t.datetime "created_at", null: false
    t.date "data_devolucao"
    t.datetime "data_emprestimo", null: false
    t.date "data_prevista_devolucao", null: false
    t.bigint "livro_id", null: false
    t.string "status", default: "ativo", null: false
    t.datetime "updated_at", null: false
    t.bigint "usuario_id", null: false
    t.index ["bibliotecario_id"], name: "index_emprestimos_on_bibliotecario_id"
    t.index ["livro_id"], name: "index_emprestimos_livro_em_aberto", unique: true, where: "(data_devolucao IS NULL)"
    t.index ["livro_id"], name: "index_emprestimos_on_livro_id"
    t.index ["usuario_id"], name: "index_emprestimos_on_usuario_id"
  end

  create_table "livros", force: :cascade do |t|
    t.string "autor", null: false
    t.bigint "categoria_id", null: false
    t.datetime "created_at", null: false
    t.boolean "disponivel", default: true, null: false
    t.integer "idade_minima", default: 0, null: false
    t.text "observacoes"
    t.string "titulo", null: false
    t.datetime "updated_at", null: false
    t.index ["categoria_id"], name: "index_livros_on_categoria_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "cpf", null: false
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.integer "idade", null: false
    t.string "nome", null: false
    t.string "password_digest"
    t.boolean "primeiro_acesso", default: true, null: false
    t.string "senha_emprestimo_digest", null: false
    t.string "telefone", null: false
    t.datetime "updated_at", null: false
    t.index ["cpf"], name: "index_usuarios_on_cpf", unique: true
    t.index ["email"], name: "index_usuarios_on_email", unique: true
  end

  add_foreign_key "emprestimos", "bibliotecarios"
  add_foreign_key "emprestimos", "livros"
  add_foreign_key "emprestimos", "usuarios"
  add_foreign_key "livros", "categorias"
end
