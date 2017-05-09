class Book < ActiveRecord::Base
  has_many :chapters
  has_many :cards, through: :chapters
  has_many :memories, through: :chards

  def self.crawl_from_quizlet(url)
    # url="https://quizlet.com/126205706/day-17-flash-cards/"
    require 'open-uri'
    if url =~ /https:\/\/quizlet\.com\/\d+\/.+/
      doc = Nokogiri::HTML(open(url), nil, 'utf-8')
      result = Array.new
      doc.css('.SetPage-term').each do |term|
        temp = {
          question: term.css('.SetPageTerm-wordText span').text,
          q_lang: term.css('.SetPageTerm-wordText span')[0]['class'].gsub(/.*lang-(.*)/, "#{$1}"),
          answer: term.css('.SetPageTerm-definitionText span').inner_html,
          a_lang: term.css('.SetPageTerm-definitionText span')[0]['class'].gsub(/.*lang-(.*)/, "#{$1}")
        }
        result << temp
      end
      return result
    else
      p "invalid url"
      return false
    end
  end

  def self.get_quizlet(book_title, chap_title, url)
    cards = Book.crawl_from_quizlet(url)
    if cards.present?
      book = Book.find_or_create_by(title: book_title)
      chap = Chapter.create(book_id: book.id, title: chap_title)
      cards.each do |card|
        Card.create(chapter_id: chap.id,
                    question: card[:question],
                    q_lang: card[:q_lang],
                    answer: card[:answer],
                    a_lang: card[:a_lang]
                   )
      end
    end
  end

  def self.get_folder_from_quizlet(url)
    require 'open-uri'
    if url =~ /https:\/\/quizlet\.com\/.+\/folders\/.+\/sets/
      browser = Watir::Browser.new(:phantomjs)
      browser.goto(url)
      doc = Nokogiri::HTML(browser.html, nil, 'utf-8')
      title = doc.css('.DashboardHeaderTitle-main').text
      links = doc.css('.DashboardListItem .UILinkBox')
        .map{|link| {title: link.css('.UILinkBox-inner .SetPreview-cardHeaderTitle').text, link: link.css('.UILinkBox-link a.UILink').attr('href').text}}
        .sort_by{|h| h[:link].scan(/https:\/\/quizlet.com\/\d+\/(.+)\//)}
      p title
      links.each do |link|
        p link
        self.get_quizlet(title, link[:title], link[:link])
      end
    else
      p "invalid url"
    end
  end
end
