// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.autosize
//= require sjcl
//= require zeroclipboard
//= require markdown
//= require_tree .

function randomString(length) {
  var result = '';
  var chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  for (var i = length; i > 0; --i) result += chars[Math.round(Math.random() * (chars.length - 1))];
  return result;
}

function getURLParameter(name) {
  return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null;
}

function select_all(el) {
  if (typeof window.getSelection != "undefined" && typeof document.createRange != "undefined") {
    var range = document.createRange();
    range.selectNodeContents(el);
    var sel = window.getSelection();
    sel.removeAllRanges();
    sel.addRange(range);
  } else if (typeof document.selection != "undefined" && typeof document.body.createTextRange != "undefined") {
    var textRange = document.body.createTextRange();
    textRange.moveToElementText(el);
    textRange.select();
  }
}

$(document).ready(function(){
  $('#unencrypted-message').autosize();

  messageField = $('#unencrypted-message');
  $('#message-container').on('click', function(){
    messageField.focus();
  });

  messageField.keydown(function(e) {
    if(e.keyCode == 13 && e.metaKey) {
      $('#create-message').click();
    }
  });
});

$(document).ready(function(){
  var unencryptedField = $('#unencrypted-message');
  var encryptedField = $('#encrypted-message');
  var encryptionKeyField = $('#encryption-key');
  var encryptionSaltField = $('#encryption-salt');
  var encryptionPasswordField = $('#encryption-password');
  var password = randomString(32);

    $("input[name='commit']").on('click',function() {
        var encryptedHash = jQuery.parseJSON(sjcl.encrypt(password, unencryptedField.val()));

        encryptionKeyField.val(encryptedHash['iv']);
        encryptionSaltField.val(encryptedHash['salt']);
        encryptedField.val(encryptedHash['ct']);
        encryptionPasswordField.val(password);
    });
});

$(document).ready(function(){
  var encryptedTextArea = $('#encrypted-message-body pre');
  var encryptedText = encryptedTextArea.text();
  var encryptionKey = $('#key').text().replace(/(\r\n|\n|\r|\s)/gm,"");
  var encryptionSalt = $('#salt').text().replace(/(\r\n|\n|\r|\s)/gm,"");
  var password = getURLParameter("gen_password");

  encryptedRebuilt = JSON.stringify({
    'iv' : encryptionKey,
    'v' : "1",
    'iter' : 1000,
    'ks' : 128,
    'ts' : 64,
    'mode' : "ccm",
    'adata' : "",
    'cipher' : "aes",
    'salt' : encryptionSalt,
    'ct' : encryptedText
  });

  // Show decrypted message
  var decryptedMessage = sjcl.decrypt(password, encryptedRebuilt);
  // decryptedMessage = decryptedMessage.replace(/\n/g, '<br/>');
  // decryptedMessage = decryptedMessage.replace(/\s/g, '&nbsp;');
  // Sanitizes initial user input
  encryptedTextArea.text(decryptedMessage).html();

  // Convert user input markdown to HTML
  decryptedMessage = markdown.toHTML(encryptedTextArea.text());

  // Apply new HTML to the text area
  encryptedTextArea.html(decryptedMessage);
});

function escapeHtml(str) {
  var div = document.createElement('div');
  div.appendChild(document.createTextNode(str));
  return div.innerHTML;
};