$(document).ready(function () {
    $('select[name=CompetenceSelect]').change(function(){
        var $CompetenceID = $(this).val();
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "../ManageCompetences/Ct-SelectQuestion.jsp",
            data: "CompetenceID=" + $CompetenceID,
            success: function (data) {
                $("#QuestionsTable").find('tbody').empty();
                $.each(data, function (i, Ques) {
                    if (!Ques.Deleted) {
                        $("#QuestionsTable").find('tbody').append($('<tr>')
                                .append($('<td>')
                                        .text(Ques.Question)
                                        ).append($('<td>')
                                .text(Ques.Value)
                                )
                                );
                    }

                });
            }
        });
    });
    $("select[name=EmployeeSelect]").change(function(){

        var $JobName = $('select[name=JobSelect] option:selected').text();
        var $EmployeeName = $('select[name=EmployeeSelect] option:selected').text();
        $("input[name=JobName]").val($JobName);
        $("input[name=EmployeeName]").val($EmployeeName);
    });
    $('#formAssessment').submit(function () {
        var $EmployeeID = $('select[name=EmployeeSelect]').val();
        if( $EmployeeID >  0 )
            return true;
        else{
            alert("Select an employee.");
             return false;
        }
       
    });


});
