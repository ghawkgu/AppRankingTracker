google.load("visualization", "1", {packages:["corechart"]});
var options = {
    title: 'Ranking',
    curveType: 'none',
    vAxis: {
        direction: -1,
        baselineColor: '#CCC',
        format:'###'
    },
    hAxis: {
        format: 'M-d HH:mm'
    }
};

function drawChart() {
    var table = new google.visualization.DataTable();
    table.addColumn('datetime', 'Sample time');
    table.addColumn('number', 'Gross ranking');
    table.addColumn('number', 'Category ranking');
    grossRankings = $('li.gross_ranking');
    $('li.' + 'ranking').each(function(index, categoryRanking){
        var rank = $(categoryRanking);
        var gRank = $(grossRankings[index]);
        var time = new Date();
        time.setTime(parseInt(rank.attr('update_time'), 10) * 1000);
        var ranking = parseInt(rank.attr('ranking'), 10);
        var gRanking = parseInt(gRank.attr('ranking'), 10);
        table.addRow([time, gRanking, ranking]);
    });
    var chart = new google.visualization.LineChart(document.getElementById('ranking' + '_canvas'));
    chart.draw(table, options);
}

google.setOnLoadCallback(drawChart);
