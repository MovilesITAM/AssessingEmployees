$(document).ready(function () {
    var dataG;
    var notes;
    var $AssessmentID;
    var ctx1 = $("#myChart1").get(0).getContext("2d");
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
    $('select[name=EmployeeSelect]').change(function () {
        var $employeeId = $(this).val();
        charge($employeeId);
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
    function charge($EmployeeID) {
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "../ManageAssessment/Ct-SelectDataGraph.jsp",
            data: "EmployeeID=" + $EmployeeID,
            success: function (data) {
                dataG = data;
                makeGraph();
            }
        });
        $.ajax({
            dataType: 'json',
            type: "POST",
            url: "../ManageAssessment/Ct-SelectNotes.jsp",
            data: "EmployeeID=" + $EmployeeID,
            success: function (data) {
                notes = data;
            }
        });
    }
});

