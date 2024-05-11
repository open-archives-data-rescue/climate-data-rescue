module FileAttachment

  module ClassMethods
    Paperclip.interpolates :avatar_file_name do |attachment, style|
      attachment.instance.avatar_file_name
    end

    Paperclip.interpolates :image_file_name do |attachment, style|
      attachment.instance.image_file_name
    end

    # Page and User Avatar use the same pattern
    def page_url(args)
      if args[1].present?
        args[1][:url] = attachment_url_str
      else
        args << {url: attachment_url_str }
      end
      args
    end

    # Field Option & Content use the same pattern
    def image_url(args)
      if args[1].present?
        args[1][:url] = image_url_str
      else
        args << {url: image_url_str }
      end
      args
    end

    def avatar_url(args)
      if isDraw?
        args = page_url(args)
      else
        if args[1].present?
          args[1][:url] = "/uploads/:class/:style/:avatar_file_name"
        else
          args << {url: "/uploads/:class/:style/:avatar_file_name"}
        end
      end

      args
    end

    # problem for /uploads/:class/:style/:image_file_name
    # image_file_name is not found
    def attachment_url_str
      if isDraw?
        "/system/:attachment/:style/:hash.:extension"
      else
        "/uploads/:class/:style/:image_file_name"
      end
    end

    def image_url_str
      if isDraw?
        "/system/:class/:style/:hash.:extension"
      else
        "/uploads/:class/:style/:image_file_name"
      end
    end

    # Test to see if we are using the draw environment
    def isDraw?
      ENV["DRAW_ENV"] == "DRAW"
    end

    # ECCC vs DRAW
    # Page
    #  "/uploads/:class/:style/:image_file_name"
    #  "/system/:attachment/:style/:hash.:extension"
    # User
    #  "/uploads/:class/:style/:avatar_file_name"
    #  "/system/:attachment/:style/:hash.:extension"
    # Content
    #  "/uploads/:class/:style/:image_file_name"
    #  "/system/:class/:style/:hash.:extension"
    # Field Option
    #  "/uploads/:class/:style/:image_file_name"
    #  "/system/:class/:style/:hash.:extension"
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end
