require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the word path', {:type => :feature}) do
  it('processes user input to display a unique success page') do
    visit('/')
    click_link('Add word')
    fill_in('word', :with => 'run')
    click_button('Submit')
    expect(page).to have_content('You have successfully added the word run!')
  end

  it('processes user input to add word for display on dictionary page') do
    visit('/words/new')
    fill_in('word', :with => 'run')
    click_button('Submit')
    click_link('Go back to the Dictionary')
    expect(page).to have_content('run')
  end

  it('will not allow a word to be added twice') do
    Word.clear()
    visit('/words/new')
    fill_in('word', :with => 'run')
    click_button('Submit')
    click_link('Go back to the Dictionary')
    click_link('Add word')
    fill_in('word', :with => 'run')
    click_button('Submit')
    expect(page).to have_content('The word run is already in your dictionary.')
  end

  it('allows a user to remove a word') do
    Word.clear()
    visit('/words/new')
    fill_in('word', :with => 'run')
    click_button('Submit')
    click_link('Go back to the Dictionary')
    click_link('run_remove')
    expect(page).to have_no_content('run')
  end
end

describe('the definition path', {:type => :feature}) do
  it('processes user input for new definition and displays it on the word page') do
    Word.clear()
    visit('/words/new')
    fill_in('word', :with => 'run')
    click_button('Submit')
    click_link('Go back to the Dictionary')
    click_link('run')
    click_link('Add definition')
    fill_in('part_of_speech', :with => 'verb')
    fill_in('meaning', :with => 'move at a speed faster than a walk')
    click_button('Submit')
    expect(page).to have_content('move at a speed faster than a walk')
  end

  it('allows user to add lines to an existing definition') do
    visit('/words/run')
    click_link('line_add')
    fill_in('meaning', :with => 'move about in a hurried and hectic way')
    click_button('Add')
    expect(page).to have_content('move about in a hurried and hectic way')
  end
end
