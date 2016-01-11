$(document).ready(function(){
    $('#AddCompetence').click(function() {
      var $name = $('input[name=CompetenceName]').val();
      var $description = $('textarea[name=CompetenceDescription]').val();
      $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-AddCompetence.jsp",
            data: "Name=" + $name +
                  "&Description="+$description,
            success: function(data){
                if(data.Error == '1'){
                    alert("Impossible to add the Competence. Check your session");
                }else{
                    alert("Added Correctly");
                    $('select[name=CompetenceSelect]').append($('<option>', { 
                        value: data.CompetenceID,
                        text : data.Name 
                    }));
                    $("#QuestionsTable").find('tbody').empty();
                    $('select[name=CompetenceSelect]').val(data.CompetenceID).change();
                     $('input[name=CompetenceName]').val('');
                    $('textarea[name=CompetenceDescription]').val('');
                } 
           }
        });
    });
    $('#AddQuestion').click(function() {
      var $CompetenceID = $('select[name=CompetenceSelect]').val();
      var $Question = $('input[name=Question]').val();
      var $Value = $('input[name=Value]').val();
      $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-AddQuestion.jsp",
            data: "CompetenceID=" + $CompetenceID +
                  "&Question=" + $Question +
                  "&Value="+$Value,
            success: function(data){
                if(data.Error == '1'){
                    alert("Impossible to add the Question. Check your session");
                }else{
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
    $('select[name=CompetenceSelect]').change(function(){
        var $CompetenceID = $('select[name=CompetenceSelect]').val();
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
    });
    
});