// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

// CONFETTI EFFECT
// Original confetti script by Linmiao Xu: https://codepen.io/linrock/pen/Amdhr
// Thoroughly edited for this website by Michael Fruen
$(function() {
  var NUM_CONFETTI = 350,
  COLORS = [
    [85, 71, 106],
    [174, 61, 99],
    [219, 56, 83],
    [244, 92, 68],
    [248, 182, 70]
  ],
  PI_2 = 2 * Math.PI,
  DURATION = 3000; // 1 second

  var canvas = $('#confetti_canvas')[0];
  var context = canvas.getContext('2d');
  var xpos = 0.5;

  window.w = 0;
  window.h = 0;

  var resizeWindow = function() {
    window.w = canvas.width = window.innerWidth;
    window.h = canvas.height = window.innerHeight;
  };

  resizeWindow();

  var mouseMove = function(event) {
    xpos = event.pageX / window.w
  }

  var activate = function() {
    $('#confetti_canvas').addClass('visible');

    window.step = function() {
      var c, j, len, results = [];
      requestAnimationFrame(step);
      context.clearRect(0, 0, w, h);

      for (j = 0, len = confetti.length; j < len; j++) {
        c = confetti[j];
        results.push(c.draw());
      }

      return results;
    };

    $(window).on('resize', resizeWindow);
    $(document).on('mousemove', mouseMove);

    resizeWindow();
    setTimeout(deactivate, DURATION);

    window.step();
  }

  var deactivate = function() {
    $('#confetti_canvas').removeClass('visible');

    setTimeout(function() {
      window.step = function() {};

      $(window).off('resize', resizeWindow);
      $(document).off('mousemove', mouseMove);
    }, 500);
  }

  $('#confetti_button').on('click', activate);

  var randRange = function(a, b) {
    return parseInt((b - a) * Math.random() + a);
  }

  var drawCircle = function(x, y, r, style) {
    context.beginPath();
    context.arc(x, y, r, 0, PI_2, false);
    context.fillStyle = style;
    context.fill();
  }

  window.requestAnimationFrame = window.requestAnimationFrame ||
  window.webkitRequestAnimationFrame ||
  window.mozRequestAnimationFrame ||
  window.oRequestAnimationFrame ||
  window.msRequestAnimationFrame ||
  function(callback) {
    return window.setTimeout(callback, 1000 / 60);
  };

  var Confetti = (function() {
    function Confetti() {
      this.style = COLORS[~~randRange(0, 5)];

      this.rgb = "rgba(" +
      this.style[0] + "," +
      this.style[1] + "," +
      this.style[2];
      // no closing parenth, this gets added later when opacity is added

      this.r = ~~randRange(2, 6);
      this.r2 = 2 * this.r;

      this.replace();
    }

    Confetti.prototype.replace = function() {
      this.opacity = 0;
      this.dop = 0.03 * randRange(1, 4);
      this.x = randRange(-this.r2, w - this.r2);
      this.y = randRange(-20, h - this.r2);
      this.xmax = w - this.r;
      this.ymax = h - this.r;
      this.vx = randRange(0, 2) + (8 * xpos) - 5;
      this.vy = (0.7 * this.r) + randRange(-1, 1);
    };

    Confetti.prototype.draw = function() {
      var ref;
      this.x += this.vx;
      this.y += this.vy;
      this.opacity += this.dop;

      if (this.opacity > 1) {
        this.opacity = 1;
        this.dop *= -1;
      }

      if (this.opacity < 0 || this.y > this.ymax) {
        this.replace();
      }

      if (!((0 < (ref = this.x) && ref < this.xmax))) {
        this.x = (this.x + this.xmax) % this.xmax;
      }

      drawCircle(~~this.x, ~~this.y, this.r, this.rgb + "," + this.opacity + ")");
    };

    return Confetti;
  })();

  confetti = (function() {
    var j, ref, results = [];

    // witchcraft
    for (i = j = 1, ref = NUM_CONFETTI; 1 <= ref ? j <= ref : j >= ref; i = 1 <= ref ? ++j : --j) {
      results.push(new Confetti);
    }

    return results;
  })();
});
