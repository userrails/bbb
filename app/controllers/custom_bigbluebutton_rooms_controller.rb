class CustomBigbluebuttonRoomsController < Bigbluebutton::RoomsController
before_filter :is_loggedin?
end