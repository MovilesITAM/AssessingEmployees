$(document).ready(function(){
    $('#CountrySelect').change(function() {
      var $strCountryRegionCode = $('#CountrySelect').val();
      $.ajax({
            dataType: 'json',
            type: "GET",
            url: "Ct-StateProvince.jsp",
            data: "CountryRegionCode=" + $strCountryRegionCode,
            success: function(data){
                $('#StateProvinceSelect').empty();
                $.each(data, function (i, StateProvince) {
                    $('#StateProvinceSelect').append($('<option>', { 
                        value: StateProvince.StateProvinceID,
                        text : StateProvince.Name 
                    }));
                });
           }
        });
    });
});