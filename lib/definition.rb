class Definition
  attr_reader(:part_of_speech, :meanings)

  define_method(:initialize) do |attributes|
    @part_of_speech = attributes[:part_of_speech]
    @meanings = []
  end

  define_method(:add_meaning) do |meaning|
    @meanings.push(meaning)
  end

end
