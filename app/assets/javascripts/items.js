$(function(){
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawChartWhenPossible);

  function chartElement() {
    return document.getElementById('chart_div');
  }

  function offerData() {
    var rawOffers = JSON.parse(chartElement().getAttribute('data-offers'));
    return rawOffers.map(function (offer){
      return [new Date(offer.created_at), offer.price]
    });
  }

  function drawChart() {
    var chart = new google.visualization.ScatterChart(chartElement());
    var data = new google.visualization.DataTable();
    var options = {
      title: 'Offers over time',
      width: 900,
      height: 500,
      hAxis: {
        format: 'M/d/yyyy',
      },
      vAxis: {
        gridlines: { color: 'none' },
        minValue: 0
      },
      trendlines: { 0: {} }
    };

    data.addColumn('date', 'Date');
    data.addColumn('number', 'Price');
    data.addRows(offerData());
    chart.draw(data, options);
  }

  function drawChartWhenPossible() {
    if(chartElement()){
      drawChart();
    }
  }

  $(document).on('turbolinks:load', drawChartWhenPossible);
});
