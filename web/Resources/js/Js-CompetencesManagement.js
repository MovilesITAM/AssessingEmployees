$(document).ready(function(){
    var $CompetencesJob;
    var $CompetencesNotJob;
    function cleanCompetence(){
        $('input[name=CompetenceName]').val('');
        $('textarea[name=CompetenceDescription]').val('');
        $('input[name=CompetenceRank]').attr('disabled','true');
        $("#QuestionsTable").find('tbody').empty();
        $('input[name=AddButton]').val('Add Competence');
        $('input[name=AddButton]').attr('disabled','true');
    }
    $('select[name=DepartmentSelect]').change(function() {
      var $DepartmentID = $('select[name=DepartmentSelect]').val();
      cleanCompetence();
      $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-SelectJob.jsp",
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
            url: "Ct-SelectCompetencesNotInJob.jsp",
            data: "JobID=" + $JobID,
            success: function(data){
                $CompetencesNotJob = data;
                $('select[name=CompetencesSelect]').empty();
                $('select[name=CompetencesSelect]').append($('<option>', { 
                    value: -1,
                    text : 'Choose Competence' 
                }));
                $.each(data, function (i, Competence) {
                    $('select[name=CompetencesSelect]').append($('<option>', { 
                        value: i,
                        text : Competence.Name
                    }));
                });
           }
        });
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-SelectCompetencesJob.jsp",
            data: "JobID=" + $JobID,
            success: function(data){
                $("#CompetencesTable").find('tbody').empty();
                $CompetencesJob = data;
                $.each(data, function (i, Competence) {
                    $("#CompetencesTable").find('tbody').append($('<tr>').append($('<td>')
                            .html('<span name="DeleteButton"  competence=' + i + ' class="glyphicon glyphicon-remove"></span>'))
                        .append($('<td>')
                            .text(Competence.Name)
                        ).append($('<td>')
                            .html('<input class="form-control rank" type="number" min="0" max="1000" name="RankCompetence" competence='+ i + ' value='+ Competence.Rank+ ' />')
                        ).append($('<td>')
                            .html('<span name="DetailsButton" competence=' + i + ' class="glyphicon glyphicon-info-sign"><u>Details</u></span>'))
                    );
                });
           }
        });
    });
    $(document).on( 'change', 'input[name=RankCompetence]', function(){
        var $Rank = $(this).val();
        var $JobID = $('select[name=JobSelect]').val();
        var $index = $(this).attr('competence');
        var $CompetenceID = $CompetencesJob[$index].CompetenceID;
        $CompetencesJob[$index].Rank = $Rank;
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-UpdateCompetenceRank.jsp",
            data: "Rank=" + $Rank +
                  "&JobID="+$JobID +
                  "&CompetenceID="+$CompetenceID,
            success: function(data){
                if(data.Error == '1'){
                    alert("Impossible to Modify. Check your session");
                }else{
                    $CompetencesJob[$index].Rank = $Rank;
                }
           }
        });
    } );
    
    function CompetenceQuestions( $CompetenceID ){
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-SelectQuestion.jsp",
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
        $('input[name=AddButton]').attr('disabled','true');
        $('input[name=AddButton]').val('Competence Already Added');
        CompetenceQuestions($CompetencesJob[$index].CompetenceID);
    } );
    $(document).on( 'click', 'span[name=DeleteButton]', function(){
        var $tr = $(this).parent().parent();
        if (confirm('Are you sure you want to delete that competence?')) {
            var $index = $(this).attr('competence');
            var $CompetenceID = $CompetencesJob[$index].CompetenceID;
            var $JobID = $('select[name=JobSelect]').val();
            $.ajax({
                dataType: 'json',
                type: "POST",
                url: "Ct-DeleteCompetenceJob.jsp",
                data: "JobID="+$JobID +
                      "&CompetenceID="+$CompetenceID,
                success: function(data){
                    if(data.Error == '1'){
                        alert("Impossible to delete competence. Check your session");
                    }else{
                        alert("Deleted Correctly");
                        $('select[name=JobSelect]').trigger('change');
                        
                    }
               }
            });
        }
        
    } );
    /*------------------ */
    $('input[name=AddButton]').click(function(){
        var $index = $('select[name=CompetencesSelect]').val();
        var $CompetenceID = $CompetencesNotJob[$index].CompetenceID;
        var $JobID = $('select[name=JobSelect]').val();
        var $Rank = $('input[name=CompetenceRank]').val();
        //We have a valid rank in the input 
        if($Rank.length>0 && !isNaN($Rank)){
            $.ajax({
                dataType: 'json',
                type: "POST",
                url: "Ct-AddCompetenceJob.jsp",
                data: "Rank=" + $Rank +
                      "&JobID="+$JobID +
                      "&CompetenceID="+$CompetenceID,
                success: function(data){
                    if(data.Error == '1'){
                        alert("Impossible to add competence. Check your session");
                    }else{
                        alert("Added Correctly");
                        $('select[name=JobSelect]').trigger('change');
                    }
               }
            });
        }else{
            alert("Please enter a valid rank");
        }
    });
    /*------------------ */
    $('select[name=CompetencesSelect]').change(function(){
        var $index = $('select[name=CompetencesSelect]').val();
        $('input[name=CompetenceRank]').val('');
        if( $index >= 0 ){
            $('input[name=CompetenceName]').val($CompetencesNotJob[$index].Name);
            $('textarea[name=CompetenceDescription]').val($CompetencesNotJob[$index].Description);
            $('input[name=AddButton]').removeAttr('disabled');
            $('input[name=CompetenceRank]').removeAttr('disabled');
            $('input[name=AddButton]').val('Add Competence');
            CompetenceQuestions($CompetencesNotJob[$index].CompetenceID);
        }else{
            cleanCompetence();
        }
        
    });
    
});
