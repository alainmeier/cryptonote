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

$(document).ready(function(){
  $('#unencrypted-message').autosize();

  $('#advanced-fields-link').click(function() {
    $('#advanced-fields').slideToggle();
    return false;
  });
});

$(document).ready(function(){
  var unencryptedField = $('#unencrypted-message');
  var encryptedField = $('#encrypted-message');
  var encryptionKeyField = $('#encryption-key');
  var encryptionSaltField = $('#encryption-salt');
  var encryptionPasswordField = $('#encryption-password');
  var password = randomString(32);

  unencryptedField.keyup(function() {
    var encryptedHash = jQuery.parseJSON(sjcl.encrypt(password, unencryptedField.val()));

    encryptionKeyField.val(encryptedHash['iv']);
    encryptionSaltField.val(encryptedHash['salt']);
    encryptedField.val(encryptedHash['ct']);
    encryptionPasswordField.val(password);
  });
});

$(document).ready(function(){
  var encryptedTextArea = $('#encrypted-message-body p');
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
  encryptedTextArea.text(decryptedMessage);
});