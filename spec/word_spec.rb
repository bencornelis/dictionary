require('rspec')
require('definition')
require('word')

describe(Word) do

  before () do
    Word.clear()
  end

  describe('#word') do
    it('returns the word') do
      test_word = Word.new({:string_form => 'run'})
      expect(test_word.string_form()).to(eq('run'))
    end
  end

  describe('#definitions') do
    it('is empty at first') do
      test_word = Word.new({:string_form => 'run'})
      expect(test_word.definitions()).to(eq([]))
    end
  end

  describe('#add_definition') do
    it('adds a definition to the definition list') do
      test_word = Word.new({:word => 'run'})
      test_definition = Definition.new({:part_of_speech =>'verb'})
      test_word.add_definition(test_definition)
      expect(test_word.definitions()).to(eq([test_definition]))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Word.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('adds a word to the words array') do
      test_word = Word.new({:string_form => 'run'})
      test_word.save()
      expect(Word.all()).to(eq([test_word]))
    end
  end

  describe('.clear') do
    it('emptys the word array') do
      test_word = Word.new({:string_form => 'run'})
      test_word.save()
      Word.clear()
      expect(Word.all()).to(eq([]))
    end
  end

  describe('.find') do
    it('finds a word based on its string form') do
      test_word = Word.new({:string_form => 'run'})
      test_word.save()
      expect(Word.find('run')).to(eq(test_word))
    end

    it('returns nil if the word has not been saved') do
      test_word = Word.new({:string_form => 'fun'})
      expect(Word.find('fun')).to(eq(nil))
    end
  end

  describe('.delete') do
    it('does nothing if the word is not in the array') do
      test_word = Word.new({:string_form => 'run'})
      test_word.save()
      Word.delete('animal')
      expect(Word.all()).to(eq([test_word]))
    end

    it('removes the word with the specified string_form') do
      test_word = Word.new({:string_form => 'run'})
      test_word.save()
      Word.delete('run')
      expect(Word.all()).to(eq([]))
    end
  end

  describe('#find_definition') do
    it('finds a definition by its part of speech') do
      test_word = Word.new({:word => 'run'})
      test_definition = Definition.new({:part_of_speech =>'verb'})
      test_word.add_definition(test_definition)
      expect(test_word.find_definition('verb')).to(eq(test_definition))
    end
  end
end
