(function(){
  function FileUpload(container){
    this.container = container;

    this.input = container.querySelector('.file-input');
    this.filename = container.querySelector('.file-name');

    this._bindEvents();
  }

  FileUpload.prototype._bindEvents = function(){
    this.input.addEventListener('change', this._handleNewFile.bind(this));
  }

  FileUpload.prototype._handleNewFile = function(e) {
    if(this.input.files.length > 0) {
      this.filename.innerHTML = this.input.files[0].name;
    }
  }

  window.FileUpload = FileUpload;
})();
