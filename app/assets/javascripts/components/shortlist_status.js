(function() {
  function ShortlistStatus(form) {
    this.form = form;

    this.selector = this.form.querySelector('select');

    this._handleStatusChange = this._handleStatusChange.bind(this);
    this._handleStatusUpdated = this._handleStatusUpdated.bind(this);

    this._bindEvents();
  }

  ShortlistStatus.prototype._bindEvents = function() {
    this.selector.addEventListener('change', this._handleStatusChange);
  }

  ShortlistStatus.prototype._handleStatusChange = function(e) {
    this.selector.classList.add('is-loading');

    this._submitStatusChange()
      .then(this._handleStatusUpdated)
  }

  ShortlistStatus.prototype._submitStatusChange = function() {
    var request = new Request(this.form.getAttribute('action'), {
			headers: {
        'X-Requested-With': 'XMLHttpRequest',
      },
			credentials: 'same-origin',
			method: this.form.getAttribute('method'),
      body: new FormData(this.form)
    });

    return fetch(request);
  }

  ShortlistStatus.prototype._handleStatusUpdated = function() {
    this.selector.classList.remove('is-loading')
  }

  window.ShortlistStatus = ShortlistStatus;
})();
