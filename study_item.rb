class StudyItem
    def initialize(item)
        @nome = item[:nome]
        @categoria = Category.new(item[:categoria])
        @descricao = item[:descricao]
    end

    def nome
        @nome
    end

    def categoria
        @categoria.nome
    end

    def descricao
        @descricao
    end
end