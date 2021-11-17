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

    if opcao == 4
        puts "Encerrando aplicação..."
    end

    while opcao != 4
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
            print "Digite uma palavra contida no item a ser procurado: "
            palavra = gets.chomp()

            itens.each_with_index {|item, index|
                if item.nome == palavra || item.categoria == palavra
                    puts "#{index}: Nome: #{item.nome}, Categoria: #{item.categoria}"
                end
            }

            menu(itens)
        else
            puts "Opção inválida, selecione uma opção de 1 à 4"
            
            menu(itens)
        end
    end
end

menu(itens)