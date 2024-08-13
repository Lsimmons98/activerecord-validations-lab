class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: ["Fiction", "Non-Fiction"]}

  validate :clickbait_title

  private

  def clickbait_title
    if title.blank?
      errors.add(:title, "can't be blank")
    else
      clickbait_phrases = ["Won't Believe", "Secret", "Top", "Guess"]
      unless clickbait_phrases.any? { |phrase| title.include?(phrase) }
        errors.add(:title, "must be clickbait-y: include 'Won't Believe', 'Secret', 'Top [number]', or 'Guess'")
      end
    end
  end

end
