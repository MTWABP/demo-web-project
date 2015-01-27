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
    Pusher.log = function(message) {
      if (window.console && window.console.log) {
        window.console.log(message);
      }
    };
    var pusher = new Pusher("${pusher_app_key}");
    var channel = pusher.subscribe("${pusher_app_channel}");
    channel.bind('new_message', function(data) {
      $('#messages').prepend("<p><b>"+data.name+"</b> - "+data.body+"</p>");
    });
    
    
    
    $('#send').click(function(ev) {
      $.post('/cs480/chat', {
        name: $('#name').val(),
        body: $('#body').val(),
        exclude: pusher.sessionID
      }, function(res) {
        $('#body').val('').focus();
      });
    });
  </script>
</body>
</html>