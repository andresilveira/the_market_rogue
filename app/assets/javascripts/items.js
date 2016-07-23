$(function(){
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawChartWhenPossible);

  function chartElement() {
    return document.getElementById('chart_div');
  }

  function offerData() {
    var rawOffers = JSON.parse(chartElement().getAttribute('data-offers'));
    return rawOffers.map(function (offer){
      return offerToDataPoint(offer);
    });
  }

  function offerToDataPoint(offer) {
    if (offer.type ==  "BuyingOffer") {
      return [
        new Date(offer.created_at),
        null,
        offer.price
      ];
    }
    else {
      return [
        new Date(offer.created_at),
        offer.price,
        null
      ];
    }
  }

  function drawChart() {
    var chart = new google.visualization.ScatterChart(chartElement());
    var data = new google.visualization.DataTable();
    var options = {
      title: 'Offers over time',
      hAxis: {
        gridlines: -1,
        format: 'M/d',
      },
      vAxis: {
        gridlines: { color: 'none' },
        minValue: 0
      },
    };

    data.addColumn('datetime', 'Date');
    data.addColumn('number', 'Selling');
    data.addColumn('number', 'Buying');
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
