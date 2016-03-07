$(document).ready(function () {
    var Employees;
    var dataG;
    var notes;
    var Tasks;
    var $AssessmentID;
    var ctx1 = $("#myChart1").get(0).getContext("2d");
    $(window).keydown(function (event) {
        if (event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });
    //Hide the task options
    $("#taskDiv").hide();
    $("#appraisalDiv").hide();
    $("#btnTask").click(function(){
        $("#taskDiv").toggle(600);
    });
    $("#btnAppraisal").click(function(){
        $("#appraisalDiv").toggle(600);
    });
    var options1 = {
        scaleShowLine: true,
        angleShowLineOut: true,
        scaleShowLabels: false,
        scaleBeginAtZero: true,
        angleLineColor: "rgba(0,0,0,.1)",
        angleLineWidth: 1,
        pointLabelFontFamily: "'Arial'",
        pointLabelFontStyle: "normal",
        pointLabelFontSize: 10,
        pointLabelFontColor: "#666",
        pointDot: true,
        pointDotRadius: 3,
        pointDotStrokeWidth: 1,
        pointHitDetectionRadius: 20,
        datasetStroke: true,
        datasetStrokeWidth: 2,
        datasetFill: true,
        tooltipTemplate: "<%if (label){%><%=label %>: <%}%><%= value %>",
        multiTooltipTemplate: "<%= value %>",
        customTooltips: function (tooltip) {
            var tooltipEl = $('#chartjs-tooltip');
            if (!tooltip) {
                tooltipEl.css({
                    opacity: 0
                });
                return;
            }
            tooltipEl.removeClass('above below');
            tooltipEl.addClass(tooltip.yAlign);
            var parts = tooltip.text.split(":");
            var $notes = '<ul>';
            $.each(notes, function (i, Object) {
                if (Object.CompetenceName.trim() == parts[0].trim() && Object.Notes.trim() != '') {
                    $notes += '<li>' + Object.Notes.trim() + '</li>';
                }
            });
            $notes += '</ul>';
            var innerHtml = '<span>' + parts[0].trim() + '</span> : <span><b>' + parts[1].trim() + '</b><br/>' + $notes + '</span>';
            tooltipEl.html(innerHtml);
            tooltipEl.css({
                opacity: 1,
                left: tooltip.chart.canvas.offsetLeft + tooltip.x + 'px',
                top: tooltip.chart.canvas.offsetTop + tooltip.y + 'px',
                fontFamily: tooltip.fontFamily,
                fontSize: tooltip.fontSize,
                fontStyle: tooltip.fontStyle
            });
        }
    };
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
            url: "Ct-SelectEmployeeJob.jsp",
            data: "JobID=" + $JobID,
            success: function (data) {
                Employees = data;
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
    function chargeTask() {
        var $EmployeeID = $('select[name=EmployeeSelect]').val();
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-SelectTask.jsp",
            data: "EmployeeID=" + $EmployeeID,
            success: function (data) {
                Tasks = data;
                $("#TaskTable").find('tbody').empty();
                $.each(data, function (i, Task) {
                    var $Efficiency = Task.Efficiency;
                    var $checked;
                    if (Task.Done)
                        $checked = 'checked';
                    $("#TaskTable").find('tbody').append($('<tr>').append($('<td>')
                            .html('<span name="DeleteButton"  task=' + i + ' class="glyphicon glyphicon-remove"></span>'))
                            .append($('<td>')
                                    .text(Task.Name)
                                    ).append($('<td>')
                            .text(Task.StartDate)
                            ).append($('<td>')
                            .text(Task.EndDate)
                            ).append($('<td>')
                            .html('<input class="form-control rank" type="number" min="0" max="100" name="Efficiency" task=' + i + ' value=' + Task.Efficiency + ' />')
                            ).append($('<td>')
                            .text(Task.Comments))
                            .append($('<td>')
                                    .html('<input type="checkbox"  value=' + i + ' name="Done" ' + $checked + ' />'))
                            );
                });

            }, error: function (e, data) {
                alert(e);
                alert(data);
            }
        });
    }
    $('select[name=EmployeeSelect]').change(function () {
        var $email;
        var $employeeId = $(this).val();
        $.each(Employees, function (i, Employee) {
            if (Employee.EmployeeID == $employeeId)
                $email = Employee.EmailAddress
        });
        charge($email);
        chargeTask();
    });
    function makeGraph() {
        var $labels = new Array();
        var $values = new Array();
        $.each(dataG, function (i, Object) {
            $AssessmentID = Object.AssessmentID;
            $labels[i] = Object.CompetenceName;
            $values[i] = Object.Rate;
        });
        var $fillColor;
        var $strokeColor;
        var $pointColor;
        $fillColor = "rgba(18,129,199,0.2)";
        $strokeColor = "rgba(18,129,199,1)";
        $pointColor = "rgba(18,129,199,1)";
        var data = {
            labels: $labels,
            datasets: [{
                    label: "My First dataset",
                    fillColor: $fillColor,
                    strokeColor: $strokeColor,
                    pointColor: $pointColor,
                    pointStrokeColor: "#fff",
                    data: $values
                }]
        }
        var myRadarChart = new Chart(ctx1).Radar(data, options1);

    }
    function charge($email) {
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "../ManageAssessment/Ct-SelectDataGraph.jsp",
            data: "Email=" + $email,
            success: function (data) {
                dataG = data;
                makeGraph();
            }
        });
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "../ManageAssessment/Ct-SelectNotes.jsp",
            data: "Email=" + $email,
            success: function (data) {
                notes = data;
            }
        });
    }

    $('#addTask').click(function () {
        var $EmployeeID = $('select[name=EmployeeSelect]').val();
        var $Name = $('input[name=TaskName]').val();
        var $StarDate = $('input[name=StartDate]').val();
        var $EndDate = $('input[name=EndDate]').val();
        var $Comments = $('textarea[name=Comments]').val();
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-AddTask.jsp",
            data: "EmployeeID=" + $EmployeeID +
                    "&Name=" + $Name +
                    "&StarDate=" + $StarDate +
                    "&EndDate=" + $EndDate +
                    "&Comments=" + $Comments,
            success: function (data) {
                chargeTask();
            }
        });
    });
    $(document).on('click', 'span[name=DeleteButton]', function () {
        var $index = $(this).attr('task');
        $.each(Tasks, function (i, task) {
            if ($index == i) {
                $.ajax({
                    dataType: 'json',
                    type: "POST",
                    url: "Ct-DeleteTask.jsp",
                    data: "TaskID=" + task.TaskID,
                    success: function (data) {
                        if (data.Error == 0) {
                            alert("Task Deleted Correctly");
                            chargeTask();
                        } else {
                            alert("Error, Please Check Your session");
                        }
                    }
                });
            }

        });
    });
    function updateTask($index) {
        $.each(Tasks, function (i, task) {
            if ($index == i) {
                var $Done = 0;
                if (task.Done)
                    $Done = 1;
                $.ajax({
                    dataType: 'json',
                    type: "POST",
                    url: "Ct-UpdateTask.jsp",
                    data: "TaskID=" + task.TaskID +
                            "&Done=" + $Done +
                            "&Efficiency=" + task.Efficiency,
                    success: function (data) {
                        if (data.Error == 1)
                            alert('Error, Please Check your session');
                    }
                });
            }
        });
    }
    $(document).on('change', 'input[name=Efficiency]', function () {
        var $index = $(this).attr('task');
        var $value = $(this).val();
        $.each(Tasks, function (i, task) {
            if ($index == i) {
                task.Efficiency = $value;
                updateTask($index);
            }
        });
    });
    $(document).on('change', 'input[name=Done]', function () {
        var $index = $(this).val();
        var $value = 0;
        if ($(this).is(":checked")) {
            $value = 1;
        }
        $.each(Tasks, function (i, task) {
            if ($index == i) {
                task.Done = $value;
                updateTask($index);
            }
        });
    });
    $('#addWeight').click(function () {
        var $weight = $('input[name=Weight]').val();
        var $comments = $('textarea[name=CommentsAppraisal]').val();
        var $competenceID = $('select[name=CompetenceSelect]').val();
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-AddAppraisal.jsp",
            data: "AssessmentID=" + $AssessmentID +
                    "&Weight=" + $weight +
                    "&Comments=" + $comments +
                    "&CompetenceID=" + $competenceID,
            success: function (data) {
                if (data.Error == 1)
                    alert('Error, Please Check your session');
                else{
                    alert('Weight correctly added');
                    $('textarea[name=CommentsAppraisal]').val('');
                    $('input[name=Weight]').val('');
                }
                    
            }
        });
    });
    
});
