$('[data-report-id]').on('submit', '[data-vote-button="create"]', function(event) {
  event.preventDefault();

  $form = $(event.currentTarget);

  $.ajax({
    type: "POST",
    url: $form.attr('action'),
    dataType: "json",
    success: function(vote) {
      // Create the String version of the form action
      var action = '/reports/' + vote.report_id + '/votes/'+ vote.id;

      // Create the new form element
      var $newForm = $('<form>').attr({
        action: action,
        method: 'delete',
        'data-vote-button': 'delete'
      });

      // Create the new submit input
      var $voteButton = $('<input>').attr({type: 'submit', value: 'Remove vote'});

      // Append the new submit input to the new form
      $newForm.append($voteButton);

      // Replace the old create form with the new remove form
      $form.replaceWith($newForm);
    }
  });
});

$('[data-report-id]').on('submit', '[data-vote-button="delete"]', function(event) {
  event.preventDefault();

  var $form = $(event.currentTarget);

  $.ajax({
    type: "DELETE",
    url: $form.attr('action'),
    dataType: "json",
    success: function() {
      // Find the parent wrapper div so that we can use its data-report-id
      var $report = $form.closest('[data-report-id]');

      // Create the String version of the form action
      var action = '/reports/' + $report.data('report-id') + '/votes';

      // Create the new form for creating a vote
      var $newForm = $('<form>').attr({
        action: action,
        method: 'post',
        'data-vote-button': 'create'
      });

      // Create the new submit input
      var $voteButton = $('<input>').attr({type: 'submit', value: 'vote'});

      // Append the new submit input to the new form
      $newForm.append($voteButton);

      // Replace the old create form with the new remove form
      $form.replaceWith($newForm);
    }
  });
});
