<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Todo App </title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
</head>
<body>
  <div class="container">
    <br>
    <h2>Todo</h2>
    <br>

    {{ flash.output() }}

    <br>

    <form method="post" autocomplete="off">
        <input type="hidden" name="type" value="new" />
      <div class="input-group">
        <input type="text" class="form-control" placeholder="Todo Name" name="todo_name">
        <input type="text" class="form-control" placeholder="Todo Description" name="todo_desc">
        <div class="input-group-append">
          <button type="submit" class="btn btn-primary">Add New</button>
        </div>
      </div>
    </form>

    <br>

    <table class="table">
      {% for t in todo %}
      {% set t_time = t.timestamp %}
      <tr>
        <td style="width: 200px;">{{ t_time }}</td>
        <td>{{ t.todo_status ? '<s>' ~ t.todo_code ~ '</s>' : t.todo_code }}</td>
        <td>{{ t.todo_status ? '<s>' ~ t.todo_name ~ '</s>' : t.todo_name }}</td>
        <td>{{ t.todo_status ? '<s>' ~ t.todo_desc ~ '</s>' : t.todo_desc }}</td>
        <td style="width: 200px;">
            <div class="float-right">
              <form method="post">
                <input type="hidden" name="type" value="delete" />
                <input type="hidden" name="id" value="{{ t.id }}" />
                <button type="button" class="btn btn-sm btn-danger deleteTodo">Remove</button>
              </form>
            </div>
            <div class="float-right">
                {% set t_encoded = t|json_encode %}
              <a href="#" class="btn btn-sm btn-success" data-toggle="modal" data-target="#editTodo" data-note='{{ t_encoded }}'>Edit</a>&nbsp;
            </div>
        </td>
      </tr>
      {% endfor %}
    </table>
  </div>

  <div class="modal" id="editTodo" tabindex="-1">
    <form method="post">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Edit Todo</h5>
            <button type="button" class="close" data-dismiss="modal">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <input type="hidden" name="type" value="edit" />
            <input type="hidden" name="id" value="" />
            <input type="text" placeholder="Todo Code" name="todo_code" class="form-control"/>
            <textarea placeholder="Todo Name" name="todo_name" class="form-control"></textarea>
            <textarea placeholder="Todo Description" name="todo_desc" class="form-control"></textarea>
            <div class="text-right" style="margin-top: 10px;">
              <div class="custom-control custom-checkbox">
                <input type="checkbox" name="todo_status" class="custom-control-input" id="todo_status" value="1">
                <label class="custom-control-label" for="todo_status">Todo Status?</label>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button type="submit" class="btn btn-primary">Save changes</button>
          </div>
        </div>
      </div>
    </form>
  </div>


  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
  <script>
    $(document).ready(function(){

      $('#editTodo').on('show.bs.modal', function (e) {
        var btn = $(e.relatedTarget);
        var todo = btn.data('todo');
        var $modal = $('#editTodo');
        
        $modal.find('input[name="todo_code"]').val(todo.todo_code);
        $modal.find('textarea[name="todo_name"]').val(todo.todo_name);
        $modal.find('textarea[name="todo_desc"]').val(todo.todo_desc);
        $modal.find('input[name="id"]').val(todo.id);

        if(note.is_done > 0) {
          $modal.find('input[name="todo_status"]').prop('checked', true);
        }else{
          $modal.find('input[name="todo_status"]').prop('checked', false);
        }
      });

      $(document).on('click', '.deleteTodo', function(e){
        e.preventDefault();

        if(confirm('Are you sure?')){
          $(this).closest('form').submit();
        }
      });
    });
  </script>
</body>
</html>