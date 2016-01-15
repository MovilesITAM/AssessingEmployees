function suma( a , b){
    return a +b;
}

$(document).ready(function(){
    $('#message').hide();
    var $CompetencesJob;
    var $EmployeeID;
    var $ContactID;
    var $FirstName;
    var $MiddleName;
    var $LastName;
    var $EmailAddress;
    var $Phone;
    function cleanCompetence(){
        $('input[name=CompetenceName]').val('');
        $('textarea[name=CompetenceDescription]').val('');
        $("#QuestionsTable").find('tbody').empty();
        $("#CompetencesTable").find('tbody').empty();
    }
    $('select[name=DepartmentSelect]').change(function() {
      var $DepartmentID = $('select[name=DepartmentSelect]').val();
      cleanCompetence();
          $.ajax({
            dataType: 'json',
            type: "POST",
            url: "../ManageCompetences/Ct-SelectJob.jsp",
            data: "DepartmentID=" + $DepartmentID,
            success: function(data){
                $('select[name=JobSelect]').empty();
                $('select[name=JobSelect]').append($('<option>', { 
                    value: 0,
                    text : 'Choose Job' 
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
    $('select[name=JobSelect]').change(function(){
        cleanCompetence();
        var $JobID = $('select[name=JobSelect]').val();
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "../ManageCompetences/Ct-SelectCompetencesJob.jsp",
            data: "JobID=" + $JobID,
            success: function(data){
                $("#CompetencesTable").find('tbody').empty();
                $CompetencesJob = data;
                $.each(data, function (i, Competence) {
                    $("#CompetencesTable").find('tbody').append($('<tr>').append($('<td>')
                            .text(Competence.Name)
                        ).append($('<td>')
                            .html(Competence.Rank)
                        ).append($('<td>')
                            .html('<span name="DetailsButton" competence=' + i + ' class="glyphicon glyphicon-info-sign"><u>Details</u></span>'))
                    );
                });
           }
        });
    });
    
    function CompetenceQuestions( $CompetenceID ){
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "../ManageCompetences/Ct-SelectQuestion.jsp",
            data: "CompetenceID=" + $CompetenceID,
            success: function(data){
                $("#QuestionsTable").find('tbody').empty();
                $.each(data, function (i, Ques) {
                    $("#QuestionsTable").find('tbody').append($('<tr>')
                        .append($('<td>')
                            .text(Ques.Question)
                        ).append($('<td>')
                            .text(Ques.Value)
                        )
                    );
                });   
           }
        });
    }
    $(document).on( 'click', 'span[name=DetailsButton]', function(){
        var $index = $(this).attr('competence');
         $('input[name=CompetenceName]').val($CompetencesJob[$index].Name);
        $('textarea[name=CompetenceDescription]').val($CompetencesJob[$index].Description);
        $('input[name=CompetenceRank]').val($CompetencesJob[$index].Rank);
        $('input[name=CompetenceRank]').attr('disabled','true');
        CompetenceQuestions($CompetencesJob[$index].CompetenceID);
    } );
    $('input[name=AddButton]').click(function(){
         $('#errorList').empty();
         $('#errorList').hide();
        var $Email = $('input[name=Email]').val();
        var $JobID = $('select[name=JobSelect]').val();
        if( $JobID != 0 ){
            $.ajax({
                dataType: 'json',
                type: "POST",
                url: "Ct-SelectEmployeeEmail.jsp",
                data: "Email=" + $Email,
                success: function(data){
                    var $found = false;
                    $.each(data, function (i, Employee) {
                        $found = true;
                        $EmployeeID = Employee.EmployeeID;
                        $ContactID = Employee.ContactID;
                        $FirstName = Employee.FirstName;
                        $MiddleName = Employee.MiddleName;
                        $LastName = Employee.LastName;
                        $EmailAddress = Employee.EmailAddress;
                        $Phone = Employee.Phone;
                    }); 
                    if( !$found ){
                        $('#errorList').append('<li>Email does not exist</li>');
                        $('#message').show();
                        $('#errorList').show();
                    }else{
                        //send job id
                    }
               },
               error:function(e,data){
                   alert(e);
                   alert(data);
               }
            });
        }else{
            $('#errorList').append('<li>Please Choose a Job</li>');
            $('#message').show();
            $('#errorList').show();
        }
        
    });
   
    
});
