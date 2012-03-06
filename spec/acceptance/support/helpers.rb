module HelperMethods
  def click(content)
    click_link_or_button(content)
  end

  def login(user = nil)
    visit home_path
    user ||= User.create :username => 'test_user', :password => 'abcd1234', :password_confirmation => 'abcd1234'
    click 'Login'
    within '#loginForm' do
      fill_in 'Username', :with => user.username
      fill_in 'Password', :with => user.password
      click 'Login'
    end
    user
  end
  
  def should_be_on(path)
    current_path.should eql(path)
  end
  
  def should_not_be_on(path)
    current_path.should_not eql(path)
  end
  
  def current_path
    URI.parse(current_url).path
  end
  
  def fill_in_the_following(fields)
    fields.each_pair do |field, value|
      fill_in field, :with => value
    end
  end
  
  def lorem(word_count = 50)
    words = [
      'sunt', 'iure', 'nam', 'nobis', 'eum', 'cum', 'officiis', 'excepturi',
      'odio', 'consectetur', 'quasi', 'aut', 'quisquam', 'vel', 'eligendi',
      'itaque', 'non', 'odit', 'tempore', 'quaerat', 'dignissimos',
      'facilis', 'neque', 'nihil', 'expedita', 'vitae', 'vero', 'ipsum',
      'nisi', 'animi', 'cumque', 'pariatur', 'velit', 'modi', 'natus'
    ]
    paragraph = []
    word_count.times do |i|
      paragraph << words[rand(words.length-1)]
    end
    paragraph.join(' ')
  end
  
  def screenshot
    path = File.join(Rails.root, 'tmp', "webkit_screenshot-#{Time.now.to_i}.png").to_s
    page.driver.render(path)
    `open #{path}`
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance