require_relative "study_item.rb"
require_relative "category.rb"

require 'sqlite3'
require 'io/console'

class StudyDiary
    NEWITEM = 1
    SEARCHALLITEMS = 2
    SEARCHITEM = 3
    EXIT = 4
    DELETE = 5
    FINISHEDITEMS = 6
    FINISHITEM = 7

    def wait_keypress
        puts 'Pressione qualquer tecla para continuar.'
        STDIN.getch
    end

    def register_item(title, category, description)
        item = StudyItem.new({title: title, category: category, description: description})

        db = SQLite3::Database.open "db/database.db"
        db.execute "INSERT INTO Diary (TITLE, CATEGORY, DESCRIPTIONDIARY, STATUSDIARY) VALUES ( '#{item.title}', '#{item.category.category}', '#{item.description}', '#{item.statusDiary}');"
        db.close()
        
        puts "\nItem cadastrado com sucesso!"
    end

    def search_all_items
        db = SQLite3::Database.open "db/database.db"
        db.results_as_hash = true
        itens = db.execute "SELECT ID, TITLE, CATEGORY, DESCRIPTIONDIARY, STATUSDIARY FROM Diary"
        db.close
    
        itens.map {|item|
            puts "Id: #{item['ID']} - Título: #{item['TITLE']}, Categoria: #{item['CATEGORY']}, Descrição: #{item['DESCRIPTIONDIARY']}, Status: #{item['STATUSDIARY']}"
        }
    end

    def search_by_category_N(word)
        db = SQLite3::Database.open "db/database.db"
        db.results_as_hash = true
        items = db.execute "SELECT ID, TITLE, CATEGORY, DESCRIPTIONDIARY, STATUSDIARY FROM Diary WHERE TITLE = '#{word}' OR DESCRIPTIONDIARY LIKE '%#{word}%' AND STATUSDIARY <> 'true'"
        db.close
        
        items.map {|item|
            puts "Id: #{item['ID']} - Título: #{item['TITLE']}, Categoria: #{item['CATEGORY']}, Descrição: #{item['DESCRIPTIONDIARY']}, Status: #{item['STATUSDIARY']}"
        }
    end
    
    def search_by_category_S(word)
        db = SQLite3::Database.open "db/database.db"
        db.results_as_hash = true
        items = db.execute "SELECT ID, TITLE, CATEGORY, DESCRIPTIONDIARY, STATUSDIARY FROM Diary WHERE CATEGORY = '#{word}' AND STATUSDIARY <> 'true'"
        db.close
        
        items.map {|item|
            puts "Id: #{item['ID']} - Título: #{item['TITLE']}, Categoria: #{item['CATEGORY']}, Descrição: #{item['DESCRIPTIONDIARY']}, Status: #{item['STATUSDIARY']}"
        }
    end

    def delete_item_by_id(idItem)
        db = SQLite3::Database.open "db/database.db"
        db.execute "DELETE FROM Diary WHERE ID = #{idItem}"
        db.close

    end

    def search_by_finished_items
        db = SQLite3::Database.open "db/database.db"
        db.results_as_hash = true
        items = db.execute "SELECT ID, TITLE, CATEGORY, DESCRIPTIONDIARY, STATUSDIARY FROM Diary WHERE STATUSDIARY = 'true'"
        db.close
        
        items.map {|item|
            puts "Id: #{item['ID']} - Título: #{item['TITLE']}, Categoria: #{item['CATEGORY']}, Descrição: #{item['DESCRIPTIONDIARY']}, Status: #{item['STATUSDIARY']}"
        }

    end

    def finish_item(idItem)
        db = SQLite3::Database.open "db/database.db"
        db.execute "UPDATE Diary SET STATUSDIARY = 'true' WHERE ID = #{idItem}"
        db.close
    end

    def menu()
        puts <<~MENU
        \n
        [#{NEWITEM}] Cadastrar um item para estudar
        [#{SEARCHALLITEMS}] Ver todos os itens cadastrados
        [#{SEARCHITEM}] Buscar um item de estudo
        [#{EXIT}] Sair
        [#{DELETE}] Deletar item cadastrado
        [#{FINISHEDITEMS}] Listar itens concluídos
        [#{FINISHITEM}] Finalizar item de estudo
        MENU
    
        print "\nEscolha uma opção: "
        option = gets.chomp().to_i

        loop do
            case option
            when NEWITEM
                print "Digite o título do item: "
                title = gets.chomp()
                print "Digite a categoria do item: "
                category = gets.chomp()
                print "Insira uma descrição para o item: "
                description = gets.chomp()

                register_item(title, category, description)
                menu()
            when SEARCHALLITEMS
                search_all_items()
                wait_keypress()
                menu()
            when SEARCHITEM
                print "Deseja listar itens por categoria? (S/N) "
                searchByCategory = gets.chomp().downcase

                while searchByCategory != "n" && searchByCategory != "s"
                    puts "Resposta inválida, utilizar S ou N"

                    print "Deseja buscar por categoria? (S/N) "
                    searchByCategory = gets.chomp().downcase
                end

                print "Digite uma palavra contida no item a ser procurado: "
                word = gets.chomp()

                if searchByCategory == "n"
                    search_by_category_N(word)
                elsif searchByCategory == "s"
                    search_by_category_S(word)
                end

                wait_keypress()
                menu()
            when EXIT
                puts "Encerrando aplicação..."
            when DELETE
                print "Digite o Id do item que deverá ser excluído: "
                idItem = gets.chomp()

                delete_item_by_id(idItem)
                menu()
            when FINISHEDITEMS
                search_by_finished_items()
                wait_keypress()
                menu()
            when FINISHITEM
                print "Digite o Id do item que deverá ser finalizado:  "
                idItem = gets.chomp()

                finish_item(idItem)
                menu()
            else
                puts "Opção inválida, selecione uma opção de 1 à 7"

                menu()
            end
            break
        end
    end

end

studyDiary = StudyDiary.new()
studyDiary.menu()