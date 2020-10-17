require 'pry'

RSpec.describe 'index.html' do
  it 'contains a <ul> tag with the correct <li> tags' do
    ul = parsed_html.search('ul').first
    expect(ul).to_not be_nil, "The main <ul> tag is missing!"
    expect(html_file_contents).to include('</ul>'), "Don't forget to include a closing </ul>"

    children = ul.children.select {|child| child.name == "li"}
    expect(children.length).to be >= 3, "Your <ul> tag needs at least three <li> tags, one for each ingredient"
    expect(children[0].text).to match(/2 slices of bread/)
    expect(children[1]).to match(/4 slices of cheese/)
    expect(children[2]).to match(/1 tbsp of butter/)
  end


  it 'contains a nested <ul> tag' do
    ul = parsed_html.search('ul').first
    children = ul.children.select {|child| child.name == "li"}
    subchildren = children.select {|child| child.children.length > 0}
    nested_ul = subchildren.any? {|sc| sc.children.any? {|ch| ch.name == "ul"}}
    nested_children = subchildren.select {|sc| sc.children.any? {|ch| ch.name == "ul"}}.select {|sc| sc.children.length > 1}

    expect(nested_ul).to be == true, "Add a nested <ul> tag inside one of the unordered <li>"
    expect(nested_children[0].children[1].children.length).to be >= 3, "Make sure to list out the three cheese types in the nested list"
  end


