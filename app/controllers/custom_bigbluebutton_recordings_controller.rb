class CustomBigbluebuttonRecordingsController < Bigbluebutton::RecordingsController
before_filter :is_loggedin?
end
