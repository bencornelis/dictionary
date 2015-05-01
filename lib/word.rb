class Word
  @@words = []
  attr_reader(:string_form, :definitions)

  define_method(:initialize) do |attributes|
    @string_form = attributes[:string_form]
    @definitions = []
  end

  define_method(:add_definition) do |definition|
    @definitions.push(definition)
  end

  define_method(:save) do
    @@words.push(self)
  end

  define_method(:find_definition) do |part_of_speech|
    @definitions.each do |definition|
      if definition.part_of_speech() == part_of_speech
        return definition
      end
    end
  end

  define_singleton_method(:all) do
    @@words
  end

  define_singleton_method(:clear) do
    @@words = []
  end

  define_singleton_method(:find) do |word_string|
    @@words.each() do |word|
      if word.string_form() == word_string
        return word
      end
    end
    nil
  end

  define_singleton_method(:delete) do |remove_word|
    @@words.select! {|word| word.string_form() != remove_word}
  end

end
