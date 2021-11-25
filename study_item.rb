class StudyItem
    attr_accessor :title, :category, :description, :statusDiary
    def initialize(item)
        @title = item[:title]
        @category = Category.new(item[:category])
        @description = item[:description]
        @statusDiary = false
    end
end