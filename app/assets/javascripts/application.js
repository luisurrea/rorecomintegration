// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require_tree  ./jquery
//= require_tree  ./layout
//= require foundation

$(window).load(function() {
$("#featured").orbit();
});

$(document).ready(function($) {
    $('.tabs .subtopic').hide();
    $('.tabs .undersubtopic').hide();
    $('.tabs .topic a').click(function() {
        if ($(this).hasClass('selected')) {
            $(this).removeClass('selected');
            $(this).parent().nextUntil('.tabs .topic'||'.tabs').slideUp();
        } else {
            $('.tabs .topic a').removeClass('selected');
            $(this).addClass('selected');
            $('.tabs .subtopic').slideUp();
            $(this).parent().nextUntil('.tabs .topic').slideDown();
        }
        return false;
    });
});

$(function() {
		$( "#datepicker" ).datepicker({
			yearRange: '1910:2000',
			changeMonth: true,
			changeYear: true
		});
	});
	