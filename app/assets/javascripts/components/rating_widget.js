(function(){
  function RatingWidget(container){
    this.container = container;

    this.cacheKey = this.container.dataset.cacheKey;
    this.selectedIndex = null;

    this.field = container.querySelector('.js-rating-field');
    this.selects = container.querySelectorAll('.js-rating-select');

    this.highlight = this.highlight.bind(this);
    this.unhighlightAll = this.unhighlightAll.bind(this);

    this._bindEvents();
    this._restoreCachedRating();
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

    var rating = e.currentTarget.dataset.rating;

    this.setRating(rating);
    this.setCachedRating(rating);
  }

  RatingWidget.prototype._restoreCachedRating = function() {
    var cachedRating = this.getCachedRating();

    if(cachedRating) {
      this.setRating(cachedRating);
    }
  }

  RatingWidget.prototype.setRating = function(rating) {
    this.field.setAttribute('value', rating);

    // Set the selectedIndex to refer to the position of the highlighted item
    var selectsArray = Array.from(this.selects);
    this.selectedIndex = selectsArray.findIndex((select) => {
      return select.dataset.rating == rating;
    });

    this.highlight(this.selectedIndex);

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

  RatingWidget.prototype.setCachedRating = function(rating) {
    window.localStorage.setItem(this.cacheKey, rating.toString());
  }

  RatingWidget.prototype.getCachedRating = function() {
    var cachedScoreString = window.localStorage.getItem(this.cacheKey);

    if(cachedScoreString) {
      return parseInt(cachedScoreString);
    } else {
      return false;
    }
  }

  window.RatingWidget = RatingWidget;
})();
