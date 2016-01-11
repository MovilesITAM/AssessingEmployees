$(document).ready(function(){
    $('select[name=DepartmentSelect]').change(function() {
      var $DepartmentID = $('select[name=DepartmentSelect]').val();
      $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-SelectJob.jsp",
            data: "DepartmentID=" + $DepartmentID,
            success: function(data){
                
                $('select[name=JobSelect]').empty();
                $('select[name=JobSelect]').append($('<option>', { 
                    value: 0,
                    text : 'Choose a Job' 
                }));
                $.each(data, function (i, Job) {
                    $('select[name=JobSelect]').append($('<option>', { 
                        value: Job.JobID,
                        text : Job.Name 
                    }));
                });
           }
        });
    });
});
