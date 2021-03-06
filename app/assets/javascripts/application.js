// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.cookie
//= require foundation
//= require highcharts
//= require ss-standard
//= require jquery.joyride-2.0.1



function setMin(){
  var height = $(window).height();

  if($('.col-side').length){
    $('.col-main').css('min-height', height-145);
  }

  if($('.newgame-inner').length){
    $('.newgame-inner').css('max-height', height-150);
  }
};

$(window).resize(setMin);
$(document).ready(setMin);

var winpercent;
var scorediff;
var ladderskill;

$(document).ready(function() {
  $('.btn-newgame').live('click', function(){
    $('.newgame').toggleClass('hidden');
    $('body').toggleClass('open');
    return false;
  });

  $('.players a.player-btn:not(.disabled)').live('click', function(){
      var inital = $(this).next('input').is(':checked');
      var position = $(this).parents('li').index();

      console.log($(this).parents('li'), position);

      $(this).next('input').click();
      $(this)[inital ? 'removeClass' : 'addClass']('active');

      var checked = $(this).parents('.players').find('a.player-btn.active').length;

      if( checked >= 2 ){
        $(this).parents('.players').find('a.player-btn:not(.active)').addClass('disabled');
      }else{
        $(this).parents('.players').find('a.player-btn:not(.active)').removeClass('disabled');
      }
    });

  Highcharts.setOptions({
    title: {
        text: ''
    },
    chart: {
        backgroundColor: 'transparent',
        margin: [0, 10, 0, 5],
        spacingBottom: 0,
        spacingLeft: 0,
        spacingRight: 0,
        spacingTop: 0
    },
    tooltip: {
      enabled: false
    },
    credits: {
      enabled: false
    },
    legend: {
      enabled: false
    },
    xAxis: {
        title: {
            text: ''
        }
    },
    yAxis: {
      title: {
          text: ''
      },
      gridLineWidth: 0
    }
  });


  // winpercent = new Highcharts.Chart({
  //     chart: {
  //         renderTo: 'winpercent',
  //         type: 'line',
  //     },
  //     series: [{
  //         name: 'Win Percent',
  //         data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
  //     }]
  // });
  //
  // scorediff = new Highcharts.Chart({
  //     chart: {
  //         renderTo: 'scorediff',
  //         type: 'line',
  //     },
  //     series: [{
  //         name: 'Score Diff',
  //         data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
  //     }]
  // });
  //
  // ladderskill = new Highcharts.Chart({
  //     chart: {
  //         renderTo: 'ladderskill',
  //         type: 'line',
  //     },
  //     series: [{
  //         name: 'Ladder Skill',
  //         data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
  //     }]
  // });
});