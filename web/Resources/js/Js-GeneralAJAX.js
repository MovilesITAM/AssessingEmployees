$(document).ready(new function () {
    $('select[name=DepartmentSelect]').change(function () {
        var $DepartmentID = $('select[name=DepartmentSelect]').val();
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "../ManageCompetences/Ct-SelectJob.jsp",
            data: "DepartmentID=" + $DepartmentID,
            success: function (data) {
                $('select[name=JobSelect]').empty();
                $('select[name=JobSelect]').append($('<option>', {
                    value: 0,
                    text: 'Choose Job'
                }));

                $.each(data, function (i, Job) {
                    $('select[name=JobSelect]').append($('<option>', {
                        value: Job.JobID,
                        text: Job.Name
                    }));
                });
            }
        });

    });
    $('select[name=JobSelect]').change(function () {
        var $JobID = $('select[name=JobSelect]').val();
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "../ManageTask/Ct-SelectEmployeeJob.jsp",
            data: "JobID=" + $JobID,
            success: function (data) {
                $('select[name=EmployeeSelect]').empty();
                $('select[name=EmployeeSelect]').append($('<option>', {
                    value: 0,
                    text: 'Choose Employee'
                }));
                $.each(data, function (i, Employee) {
                    $('select[name=EmployeeSelect]').append($('<option>', {
                        value: Employee.EmployeeID,
                        text: Employee.FirstName + ' ' + Employee.LastName
                    }));
                });
            }
        });
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "../ManageCompetences/Ct-SelectCompetencesJob.jsp",
            data: "JobID=" + $JobID,
            success: function (data) {
                $('select[name=CompetenceSelect]').empty();
                // Limpia tabla de preguntas si existe
                if ($("#QuestionsTable").length > 0){
                    $("#QuestionsTable").find('tbody').empty();
                }
                $('select[name=CompetenceSelect]').append($('<option>', {
                    value: 0,
                    text: 'Choose Competence'
                }));
                $.each(data, function (i, Competence) {
                    $('select[name=CompetenceSelect]').append($('<option>', {
                        value: Competence.CompetenceID,
                        text: Competence.Name
                    }));
                });
            }
        });

    });
});


