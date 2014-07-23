class CustomBigbluebuttonServersController < Bigbluebutton::ServersController
  before_filter :is_loggedin?
end