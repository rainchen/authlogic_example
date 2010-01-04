# tips from : http://blog.ardes.com/2009/8/4/that-cuking-paperclip
#remove paperclip files
require 'paperclip' unless Paperclip  #make sure it's loaded, else cue intermittent weirdness
module Paperclip::Interpolations
  alias_method :org_attachment, :attachment
  def attachment(att, style)
    "CUKE/" + org_attachment(att, style)
  end
end

After do
  `rm -rf #{"#{RAILS_ROOT}/public/CUKE"}`
end
#end remove paperclip files