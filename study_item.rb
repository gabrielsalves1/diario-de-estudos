class StudyItem
    def initialize(item)
        @nome = item[:nome]
        @categoria = Category.new(item[:categoria])
    end

    def nome
        @nome
    end

    def categoria
        @categoria.nome
    end
end