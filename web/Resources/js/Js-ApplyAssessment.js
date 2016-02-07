$(document).ready(function(){
    var $CompetenceQuestions;
    $(window).bind('beforeunload', function(){
        return 'Are you sure you want to leave? You havent finished the assessment';
      });
    $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-SelectCompetenceQuestions.jsp",
            data: "JobID=" + $('input[name=JobID]').val(),
            success: function(data){
                $CompetenceQuestions = data;
           }
        });
    function calculateValue(Quest){
        var rate1 = $('#Rate1').val();
        var rate2 = $('#Rate2').val();
        var rate3 = $('#Rate3').val();
        var cont = 0;
        var sum = 0;
        if( rate1 != 0 && rate1 !='' ){
            cont++;
            sum = sum + Number(rate1) ;
        }
        if( rate2 != 0 && rate2 !='' ){
            cont++;
            sum = sum + Number(rate2) ;
        }
        if( rate3 != 0 && rate3 !='' ){
            cont++;
            sum = sum + Number(rate3) ;
        }
        var val = 0;
        if( Quest.Situation == true ) val+=.25;
        if( Quest.Targets == true ) val+=.25;
        if( Quest.Actions == true ) val+=.25;
        if( Quest.Result == true ) val+=.25;
        if( cont != 0 )
            return (sum/cont)*val;
        else return 0;
    }
    $('input[type=checkbox]').change(function(){
        var $isChecked = $(this).prop( "checked" );
        var $index1 = $('select[name=CompetenceSelect]').val();
        var $index2 = $('select[name=QuestionsSelect]').val();
        var $value = $(this).val();
        $.each($CompetenceQuestions, function (i, Competence) {
            if( Competence.CompetenceID == $index1 ){
                $.each(Competence.Questions, function (j, Quest ) {
                    if( j == $index2 ){
                        if( $value == 'Situation' ){
                            Quest.Situation = $isChecked;
                        }else if($value == 'Targets' ){
                            Quest.Targets = $isChecked;
                        }else if($value == 'Actions' ){
                            Quest.Actions = $isChecked;
                        }else if($value == 'Result' ){
                            Quest.Result = $isChecked;
                        }
                        Quest.Rank = calculateValue(Quest);
                    }
                });
            }
        });
    });
    $('select[name=CompetenceSelect]').change(function(){
        var $index = $(this).val();
        $('select[name=QuestionsSelect]').empty();
        $('input[name=AnswerRate]').val('');
        $.each($CompetenceQuestions, function (i, Competence) {
            if( Competence.CompetenceID == $index ){
                $('select[name=QuestionsSelect]').append($('<option>', { 
                        value: i,
                        text : 'Choose a Question'
                    }));
                $.each(Competence.Questions, function (i, Questions ) {
                    $('select[name=QuestionsSelect]').append($('<option>', { 
                        value: i,
                        text : 'Question ' + (i+1)
                    }));
                });
            }
        });
    });
    $('select[name=QuestionsSelect]').change(function(){
        var $index1 = $('select[name=CompetenceSelect]').val();
        var $index2 = $('select[name=QuestionsSelect]').val();
        $.each($CompetenceQuestions, function (i, Competence) {
            if( Competence.CompetenceID == $index1 ){
                $.each(Competence.Questions, function (j, Quest ) {
                    if( j == $index2 ){
                        $('textarea[name=QuestionText]').val(Quest.Question);
                        $('input[name=AnswerRate]').val(Quest.Rank);
                        $('textarea[name=Notes]').val(Quest.Notes);
                        if( Quest.Situation == true ){
                            $('input[name=Situation]').prop( "checked", true );
                        }else{
                            $('input[name=Situation]').removeAttr("checked");
                        }
                        if( Quest.Targets == true ){
                            $('input[name=Targets]').prop( "checked", true );
                        }else{
                            $('input[name=Targets]').removeAttr("checked");
                        }
                        if( Quest.Actions == true ){
                            $('input[name=Actions]').prop( "checked", true );
                        }else{
                            $('input[name=Actions]').removeAttr("checked");
                        }
                        if( Quest.Result == true ){
                            $('input[name=Result]').prop( "checked", true );
                        }else{
                            $('input[name=Result]').removeAttr("checked");
                        }
                    }
                });
            }
        });
    });
    $('input[name=AnswerRate]').change(function(){
        var $index1 = $('select[name=CompetenceSelect]').val();
        var $index2 = $('select[name=QuestionsSelect]').val();
        //check if it's ppossible to access like an aarray
        $.each($CompetenceQuestions, function (i, Competence) {
            if( Competence.CompetenceID == $index1 ){
                $.each(Competence.Questions, function (j, Quest ) {
                    if( j == $index2 ){
                        Quest.Rank = calculateValue(Quest);
                    }
                });
            }
        });
    });
    $('textarea[name=Notes]').change(function(){
        var $index1 = $('select[name=CompetenceSelect]').val();
        var $index2 = $('select[name=QuestionsSelect]').val();
        $.each($CompetenceQuestions, function (i, Competence) {
            if( Competence.CompetenceID == $index1 ){
                $.each(Competence.Questions, function (j, Quest ) {
                    if( j == $index2 ){
                        var notes = $('textarea[name=Notes]').val();
                        Quest.Notes = notes;
                    }
                });
            }
        });
    });
    function finishAssessment(){
        var $AssessmentID = $('input[name=AssessmentID]').val();
        $.each($CompetenceQuestions, function (i, Competence) {
            $.each(Competence.Questions, function (j, Quest ) {
                $.ajax({
                    dataType: 'json',
                    type: "POST",
                    url: "Ct-AddAsessmentResult.jsp",
                    data: "AssessmentID=" + $AssessmentID + 
                           "&QuestionID=" + Quest.QuestionID + 
                            "&Notes=" + Quest.Notes +
                            "&Value=" + Quest.Rank,
                    success: function(data){
                   },error: function(e, data){
                   }
                });
            });
        });  
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-FinishAssessment.jsp",
            data: "AssessmentID=" + $AssessmentID,
            
            success: function(data){
                // REDIRECT TO THE GRAPHICS
                location.href = 'EmployeeStatistics.jsp?Email=' + $('input[name=Email]').val();
           },error: function(){
               alert('Session Error');
           }
        });
    }
    $('#saveAssessment').click(function(){
        var correct = true;
        $.each($CompetenceQuestions, function (i, Competence) {
            $.each(Competence.Questions, function (j, Quest ) {
                correct = correct && $.isNumeric(Quest.Rank);
                if( $.isNumeric(Quest.Rank) ){
                    correct = correct && (Quest.Rank <= 10 && Quest.Rank >= 0);
                }
            });
        });   
        if(!correct){
            alert("Please rate all the questions");
        }else{
            finishAssessment();
        }
        
    });
});

