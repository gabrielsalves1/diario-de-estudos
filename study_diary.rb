require_relative "study_item.rb"
require_relative "category.rb"

require 'sqlite3'

itens = []

class StudyDiary
    def cadastraItem(titulo, categoria, descricao, itens)
        item = StudyItem.new({titulo: titulo, categoria: categoria, descricao: descricao})
        itens.append(item)

        db = SQLite3::Database.open "db/database.db"
        db.execute "INSERT INTO Diario (TITULO, CATEGORIA, DESCRICAO) VALUES ( '#{item.titulo}', '#{item.categoria}', '#{item.descricao}' );"
        db.close()
        
        puts "\nItem cadastrado com sucesso!"

    end

    def menu(itens)
        puts "\n[1] Cadastrar um item para estudar"
        puts "[2] Ver todos os itens cadastrados"
        puts "[3] Buscar um item de estudo"
        puts "[4] Sair"
    
        print "\nEscolha uma opção: "
        opcao = gets.chomp().to_i

        while true
            if opcao == 1
                print "Digite o título do item: "
                tituloItem = gets.chomp()
                print "Digite a categoria do item: "
                categoriaItem = gets.chomp()
                print "Insira uma descrição para o item: "
                descricaoItem = gets.chomp()

                cadastraItem(tituloItem, categoriaItem, descricaoItem, itens)
                menu(itens)
            elsif opcao == 2
                itens.each_with_index {|item, index|
                    puts "#{index}: Título: #{item.titulo}, Categoria: #{item.categoria}, Descrição: #{item.descricao}"
                }

                menu(itens)
            elsif opcao == 3
                print "Deseja listar itens por categoria? (S/N) "
                buscarPorCategoria = gets.chomp().downcase

                while buscarPorCategoria != "n" && buscarPorCategoria != "s"
                    puts "Resposta inválida, utilizar S ou N"

                    print "Deseja buscar por categoria? (S/N) "
                    buscarPorCategoria = gets.chomp().downcase
                end

                print "Digite uma palavra contida no item a ser procurado: "
                palavra = gets.chomp()

                if buscarPorCategoria == "n"
                    itens.each_with_index {|item, index|
                        if item.descricao.include? palavra || item.titulo == palavra
                            puts "\n#{index}: Título: #{item.titulo}, Categoria: #{item.categoria}, Descrição: #{item.descricao}"
                        end
                    }
                elsif buscarPorCategoria == "s"
                    itens.each_with_index {|item, index|
                        if item.categoria == palavra
                            puts "\n#{index}: Título: #{item.titulo}, Categoria: #{item.categoria}, Descrição: #{item.descricao}"
                        end
                    }
                end

                menu(itens)
            elsif opcao == 4
                puts "Encerrando aplicação..."
            else
                puts "Opção inválida, selecione uma opção de 1 à 4"

                menu(itens)
            end
            break
        end
    end

end

studyDiary = StudyDiary.new()
studyDiary.menu(itens)