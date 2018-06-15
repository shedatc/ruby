require 'libnotify'

module Say

  @@ICON_DIRECTORY = '/usr/share/icons/Adwaita/32x32'
  @@ICON_PATH_FOR = {
    'mu4e' => 'emblems/emblem-mail.png'
  }

  def Say.whisper(msg, origin=nil)
    Say.ex(msg, :low, origin)
  end

  def Say.say(msg, origin=nil)
    Say.ex(msg, :normal, origin)
  end

  def Say.shout(msg, origin=nil)
    Say.ex(msg, :critical, origin)
  end

  def Say.ex(msg, urgency=nil, origin=nil)
    if urgency.nil?
      urgency = :normal
    end
    if origin.nil?
      summary = `hostname -s`.capitalize
    else
      summary = origin
    end
    if not @@ICON_PATH_FOR[origin].nil?
      icon_path = @@ICON_DIRECTORY << '/' << @@ICON_PATH_FOR[origin]
    end
    Libnotify.show(
      :body      => msg,
      :summary   => summary,
      :timeout   => 30,
      :urgency   => urgency,
      :icon_path => icon_path
    )
  end

end
