$(document).ready(function () {
    var $finished = false;
    var $CompetenceQuestions;
    $(window).bind('beforeunload', function () {
        if( !$finished ){
            return 'Are you sure you want to leave? You havent finished the assessment';
        }else{
            return;
        }
        
    });
    $.ajax({
        dataType: 'json',
        type: "POST",
        url: "Ct-SelectCompetenceQuestions.jsp",
        data: "JobID=" + $('input[name=JobID]').val(),
        success: function (data) {
            $CompetenceQuestions = data;
        }
    });
    function putQuestion($index2) {
        var $index1 = $('select[name=CompetenceSelect]').val();
        var $found = false;
        $.each($CompetenceQuestions, function (i, Competence) {
            if (Competence.CompetenceID == $index1) {
                $.each(Competence.Questions, function (j, Quest) {
                    if (j == $index2) {
                        $found = true;
                        $('textarea[name=QuestionText]').val(Quest.Question);
                        $('input[name=AnswerRate]').val(Quest.Rank);
                        $('textarea[name=Notes]').val(Quest.Notes);
                        $('input[name=Situation]').removeAttr("checked");
                        $('input[name=Targets]').removeAttr("checked");
                        $('input[name=Actions]').removeAttr("checked");
                        $('input[name=Result]').removeAttr("checked");
                    }
                });
            }
        });
        return $found;
    }
    function calculateValue(Quest) {
        var rate1 = $('#Rate1').val();
        var rate2 = $('#Rate2').val();
        var rate3 = $('#Rate3').val();
        var cont = 0;
        var sum = 0;
        if (rate1 != 0 && rate1 != '') {
            cont++;
            sum = sum + Number(rate1);
        }
        if (rate2 != 0 && rate2 != '') {
            cont++;
            sum = sum + Number(rate2);
        }
        if (rate3 != 0 && rate3 != '') {
            cont++;
            sum = sum + Number(rate3);
        }
        var val = 0;
        if (Quest.Situation == true)
            val += .25;
        if (Quest.Targets == true)
            val += .25;
        if (Quest.Actions == true)
            val += .25;
        if (Quest.Result == true)
            val += .25;
        if (cont != 0)
            return (sum / cont) * val;
        else
            return 0;
    }
    $('input[type=checkbox]').change(function () {
        var $isChecked = $(this).prop("checked");
        var $index1 = $('select[name=CompetenceSelect]').val();
        
        var $value = $(this).val();
        $.each($CompetenceQuestions, function (i, Competence) {
            if (Competence.CompetenceID == $index1) {
                var $index2 = Competence.ActualQuestion;
                $.each(Competence.Questions, function (j, Quest) {
                    if (j == $index2) {
                        if ($value == 'Situation') {
                            Quest.Situation = $isChecked;
                        } else if ($value == 'Targets') {
                            Quest.Targets = $isChecked;
                        } else if ($value == 'Actions') {
                            Quest.Actions = $isChecked;
                        } else if ($value == 'Result') {
                            Quest.Result = $isChecked;
                        }
                        Quest.Rank = calculateValue(Quest);
                    }
                });
            }
        });
    });
    $('select[name=CompetenceSelect]').change(function () {
        var $index = $(this).val();
        $('input[name=AnswerRate]').val('');
        $.each($CompetenceQuestions, function (i, Competence) {
            if (Competence.CompetenceID == $index) {
                putQuestion(Competence.ActualQuestion);
            }
        });
    });

    $('input[name=AnswerRate]').change(function () {
        var $index1 = $('select[name=CompetenceSelect]').val();
        //check if it's ppossible to access like an aarray
        $.each($CompetenceQuestions, function (i, Competence) {
            if (Competence.CompetenceID == $index1) {
                var $index2 = Competence.ActualQuestion;
                $.each(Competence.Questions, function (j, Quest) {
                    if (j == $index2) {
                        Quest.Rank = calculateValue(Quest);
                        alert(Quest.Rank);
                    }
                });
            }
        });
    });
    $('textarea[name=Notes]').change(function () {
        var $index1 = $('select[name=CompetenceSelect]').val();
        $.each($CompetenceQuestions, function (i, Competence) {
            if (Competence.CompetenceID == $index1) {
                var $index2 = Competence.ActualQuestion;
                $.each(Competence.Questions, function (j, Quest) {
                    if (j == $index2) {
                        var notes = $('textarea[name=Notes]').val();
                        Quest.Notes = notes;
                    }
                });
            }
        });
    });
    function finishAssessment() {
        var $AssessmentID = $('input[name=AssessmentID]').val();
        $.each($CompetenceQuestions, function (i, Competence) {
            $.each(Competence.Questions, function (j, Quest) {
                $.ajax({
                    dataType: 'json',
                    type: "POST",
                    url: "Ct-AddAsessmentResult.jsp",
                    data: "AssessmentID=" + $AssessmentID +
                            "&QuestionID=" + Quest.QuestionID +
                            "&Notes=" + Quest.Notes +
                            "&Value=" + Quest.Rank,
                    success: function (data) {
                    }, error: function (e, data) {
                    }
                });
            });
        });
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-FinishAssessment.jsp",
            data: "AssessmentID=" + $AssessmentID,
            success: function (data) {
                // REDIRECT TO THE GRAPHICS
                location.href = 'EmployeeStatistics.jsp?Email=' + $('input[name=Email]').val();
            }, error: function () {
                alert('Session Error');
            }
        });
    }
    $('#nextQuestion').click(function(){
        var $index1 = $('select[name=CompetenceSelect]').val();
        $.each($CompetenceQuestions, function (i, Competence) {
            if (Competence.CompetenceID == $index1) {
                var $index2 = Number(Competence.ActualQuestion);
                var possible = putQuestion($index2+1);
                if( !possible ){
                    $("select[name=CompetenceSelect] option[value='" + $index1 + "']").remove();
                    $('textarea[name=QuestionText]').val('');
                    $('input[name=AnswerRate]').val('');
                    $('textarea[name=Notes]').val('');
                    $('input[name=Situation]').removeAttr("checked");
                    $('input[name=Targets]').removeAttr("checked");
                    $('input[name=Actions]').removeAttr("checked");
                    $('input[name=Result]').removeAttr("checked");
                    if( $("select[name=CompetenceSelect] option").size() == 1 ){
                        $('#nextQuestion').attr('disabled','disabled'); 
                        alert("Assessment is over");
                        $finished = true;
                        finishAssessment();
                    }
                }else{
                    Competence.ActualQuestion = $index2+1;
                }
            }
        });
    });
});

