(function(){
  function SubmissionTable(tableContainer){
    this.tableContainer = tableContainer;

    this._bindEvents();
  }

  SubmissionTable.prototype._bindEvents = function(){
    this.tableContainer.addEventListener('ajax:success', this._handleSuccess.bind(this));
  }

  SubmissionTable.prototype._handleSuccess = function(e) {
    var response = e.detail[0];

    if(response.status == 'ok') {
      this.replaceTable(response.table);
    } else {
      this.showError(response.error)
    }
  }

  SubmissionTable.prototype.replaceTable = function(newTable) {
    this.tableContainer.innerHTML = newTable;
  }

  SubmissionTable.prototype.showError = function(error) {
    alert(error);
  }

  window.SubmissionTable = SubmissionTable;
})();
