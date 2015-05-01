require('sinatra')
require('sinatra/reloader')
require('./lib/definition')
require('./lib/word')
also_reload('lib/**/*.rb')

get('/') do
  @words = Word.all()
  erb(:index)
end

get('/removeword/:string_form') do
  Word.delete(params.fetch('string_form'))
  @words = Word.all()
  erb(:index)
end

post('/success') do
  @word = Word.new({:string_form => params.fetch('word')})
  @new_word = Word.find(@word.string_form()) == nil
  if @new_word
    @word.save()
  end
  erb(:success)
end

get('/words/new') do
  erb(:word_form)
end

get('/words/:string_form') do
  @word = Word.find(params.fetch('string_form'))
  @edit = false
  erb(:word)
end

post('/words/:string_form') do

  @edit = false
  part_of_speech = params.fetch('part_of_speech')
  meaning = params.fetch('meaning')
  new_definition = Definition.new({:part_of_speech => part_of_speech})
  new_definition.add_meaning(meaning)
  @word = Word.find(params.fetch('string_form'))
  @word.add_definition(new_definition)
  erb(:word)
end

post('/words/:string_form/:part_of_speech') do
  new_meaning = params.fetch('meaning')
  part_of_speech = params.fetch('part_of_speech')
  @word = Word.find(params.fetch('string_form'))
  definition = @word.find_definition(part_of_speech)
  definition.add_meaning(new_meaning)
  @edit = false
  erb(:word)
end

get('/words/:string_form/definitions/new') do
  @string_form = params.fetch('string_form')
  erb(:definition_form)
end

get('/:string_form/newline/:part_of_speech') do
  @string_form = params.fetch('string_form')
  word = Word.find(@string_form)
  @part_of_speech = params.fetch('part_of_speech')
  erb(:line_form)
end

get('/words/:string_form/:part_of_speech/edit/:index') do
  @index = params.fetch('index').to_i
  @word = Word.find(params.fetch('string_form'))
  @definition = @word.find_definition(params.fetch('part_of_speech'))
  @line = @definition.meanings[@index]
  @edit = true
  erb(:word)
end

post('/words/:string_form/:part_of_speech/edit/:index') do
  @word = Word.find(params.fetch('string_form'))
  definition = @word.find_definition(params.fetch('part_of_speech'))
  index = params.fetch('index').to_i
  definition.meanings[index] = params.fetch('line')
  @edit = false
  erb(:word)
end
