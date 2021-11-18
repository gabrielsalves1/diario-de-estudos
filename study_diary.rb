require_relative "study_item.rb"
require_relative "category.rb"

itens = []

def cadastraItem(nome, categoria, descricao, itens)
    item = StudyItem.new({nome: nome, categoria: categoria, descricao: descricao})
    puts "\nItem cadastrado com sucesso!"
    puts "Nome: #{item.nome}, Categoria: #{item.categoria}, Descrição: #{item.descricao}"

    itens.append(item)
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
            print "Digite o nome do item: "
            nomeItem = gets.chomp()
            print "Digite a categoria do item: "
            categoriaItem = gets.chomp()
            print "Insira uma descrição para o item: "
            descricaoItem = gets.chomp()

            cadastraItem(nomeItem, categoriaItem, descricaoItem, itens)
            menu(itens)
        elsif opcao == 2
            itens.each_with_index {|item, index|
                puts "#{index}: Nome: #{item.nome}, Categoria: #{item.categoria}, Descrição: #{item.descricao}"
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
                    if item.descricao.include? palavra || item.nome == palavra
                        puts "\n#{index}: Nome: #{item.nome}, Categoria: #{item.categoria}, Descrição: #{item.descricao}"
                    end
                }
            elsif buscarPorCategoria == "s"
                itens.each_with_index {|item, index|
                    if item.categoria == palavra
                        puts "\n#{index}: Nome: #{item.nome}, Categoria: #{item.categoria}, Descrição: #{item.descricao}"
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

menu(itens)