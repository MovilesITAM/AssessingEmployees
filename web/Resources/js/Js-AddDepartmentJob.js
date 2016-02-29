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
                    location.reload();
                }
                
           }
        });
    });
    $('select[name=DepartmentSelectJob]').change(function(){
        var $DepartmentID = $(this).val();
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-SelectJob.jsp",
            data: "DepartmentID=" + $DepartmentID,
            success: function(data){
                $("#JobTable").find('tbody').empty();
                $.each(data, function (i, Job) {
                    $("#JobTable").find('tbody').append($('<tr>').append($('<td>')
                            .text(Job.Name))
                        .append($('<td>')
                            .text(Job.Description))
                    );
                });
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
                     location.reload();
                }else if( data.error == '-1'){
                    alert("Impossible to add the job. Please check your session");
                }else{
                    alert("There was an error, Check with the administrator");
                }
           }           
        });
    });
});
