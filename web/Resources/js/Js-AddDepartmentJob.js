$(document).ready(function(){
    $('#btnAddDepartment').click(function() {
      var $name = $('input[name=DepartmentName]').val();
      var $description = $('textarea[name=DepartmentDescription]').val();
      $.ajax({
            dataType: 'json',
            type: "GET",
            url: "Ct-AddDepartment.jsp",
            data: "Name=" + $name +
            "&Description=" + $description,
            success: function(data){
                if(data.Error == '1'){
                    alert("Impossible to add the department. Check your session");
                }else{
                    alert("Added Correctly");
                    $('input[name=DepartmentName]').val(' ');
                    $('textarea[name=DepartmentDescription]').val(' ');
                }
                
           }
        });
    });
});
