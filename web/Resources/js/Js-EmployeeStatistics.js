$(document).ready(function () {
    var $selected;
    var $previous = '';
    function isEmail(email) {
        var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        return regex.test(email);
    }
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
            $.each(notes1, function (i, Object) {
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
    var options2 = {
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
            var tooltipEl = $('#chartjs-tooltip2');
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
            $.each(notes2, function (i, Object) {
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
    var ctx1 = $("#myChart1").get(0).getContext("2d");
    var ctx2 = $("#myChart2").get(0).getContext("2d");
    var notes1;
    var notes2;
    var data1;
    var data2;
    $('input[type=email]').change(function () {
        var $this = $(this);
        if (isEmail($(this).val())) {
            if ($this.val() != $previous) {
                $previous = $this.val();
                $.ajax({
                    dataType: 'json',
                    type: "POST",
                    url: "Ct-SelectDataGraph.jsp",
                    data: "Email=" + $this.val(),
                    success: function (data) {
                        if ($this.attr('employee') == 1) {
                            data1 = data;
                        } else {
                            data2 = data;
                        }
                        $.each(data, function (i, Object) {
                            $('#Name' + $this.attr('employee')).val(Object.FirstName + " " + Object.LastName);
                        });
                        carga($this.attr('employee'));
                    }
                });
                $.ajax({
                    dataType: 'json',
                    type: "POST",
                    url: "Ct-SelectNotes.jsp",
                    data: "Email=" + $this.val(),
                    success: function (data) {
                        if ($this.attr('employee') == 1) {
                            notes1 = data;
                        } else {
                            notes2 = data;
                        }
                    }
                });
            }

        }

    });
    function carga(number) {
        var $info;
        if (number == 1)
            $info = data1;
        else
            $info = data2;
        var $labels = new Array();
        var $values = new Array();
        $.each($info, function (i, Object) {
            $labels[i] = Object.CompetenceName;
            $values[i] = Object.Rate;

        });
        var $fillColor;
        var $strokeColor;
        var $pointColor;
        if (number == 1) {
            $fillColor = "rgba(18,129,199,0.2)";
            $strokeColor = "rgba(18,129,199,1)";
            $pointColor = "rgba(18,129,199,1)";
        } else {
            $fillColor = "rgba(203,52,77,0.2)";
            $strokeColor = "rgba(203,52,77,1)";
            $pointColor = "rgba(203,52,77,1)";
        }
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
        if (number == 1)
            var myRadarChart = new Chart(ctx1).Radar(data, options1);
        else
            var myRadarChart = new Chart(ctx2).Radar(data, options2);

    }
    $('#email1').triggerHandler("focus");
    $('#email1').triggerHandler("blur");
    $('input[type=email]').on('keypress', function (event) {
        if (event.which === 13) {
            $(this).triggerHandler("change");
        }
    });
    var e = jQuery.Event("keypress");
    e.which = 13; // # Some key code value
    $("input[type=email]").trigger(e);

});

