require_relative "study_item.rb"
require_relative "category.rb"

itens = []

def cadastraItem(nome, categoria, itens)
    item = StudyItem.new({nome: nome, categoria: categoria})
    puts "\nItem cadastrado com sucesso! \nNome: #{item.nome}\nCategoria: #{item.categoria}"

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
            nomeItem = gets.chomp
            print "Digite a categoria do item: "
            categoriaItem = gets.chomp

            cadastraItem(nomeItem, categoriaItem, itens)
            menu(itens)
        elsif opcao == 2
            itens.each_with_index {|item, index|
                puts "#{index}: Nome: #{item.nome}, Categoria: #{item.categoria}"
            }

            menu(itens)
        elsif opcao == 3
            print "Deseja buscar por categoria? (S/N) "
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
                    if item.nome == palavra || item.categoria == palavra
                        puts "\n#{index}: Nome: #{item.nome}, Categoria: #{item.categoria}"
                    end
                }
            elsif buscarPorCategoria == "s"
                itens.each_with_index {|item, index|
                    if item.categoria == palavra
                        puts "\n#{index}: Nome: #{item.nome}, Categoria: #{item.categoria}"
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