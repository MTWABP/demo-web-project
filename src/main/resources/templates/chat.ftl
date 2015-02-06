<!DOCTYPE html>
<html>
<head>
  <title>CS480 Chat</title>
  <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>  
  <script src="//js.pusher.com/2.2/pusher.min.js" type="text/javascript"></script>
</head>
<body>
  Enter your name: <input type="text" id="name"><br />
  Message: <input type="text" id="body" />
  <button type="button" id="send">Send</button>
  <div id="messages">
  </div>

  <script type="text/javascript">
    function sendMessage() {
	    $.post('/cs480/chat', {
	        body: $('#body').val(),
	        socket_id: pusher.sessionID
	      }, function(res) {
	        $('#body').val('').focus();
	      });
	}
	function escapeHTML(str) {
		return str.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
	}
	
	
    Pusher.log = function(message) {
      if (window.console && window.console.log) {
        window.console.log(message);
      }
    };
    var pusher = new Pusher("${pusher_app_key}");
    var channel = pusher.subscribe("${pusher_app_channel}");
    channel.bind('new_message', function(data) {
      $('#messages').prepend("<p><b>"+escapeHTML(data.name)+"</b> - "+escapeHTML(data.body)+"</p>");
    });
    
    
    $('#send').click(function(ev) {
      sendMessage();
    });
    
    $('#body').keypress(function(ev) {
    	if (ev.charCode == 13) sendMessage();
    });
  </script>
</body>
</html>