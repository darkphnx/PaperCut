(function(){
  function RatingWidget(container){
    this.container = container;

    this.field = container.querySelector('.js-rating-field');
    this.selects = container.querySelectorAll('.js-rating-select');

    this.highlight = this.highlight.bind(this);
    this.unhighlightAll = this.unhighlightAll.bind(this);

    this.selectedIndex = null;

    this._bindEvents();
  }

  RatingWidget.prototype._bindEvents = function(){
    this.selects.forEach((select) => {
      select.addEventListener('mouseenter', this._handleHover.bind(this));
      select.addEventListener('click', this._handleClick.bind(this));
    });

    this.container.addEventListener('mouseleave', this._handleUnhover.bind(this));
  }

  RatingWidget.prototype._handleHover = function(e) {
    // Can't perform indexes and slices on a NodeList
    var selectsArray = Array.from(this.selects);
    var hoveredSelectIndex = selectsArray.indexOf(e.currentTarget);

    this.highlight(hoveredSelectIndex);
  }

  RatingWidget.prototype._handleUnhover = function() {
    if(this.selectedIndex == null) {
      this.unhighlightAll();
    } else {
      this.highlight(this.selectedIndex);
    }
  }

  RatingWidget.prototype._handleClick = function(e) {
    e.preventDefault();

    // Can't perform indexes and slices on a NodeList
    var selectsArray = Array.from(this.selects);
    this.selectedIndex = selectsArray.indexOf(e.currentTarget);

    this.field.setAttribute('value', e.currentTarget.dataset.rating)

    this.selects.forEach((select) => {
      select.classList.add('has-text-warning');
      select.classList.remove('has-text-dark');
    });
  }

  RatingWidget.prototype.highlight = function(highlightUpToIndex) {
    this.selects.forEach((select, i) => {
      var icon = select.querySelector('.js-rating-indicator');

      if(i <= highlightUpToIndex) {
        icon.classList.add('fas');
        icon.classList.remove('far');
      } else {
        icon.classList.add('far');
        icon.classList.remove('fas');
      }
    });
  }

  RatingWidget.prototype.unhighlightAll = function() {
    this.selects.forEach((select) => {
      var icon = select.querySelector('.js-rating-indicator');

      icon.classList.add('far');
      icon.classList.remove('fas');
    });
  }

  window.RatingWidget = RatingWidget;
})();
