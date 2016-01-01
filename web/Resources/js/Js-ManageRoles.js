$(document).ready(function(){
    $('#AddEspecialist').click(function() {
      var $EmployeeID = $('input[name=EmployeeEspecialist]').val();
     $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-AddEspecialist.jsp",
            data: "EmployeeID=" + $EmployeeID,
            success: function(data){
                if(data.Error == '1'){
                    alert("Impossible to add the Especialist. Check your session");
                }else{
                    alert("Added Correctly");
                }                
           }
        });
    });
    $('#AddManager').click(function(){
        var $EmployeeID = $('input[name=EmployeeManager]').val();
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-AddManager.jsp",
            data: "EmployeeID=" + $EmployeeID,
            success: function(data){
                if(data.Error == '1'){
                    alert("Impossible to add the Manager. Check your session");
                }else{
                    alert("Added Correctly");
                    $('input[name=EmployeeManager]').val(' ');
                }                
           }
        });
    });
    $('#AddAdministrator').click(function(){
        var $ContactID = $('input[name=ContactAdministrator]').val();
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "Ct-AddAdministrator.jsp",
            data: "ContactID=" + $ContactID,
            success: function(data){
                if(data.Error == '1'){
                    alert("Impossible to add Administrator. Check your session");
                }else{
                    alert("Added Correctly");
                    $('input[name=ContactAdministrator]').val(' ');
                }                
           }
        });
    });
});
