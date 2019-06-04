(function(){
  function RatingWidget(container){
    this.container = container;

    this.field = container.querySelector('.js-rating-field');
    this.selects = container.querySelectorAll('.js-rating-select');

    this._bindEvents();
  }

  RatingWidget.prototype._bindEvents = function(){
    this.selects.forEach(function(select){
      select.addEventListener('mouseenter', this._handleHoverIn);
      select.addEventListener('mouseleave', this._handleHoverOut);
      select.addEventListener('click', this._handleClick);
    });
  }

  RatingWidget.prototype._handleHoverIn = function() {
    console.log('in');
  }

  RatingWidget.prototype.handleHoverOut = function() {
    console.log('out');
  }

  RatingWidget.prototype.handleClick = function() {
    console.log('click');
  }

  window.RatingWidget = RatingWidget;
})();
