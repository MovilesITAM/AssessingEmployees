$(document).ready(function(){
    $('#btnAddDepartment').click(function() {
      var $name = $('input[name=DepartmentName]').val();
      var $description = $('textarea[name=DepartmentDescription]').val();
      $.ajax({
            dataType: 'json',
            type: "POST",
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
    $('#btnAddJob').click(function(){
        var $DepartmentID = $('select[name=DepartmentSelect]').val();
        var $name = $('input[name=JobName]').val();
        var $description = $('textarea[name=JobDescription]').val();
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-AddJob.jsp",
            data: "Name=" + $name +
            "&Description=" + $description +
            "&DepartmentID=" + $DepartmentID,
            success: function(data){
                if(data.Error == '0'){
                    alert("Job Added Correctly");
                    $('input[name=JobName]').val(' ');
                    $('textarea[name=JobDescription]').val(' ');
                }else if( data.error == '-1'){
                    alert("Impossible to add the job. Please check your session");
                }else{
                    alert("There was an error, Check with the administrator");
                }
           }           
        });
    });
});
