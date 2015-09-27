drawGraph = function(lbls, food, otfd, eelc, egas, ewtr) {
  var data = {
    labels: lbls,
    datasets: [
      {
        data: food,
        label: "食費",
        pointColor:  "rgba(256,  0,  0,1)",
        strokeColor: "rgba(256,192,192,1)",
      },
      {
        data: otfd,
        label: "外食費",
        pointColor:  "rgba(243,152,  0,1)",
        strokeColor: "rgba(256,206,124,1)",
      },
      {
        data: eelc,
        label: "電気代",
        pointColor:  "rgba(256,256,  0,1)",
        strokeColor: "rgba(256,256,192,1)",
      },
      {
        data: egas,
        label: "ガス代",
        pointColor:  "rgba(128,128,128,1)",
        strokeColor: "rgba(192,192,192,1)",
      },
      {
        data: ewtr,
        label: "水道代",
        pointColor:  "rgba(  0,  0,256,1)",
        strokeColor: "rgba(192,192,256,1)",
      },
    ]
  };

  var options = {
    bezierCurve: false,
    datasetFill: false,
    scaleShowVerticalLines: false,
  };

  Chart.defaults.global.animation = false;
  Chart.defaults.global.showTooltips = false;

  Chart.defaults.global.scaleOverride = true;
  Chart.defaults.global.scaleSteps = 6;
  Chart.defaults.global.scaleStepWidth = 2500;
  Chart.defaults.global.scaleStartValue = 0;

  Chart.defaults.global.scaleShowLabels = true;
  Chart.defaults.global.scaleLabel = function(label) {
    return '￥' + label.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  };

  var cxt = $("#graphic").get(0).getContext("2d");
  var lineChart = new Chart(cxt).Line(data, options);
};
