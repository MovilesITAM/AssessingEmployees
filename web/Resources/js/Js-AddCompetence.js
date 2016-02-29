$(document).ready(function () {
    var Questions;
    $('#AddCompetence').click(function () {
        var $name = $('input[name=CompetenceName]').val();
        var $description = $('textarea[name=CompetenceDescription]').val();
        if($name.length>0 && $description.length>0){
            $.ajax({
                dataType: 'json',
                type: "POST",
                url: "Ct-AddCompetence.jsp",
                data: "Name=" + $name +
                        "&Description=" + $description,
                success: function (data) {
                    if (data.Error == '1') {
                        alert("Impossible to add the Competence. Check your session");
                    } else {
                        alert("Added Correctly");
                        $('select[name=CompetenceSelect]').append($('<option>', {
                            value: data.CompetenceID,
                            text: data.Name
                        }));
                        $("#QuestionsTable").find('tbody').empty();
                        $('select[name=CompetenceSelect]').val(data.CompetenceID).change();
                        $('input[name=CompetenceName]').val('');
                        $('textarea[name=CompetenceDescription]').val('');
                    }
                }
            });
        }else{
            alert("Please enter a Competence Name and a Competence Description");
        }
    });
    $('#AddQuestion').click(function () {
        var $CompetenceID = $('select[name=CompetenceSelect]').val();
        var $Question = $('input[name=Question]').val();
        var $Value = $('input[name=Value]').val();
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-AddQuestion.jsp",
            data: "CompetenceID=" + $CompetenceID +
                    "&Question=" + $Question +
                    "&Value=" + $Value,
            success: function (data) {
                if (data.Error == '1') {
                    alert("Impossible to add the Question. Check your session");
                } else {
                    $('input[name=Question]').val('');
                    $('input[name=Value]').val('');
                    $("#QuestionsTable").find('tbody').append($('<tr>')
                            .append($('<td>')
                                    .text($Question)
                                    ).append($('<td>')
                            .text(data.Value)
                            )
                            );

                    alert("Question Added Correctly");

                }
            }
        });
    });
    $('select[name=CompetenceSelect]').change(function () {
        var $CompetenceID = $('select[name=CompetenceSelect]').val();
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "../ManageCompetences/Ct-SelectQuestion.jsp",
            data: "CompetenceID=" + $CompetenceID,
            success: function (data) {
                Questions = data;
                $("#QuestionsTable").find('tbody').empty();
                $.each(data, function (i, Ques) {
                    var value = Ques.Deleted;
                    var checked = '';
                    if (!value)
                        checked = 'checked';
                    $("#QuestionsTable").find('tbody').append($('<tr>')
                            .append($('<td>')
                                    .html('<input type="checkbox"  value=' + i + ' name="deleted" ' + checked + ' />')
                                    )
                            .append($('<td>')
                                    .html('<input class="form-control" type="text" height="30" name="EditQuestion" Question='+ i + ' value="'+ Ques.Question+ '" />')
                                    ).append($('<td>')
                            .html('<input class="form-control rank" type="number" min="0" max="1" name="Weight" Question='+ i + ' value='+ Ques.Value+ ' step=".1"/>')
                            )
                            );
                });

            }
        });
        function updateQuestion($index) {
            $.each(Questions, function (i, Ques) {
                if (i == $index) {
                    $.ajax({
                        dataType: 'json',
                        type: "POST",
                        url: "Ct-UpdateQuestion.jsp",
                        data: "QuestionID=" + Ques.QuestionID +
                                "&Value=" + Ques.Value +
                                "&Question=" + Ques.Question +
                                "&Deleted=" + Ques.Deleted,
                        success: function (data) {
                            if (data.Error == '1') {
                                alert("Impossible to modify the Question. Check your session");
                            }
                        }
                    });
                }

            });
        }
        
        $(document).on('change', 'input[name=EditQuestion]', function () {
            var $index = $(this).attr('Question');
            var $this = $(this);
            $.each(Questions, function (i, Ques) {
                if ($index == i) {
                    Ques.Question = $this.val();
                }
            });
            updateQuestion($index);
        });
        $(document).on('change', 'input[name=Weight]', function () {
            var $index = $(this).attr('Question');
            var $this = $(this);
            $.each(Questions, function (i, Ques) {
                if ($index == i) {
                    Ques.Value = $this.val();
                }
            });
            updateQuestion($index);
        });
        $(document).on('change', 'input[type=checkbox]', function () {
            var $index = $(this).val();
            var $this = $(this);
            $.each(Questions, function (i, Ques) {
                if ($index == i) {
                    Ques.Deleted = !Ques.Deleted;
                    if (Ques.Deleted) {
                        $this.removeAttr("checked");
                    } else {
                        $('input[name=Situation]').prop("checked", true);
                    }
                }

            });
            updateQuestion($index);
        });
    });

});