class User < ApplicationRecord
  include FileAttachment

  has_many :transcriptions
  has_many :annotations, through: :transcriptions
  has_many :data_entries
  has_many :pages, through: :transcriptions

  validates :display_name, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  #attachment for user afatar and settings
  has_attached_file *User.avatar_url(
    [
      :avatar,
      styles: {
        :thumb    => ['100x100#',  :jpg, :quality => 70],
        :medium  => ['200x200#',  :jpg, :quality => 70],
        :preview  => ['480x480#',  :jpg, :quality => 70],
        :large    => ['600>',      :jpg, :quality => 70],
        :retina   => ['1200>',     :jpg, :quality => 30]
      },
      :convert_options => {
        :thumb    => '-set colorspace sRGB -strip',
        :preview  => '-set colorspace sRGB -strip',
        :large    => '-set colorspace sRGB -strip',
        :retina   => '-set colorspace sRGB -strip -sharpen 0x0.5'
      },
      default_style: :thumb,
      hash_secret: "SECRET"
    ]
  )

  validates_attachment :avatar,
    :size => { :in => 0..2.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|jpg|png)$/ }

  def name
    display_name.present? ? display_name : email
  end

end
