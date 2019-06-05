(function(){
  function Notification(container){
    this.container = container;

    this.closeButton = container.querySelector('.js-notification-close');

    console.log('wotcha')

    this._bindEvents();
  }

  Notification.prototype._bindEvents = function(){
    this.closeButton.addEventListener('click', this._handleClick.bind(this));
  }

  Notification.prototype._handleClick = function(e) {
    this.container.parentNode.removeChild(this.container);
  }

  window.Notification = Notification;
})();
