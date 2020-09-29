//@flow

/**
 * Prevent use of 'CTRL+v' or 'CTRL+V' in form fields that must not be copied.
 * This doesn't prevent browser native auto complete (e.g. double-clicking into a field) or vendor specific mobile device features.
 *
 * Example use case: Repeating fields for email, or password.
 *
 * @param  {object}  event  Keydown event.
 */
function preventCopyPaste(event) {
  'use strict';

  var element;

  if (event.ctrlKey === true && (event.which === '118' || event.which === '86')) {
    event.preventDefault();

    element = $(event.target);

    if (!element.hasClass('error')) {
      element.addClass('error').after('<span class="error">Please enter this information manually.</span>');
    }
  }
}

// Example use
$('#formfield')
  .on('keydown', preventCopyPaste)
  .on('contextmenu copy paste selectstart dragstart dragend', function (e) {
    return false;
  });
