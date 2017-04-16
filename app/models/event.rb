class Event < ActiveRecord::Base
  has_many :tickets, dependent: :destroy #親オブジェクト(Event)が削除されたら、子オブジェクト(ticket)も削除される
  belongs_to :owner, class_name: 'User'


  validates :name, length: { maximum: 50 }, presence: true
  validates :place, length: { maximum: 100 }, presence: true
  validates :content, length: { maximum: 2000 }, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_should_be_before_end_time

  def created_by?(user)
    # user情報がない場合はfalse
    return false unless user
    # owner_idとuser.idが一致するか
    owner_id == user.id
  end

  private

  def start_time_should_be_before_end_time
    return unless start_time && end_time

    if start_time >= end_time
        errors.add(:start_time, 'は終了時間よりも前に設定してください')
    end
  end
end
