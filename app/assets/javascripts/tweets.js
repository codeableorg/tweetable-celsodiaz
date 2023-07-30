// app/assets/javascripts/tweets.js
console.log('tweets.js loaded');
$(document).on('click', '.like-button', function(event) {
    event.preventDefault();
    var $likeButton = $(this);
    var tweetId = $likeButton.data('tweet-id');
  
    $.ajax({
      type: 'POST',
      url: '/tweets/' + tweetId + '/like',
      dataType: 'json',
      success: function(data) {
        var likesCount = data.likes_count;
        $likeButton.find('img').attr('alt', 'likes').next().text(likesCount);
      }
    });
  });
  
  