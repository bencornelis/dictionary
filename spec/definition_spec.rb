require('rspec')
require('definition')

describe(Definition) do
  describe('#part_of_speech') do
    it('returns the part of speech in the definition') do
      test_definition = Definition.new({:part_of_speech => 'verb'})
      expect(test_definition.part_of_speech()).to(eq('verb'))
    end
  end

  describe('#meanings') do
    it('is empty at first') do
      test_definition = Definition.new({:part_of_speech => 'verb'})
      expect(test_definition.meanings()).to(eq([]))
    end
  end

  describe('#add_meaning') do
    it('adds a meaning to the list of meanings') do
      test_definition = Definition.new({:part_of_speech => 'verb'})
      test_definition.add_meaning('walk very quickly')
      expect(test_definition.meanings()).to(eq(['walk very quickly']))
    end
  end
end
